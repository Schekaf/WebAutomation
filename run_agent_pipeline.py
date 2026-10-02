# Web Automation Framework Empowered by Local AI Agents
# Copyright (C) 2026  A. Furkan KIZILTEPE <furkan.kiziltepe@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
import argparse
import gc
import sys
from pathlib import Path

from ollama import ResponseError

from ai_agents.core.lessons_learned_manager import LessonsLearnedManager
from ai_agents.core.model_selector import print_missing_model_error
from ai_agents.core.schemas import FeatureSuite
from ai_agents.core.step_library import get_escaped_step_patterns, PatternRegistry
from ai_agents.core.tradehub_domain import TRADEHUB_BUSINESS_KNOWLEDGE, TRADEHUB_RAW_INSTRUCTIONS
from ai_agents.core.utils import sanitize_model_tag_for_filename, split_instructions_into_sections, \
    discover_all_feature_files, mine_patterns_with_drain
from ai_agents.qa_automation_feasibility_agent.pattern_audit_agent import PatternAuditAgent
from ai_agents.qa_automation_feasibility_agent.test_automatable_feasibility_agent import AutomationFeasibilityAgent
from ai_agents.qa_coach_agent.test_autamation_feasibility_coach import AutomationFeasibilityCoachAgent
from ai_agents.qa_coach_agent.test_generation_coach import TestGenerationCoachAgent
from ai_agents.qa_coach_agent.test_step_audit_coach import AuditCoachAgent
from ai_agents.qa_coach_agent.test_step_implementation_generation_coach import StepImplementationGenerationCoachAgent
from ai_agents.qa_coverage_planner_agent.test_coverage_planner_agent import CoveragePlannerAgent
from ai_agents.qa_test_generator_agent.test_generator import TestGeneratorAgent
from ai_agents.qa_test_step_generator_agent.test_step_generator import StepGeneratorAgent
from ai_agents.qa_test_step_generator_agent.test_step_reviewer import StepReviewAgent
from ai_agents.qa_test_step_generator_agent.test_step_skeleton_generator import StepSkeletonGeneratorAgent
from generate_steps import collect_raw_steps, run_resolution_and_fixer_phase


def generate_tests(section: str, first_line: str, coverage_planner: CoveragePlannerAgent,
                   test_generator: TestGeneratorAgent) -> FeatureSuite:
    try:
        print("        🤖 [Coverage Planner Agent]: Planning test scenario coverage matrix...")
        coverage_plan = coverage_planner.plan_coverage(
            requirement_text=section,
            requirement_section=first_line
        )
        print(f"            Planned {coverage_plan.total_scenarios_planned} test scenario(s).")

        # -----------------------------------------------------------------
        # PHASE 1: Generate Schema-Validated Gherkin FeatureSuite
        # -----------------------------------------------------------------
        print("        🤖 [Test Generator Agent]: Synthesizing Gherkin feature suite...")

        BATCH_SIZE = 6  # Small batch size to avoid output token limits
        all_scenarios = []
        feature_title = ""

        planned_scenarios = coverage_plan.scenarios
        total_scenarios = len(planned_scenarios)

        for i in range(0, total_scenarios, BATCH_SIZE):
            batch = planned_scenarios[i: i + BATCH_SIZE]

            # Create a temporary plan for this sub-batch
            batch_plan = coverage_plan.model_copy(update={"scenarios": batch})

            batch_suite = test_generator.generate_tests_for_instructions(
                coverage_plan=batch_plan,
                step_patterns=get_escaped_step_patterns(),
                business_knowledge=TRADEHUB_BUSINESS_KNOWLEDGE
            )

            if not feature_title and hasattr(batch_suite, "feature_title"):
                feature_title = batch_suite.feature_title

            all_scenarios.extend(batch_suite.scenarios)

        # Build the complete merged suite
        feature_suite = FeatureSuite(
            feature_title=feature_title or first_line,
            scenarios=all_scenarios
        )
        return feature_suite

    except ResponseError as e:
        if e.status_code == 404 or "not found" in str(e).lower():
            print_missing_model_error(test_generator.model_name)
            sys.exit(1)
        else:
            raise e


def main():
    print("🚀 Initializing Agentic Test Automation Pipeline...")
    parser = argparse.ArgumentParser(description="Batch QA Test Step Generator Pipeline")
    parser.add_argument("--skip-test-generation", action="store_true", help="Skip initial feasibility & pattern mining")
    args = parser.parse_args()

    # Instantiate Phase 0 and Phase 1 Agents statically
    test_gen_coach = TestGenerationCoachAgent()
    coverage_planner = CoveragePlannerAgent()
    test_generator = TestGeneratorAgent()

    # File naming tag reflecting the synthesis model
    model_slug = sanitize_model_tag_for_filename(test_generator.model_name)

    sections = split_instructions_into_sections(TRADEHUB_RAW_INSTRUCTIONS)
    print(f"📄 Found {len(sections)} distinct section(s) to process...")
    if not args.skip_test_generation:
        print("🔄 Phase 0: Planning Test Generation Pipeline...")
        print("    🤖 [Test Generation Coach Agent]: Evaluating requirements sections vs existing root feature files...")
        coach_response = test_gen_coach.evaluate_execution(
            requirements_doc=TRADEHUB_RAW_INSTRUCTIONS,
            existing_features_summary=test_gen_coach.get_section_summary(sections, model_slug=model_slug)
        )

        # Index coach decisions by section_index for O(1) lookup
        directives_by_index = {target.section_index: target for target in coach_response.target_scope}

        # 3. Process ONLY sections instructed by the Coach
        for index, section in enumerate(sections, 1):
            first_line = section.split('\n')[0].strip()
            directive = directives_by_index.get(index)

            # Fallback guard: skip if file exists and no explicit re-generation is requested
            if not directive or directive.action == "SKIP":
                print(f"    ⏩ [Coach Directive] SKIP [{index}/{len(sections)}]: {first_line}")
                continue

            print(f"    🎯 [Coach Directive]: {directive.action} [{index}/{len(sections)}]: {first_line}")
            print(f"    📋 Reason: {directive.reason}")

            # Trigger Coverage Planner & Test Generator ONLY for this specific section
            feature_suite = generate_tests(
                section=section,
                first_line=first_line,
                coverage_planner=coverage_planner,
                test_generator=test_generator
            )

            # Write FeatureSuite to disk
            file_path = Path("features") / directive.feature_file_name
            with open(file_path, "w", encoding="utf-8") as f:
                f.write(f"Feature: {feature_suite.feature_title}\n\n")
                for scenario in feature_suite.scenarios:
                    if scenario.tag:
                        f.write(f"  {scenario.tag}\n")
                    f.write(f"  Scenario: {scenario.name}\n")
                    for step in scenario.steps:
                        f.write(f"    {step.keyword} {step.statement}\n")
                    f.write("\n")

            print(f"        ✅ Generated: {directive.feature_file_name}\n")
    else:
        print("⏩ Phase 0: (Skipped by User) Test Generation Coach directives ignored.")

    print("🔄 Phase 1: Automation Feasibility & Pattern Mining Pipeline...")
    feasibility_coach = AutomationFeasibilityCoachAgent()
    feasibility_agent = AutomationFeasibilityAgent()

    lessons_manager = LessonsLearnedManager()
    project_root = Path(__file__).resolve().parent
    features_dir = project_root / "features"
    feature_files = discover_all_feature_files(str(features_dir), model_slug=model_slug)

    # 2. Evaluate scope via AutomationFeasibilityCoachAgent
    print("    🤖 [Feasibility Coach]: Evaluating feature feasibility status...")
    feasibility_coach_response = feasibility_coach.evaluate_execution()

    # 3. Run FeasibilityAgent ONLY for target files marked EVALUATE / RE_EVALUATE
    directives_map = {target.feature_file_name: target for target in feasibility_coach_response.target_scope}

    if feasibility_coach_response.should_run_feasibility:
        print("    🔍 Phase 1.1: Collecting initial undefined steps...")
        feature_steps_map, all_raw_steps = collect_raw_steps(feature_files)
        print("    🔍 Phase 1.2: Mining Drain3 patterns and evaluating feasibility...")
        drain_patterns = mine_patterns_with_drain(all_raw_steps)
        automatable_patterns = {p for p in drain_patterns if "<*>" in p}
        registry = PatternRegistry(initial_patterns=automatable_patterns)
        features_dir = Path("features")
        root_feature_files = [f for f in features_dir.glob("*.feature") if f.is_file()]
        for feature_file in root_feature_files:
            directive = directives_map.get(feature_file.name)
            if directive and directive.action in ["EVALUATE", "RE_EVALUATE"]:
                print(f"    🎯 [Coach Directive]: {directive.action} -> {feature_file.name}")
                print(f"    📋 Reason: {directive.reason}")
                print(f"    🤖 [Feasibility Agent]: Generating feasibility report for {feature_file.name}...")
                feasibility_agent.process_feature_file(str(feature_file), registry)
            else:
                print(f"    ⏩ [Coach Directive] SKIP -> {feature_file.name} (Feedback intact)")
    else:
        print("    ⏩ [Feasibility Coach]: All feasibility feedback reports are valid and up to date.")

    print("🔄 Phase 2: Audit Pipeline...")
    print("    🔍 Phase 2.1: Harvesting known patterns from existing feedback JSON files...")
    harvested_patterns = PatternRegistry.collect_all_used_patterns(feedback_dir="features")
    pattern_registry = PatternRegistry(initial_patterns=harvested_patterns)
    print(f"    📋 PatternRegistry loaded with {len(pattern_registry.active_patterns)} unique active patterns.")
    print("    🤖 [Audit Coach]: Evaluating audit execution scope...")
    audit_coach = AuditCoachAgent(lessons_manager=lessons_manager)
    audit_coach_response = audit_coach.evaluate_audit_execution()
    audit_directives_map = {target.feature_file_name: target for target in audit_coach_response.target_scope}

    if audit_coach_response.should_run_audit:
        pattern_auditor = PatternAuditAgent()
        feasibility_agent = AutomationFeasibilityAgent(lessons_manager=lessons_manager)
        features_dir = Path("features")
        root_feature_files = [f for f in features_dir.glob("*.feature") if f.is_file()]
        for feature_file in root_feature_files:
            directive = audit_directives_map.get(feature_file.name)
            if directive and directive.action == "EXECUTE_AUDIT":
                print(f"    🎯 [Coach Directive]: EXECUTE_AUDIT -> {feature_file.name}")
                print(f"    📋 Reason: {directive.reason}")
                pattern_auditor.audit_and_remediate_feature(
                    feature_path=str(feature_file),
                    registry=pattern_registry,
                    rematch_fn=feasibility_agent.rematch_step,
                    lessons_manager=lessons_manager
                )
                run_resolution_and_fixer_phase([feature_file], lessons_manager=lessons_manager)
            else:
                print(f"    ⏩ [Coach Directive]: SKIP_AUDIT -> {feature_file.name} (All resolved_patterns intact)")

        del pattern_auditor, feasibility_agent
        gc.collect()
    else:
        print("    ⏩ [Audit Coach]: All feedback files have complete, valid resolved_patterns.")

    print("🔄 Phase 3: Evaluating Step Definition & Code Generation Pipeline...")

    # 1. Collect undefined steps directly from the test suite
    feature_steps_map, all_raw_steps = collect_raw_steps(feature_files)

    # 1. Harvest latest undefined step patterns from pattern registry / dry-run
    latest_patterns = False if len(all_raw_steps) == 0 else PatternRegistry.collect_all_used_patterns(
        feedback_dir="features")

    if not latest_patterns:
        print("⏩ Phase 3 Skipped: No active step patterns found in feedback directory.")
    else:
        # 2. Extract existing step definitions from features/steps
        existing_step_files = list(Path("features/steps").glob("*.py")) if Path("features/steps").exists() else []
        existing_step_definitions = [step_file.read_text(encoding="utf-8") for step_file in existing_step_files]

        # 3. Invoke Phase 4 Coach Gatekeeper
        impl_coach = StepImplementationGenerationCoachAgent(lessons_manager=lessons_manager)
        coach_response = impl_coach.evaluate_execution(
            undefined_step_patterns=latest_patterns,
            existing_step_definitions=existing_step_definitions
        )
        del impl_coach
        gc.collect()

        # 4. Handle GENERATE Execution Path
        if coach_response.should_run_generator:
            print(f"    🤖 [Audit Coach]: Evaluating audit execution scope...")
            # Filter patterns flagged strictly for GENERATE
            unhandled_patterns = [
                target.step_pattern
                for target in coach_response.target_scope
                if target.action == "GENERATE"
            ]
            unhandled_pattern_set = set(unhandled_patterns)

            if unhandled_patterns:
                print(
                    f"    🔍 Phase 3.1: Generating step skeletons for {len(unhandled_patterns)} unhandled pattern(s)...")
                skeleton_agent = StepSkeletonGeneratorAgent()
                skeletons = skeleton_agent.generate_skeletons(unhandled_pattern_set, unhandled_patterns)
                del skeleton_agent
                gc.collect()

                if skeletons:
                    combined_skeletons = "\n\n".join(skeletons)

                    print("    🔍 Phase 3.2: Generating Python @step implementation code...")
                    step_generator_agent = StepGeneratorAgent()
                    draft_code = step_generator_agent.generate_missing_steps(combined_skeletons)
                    del step_generator_agent
                    gc.collect()

                    print("    🧹 Phase 3.3: Reviewing, sanitizing, and validating AST with Ruff...")
                    step_reviewer_agent = StepReviewAgent()
                    cleaned_final_code = step_reviewer_agent.review_and_fix(draft_code)
                    del step_reviewer_agent
                    gc.collect()

                    # Write out final generated step file
                    output_file = Path("features/steps/generated_by_ai_steps.py")
                    output_file.parent.mkdir(parents=True, exist_ok=True)
                    with open(output_file, "a" if output_file.exists() else "w", encoding="utf-8") as out_f:
                        out_f.write("\n\n" + cleaned_final_code + "\n")

                    print(f"    ✅ Generated step definitions appended to {output_file.resolve()}")
            else:
                print("⏩ [Audit Coach]: Generator was flagged, but no specific patterns required GENERATE.")
        else:
            print(
                "⏩ [Audit Coach]: All step definitions are already implemented or skipped. No code generation "
                "required.")


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"\n❌ Pipeline Execution Error: {e}")
        sys.exit(1)
