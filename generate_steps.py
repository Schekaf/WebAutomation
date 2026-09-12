import os
import sys
import gc
from pathlib import Path

from ai_agents.core.config import get_agent_model
from ai_agents.core.lessons_learned_manager import LessonsLearnedManager
from ai_agents.core.step_scanner import get_undefined_steps_via_behave
from ai_agents.core.utils import (
    discover_all_feature_files,
    sanitize_model_tag_for_filename,
    clear_ai_generated_steps_file,
    mine_patterns_with_drain,
)

# Agents
from ai_agents.qa_automation_feasibility_agent.test_automatable_feasibility_agent import AutomationFeasibilityAgent
from ai_agents.qa_test_fixer_agent.test_fixer_agent import TestFixerAgent
from ai_agents.qa_test_step_generator_agent.test_step_skeleton_generator import StepSkeletonGeneratorAgent
from ai_agents.qa_test_step_generator_agent.test_step_generator import StepGeneratorAgent
from ai_agents.qa_test_step_generator_agent.test_step_reviewer import StepReviewAgent


def collect_raw_steps(feature_files: list[str], tag: str | None = None) -> tuple[list[dict], list[str]]:
    """Runs behave dry-run across feature files and returns mapped steps and a flattened list."""
    feature_steps_map = []
    all_raw_steps = []

    for feature_file in feature_files:
        tags_param = [tag] if tag else None
        steps = get_undefined_steps_via_behave([feature_file], tags=tags_param)
        if steps:
            feature_steps_map.append({"file": feature_file, "steps": steps})
            all_raw_steps.extend(steps)

    return feature_steps_map, all_raw_steps


def main():
    print("=" * 65)
    print("🚀 Starting Batch QA Test Step Generator Pipeline")
    print("=" * 65)
    # -------------------------------------------------------------------------
    # 1. Setup Paths & Model Configurations
    # -------------------------------------------------------------------------
    lessons_manager = LessonsLearnedManager()
    project_root = Path(__file__).resolve().parent
    features_dir = project_root / "features"
    steps_dir = features_dir / "steps"
    output_ai_steps_file = steps_dir / "generated_by_ai_steps.py"

    model_name = get_agent_model("TestGeneratorAgent")
    model_slug = sanitize_model_tag_for_filename(model_name)

    print(f"📂 Features Directory : {features_dir}")
    print(f"📝 AI Output File     : {output_ai_steps_file}")
    print(f"🤖 Resolved Model     : {model_name}\n")

    # -------------------------------------------------------------------------
    # 2. Discover Feature Files & Initial Dry-Run
    # -------------------------------------------------------------------------
    feature_files = discover_all_feature_files(str(features_dir), model_slug=model_slug)
    if not feature_files:
        print(f"⚠️ No .feature files found matching suffix '*_{model_slug}.feature'")
        return

    clear_ai_generated_steps_file(str(output_ai_steps_file))

    print("🔍 Phase 2.1: Collecting initial undefined steps...")
    feature_steps_map, all_raw_steps = collect_raw_steps(feature_files)

    if not feature_steps_map:
        print("✅ All steps are already covered by your codebase!")
        return

    # -------------------------------------------------------------------------
    # 3. Mine Patterns & Tag Automatable Scenarios
    # -------------------------------------------------------------------------
    print("\n🦴 Phase 2.2: Mining Drain3 patterns and tagging automatable scenarios...")
    drain_patterns = mine_patterns_with_drain(all_raw_steps)
    automatable_patterns = {p for p in drain_patterns if "<*>" in p}

    feasibility_agent = AutomationFeasibilityAgent(lessons_manager=lessons_manager)
    for feature_file in feature_files:
        feasibility_agent.tag_automatable_scenarios(feature_file, automatable_patterns)

    del feasibility_agent
    gc.collect()

    ## Does it make sense to create one agent whichs job would be to decide if the parameter in step pattern has to be used like "<*>" this or  <*>?

    # -------------------------------------------------------------------------
    # 4. Phase 2.5: TestFixerAgent Step Harmonization & Audit Logging
    # -------------------------------------------------------------------------
    print("\n🔧 Phase 2.5: Harmonizing Gherkin step syntax for automatable scenarios...")
    test_fixer_agent = TestFixerAgent()

    for feature_file in feature_files:
        feature_path = Path(feature_file)
        feedback_file = feature_path.parent / f"{feature_path.stem}_feasibility_feedback.json"

        if feedback_file.exists():
            fix_result = test_fixer_agent.fix_feature_file(
                feature_path=str(feature_path),
                feedback_path=str(feedback_file)
            )

            fixed_gherkin = fix_result.get("harmonized_gherkin", "")
            fixes_applied = fix_result.get("fixes_applied", [])

            # 1. Update the feature file on disk with clean, harmonized Gherkin
            if fixed_gherkin:
                with open(feature_path, "w", encoding="utf-8") as f:
                    f.write(fixed_gherkin)

            # 2. Persist error patterns to ai_agents/core/lessons_learned.json
            if fixes_applied:
                print(f"   📝 Applied {len(fixes_applied)} fix(es) to {feature_path.name}")
                for fix in fixes_applied:
                    lessons_manager.add_lesson(
                        agent_id="TestGeneratorAgent",  # Target agent responsible for original generation
                        category=fix.get("category", "gherkin_syntax"),
                        original_output=fix.get("original_step", ""),
                        corrected_output=fix.get("corrected_step", ""),
                        root_cause=fix.get("root_cause", ""),
                        rule_derived=fix.get("rule_derived", "")
                    )

    del test_fixer_agent
    gc.collect()

    # -------------------------------------------------------------------------
    # 5. Collect Feasible Steps & Generate Step Skeletons
    # -------------------------------------------------------------------------
    print("\n🔄 Phase 3.1: Re-scanning @automatable steps & generating skeletons...")
    _, all_feasible_raw_steps = collect_raw_steps(feature_files, tag="@automatable")

    if not all_feasible_raw_steps:
        print("✅ No new automatable steps require skeleton generation.")
        return

    skeleton_agent = StepSkeletonGeneratorAgent()
    skeletons = skeleton_agent.generate_skeletons(automatable_patterns, all_feasible_raw_steps)

    del skeleton_agent
    gc.collect()

    if not skeletons:
        print("✅ No step skeletons were returned.")
        return

    combined_skeletons = "\n\n".join(skeletons)

    # -------------------------------------------------------------------------
    # 6. Implement Code & Review Syntax (AST Validation)
    # -------------------------------------------------------------------------
    print("\n⚙️ Phase 3.2: Generating step implementation code...")
    step_generator_agent = StepGeneratorAgent()
    draft_code = step_generator_agent.generate_missing_steps(combined_skeletons)

    del step_generator_agent
    gc.collect()

    print("\n🧹 Phase 3.3: Reviewing, sanitizing, and validating AST...")
    step_reviewer_agent = StepReviewAgent()
    cleaned_final_code = step_reviewer_agent.review_and_fix(draft_code)

    del step_reviewer_agent
    gc.collect()

    # -------------------------------------------------------------------------
    # 7. Write Final Implementation to File
    # -------------------------------------------------------------------------
    output_ai_steps_file.parent.mkdir(parents=True, exist_ok=True)
    with open(output_ai_steps_file, "w", encoding="utf-8") as out_f:
        out_f.write(f"# Auto-generated step definitions by Phase 3 Pipeline ({model_name})\n")
        out_f.write("from behave import step, given, when, then\n\n")
        out_f.write(cleaned_final_code + "\n")

    print("\n✨ Step generation pipeline completed successfully!")
    print(f"👉 Generated File: {output_ai_steps_file.resolve()}")


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"\n❌ Pipeline Execution Error: {e}")
        sys.exit(1)
