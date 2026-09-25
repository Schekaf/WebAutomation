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
import os
import sys
import gc
from pathlib import Path

from ai_agents.core.config import get_agent_model
from ai_agents.core.lessons_learned_manager import LessonsLearnedManager
from ai_agents.core.step_library import PatternRegistry
from ai_agents.core.step_scanner import get_undefined_steps_via_behave
from ai_agents.core.utils import (
    discover_all_feature_files,
    sanitize_model_tag_for_filename,
    clear_ai_generated_steps_file,
    mine_patterns_with_drain,
)
from ai_agents.qa_automation_feasibility_agent.pattern_audit_agent import PatternAuditAgent
from ai_agents.qa_automation_feasibility_agent.pattern_parameter_resolution_agent import PatternResolutionAgent

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


# -------------------------------------------------------------------------
# Phase 1: Feasibility Evaluation & Pattern Mining
# -------------------------------------------------------------------------
def run_feasibility_phase(feature_files, lessons_manager):
    print("\n🔍 Phase 1.1: Collecting initial undefined steps...")
    feature_steps_map, all_raw_steps = collect_raw_steps(feature_files)

    if not feature_steps_map:
        print("✅ All steps are already covered by your codebase!")
        return None

    print("\n🦴 Phase 1.2: Mining Drain3 patterns and evaluating feasibility...")
    drain_patterns = mine_patterns_with_drain(all_raw_steps)
    automatable_patterns = {p for p in drain_patterns if "<*>" in p}
    pattern_registry = PatternRegistry(initial_patterns=automatable_patterns)

    feasibility_agent = AutomationFeasibilityAgent(lessons_manager=lessons_manager)
    for feature_file in feature_files:
        feasibility_agent.process_feature_file(feature_file, pattern_registry)

    del feasibility_agent
    gc.collect()
    return pattern_registry


# -------------------------------------------------------------------------
# Phase 2: Audit Evaluation & Remediations
# -------------------------------------------------------------------------
def run_audit_phase(feature_files, lessons_manager, feedback_directory="features"):
    print("\n🔍 Phase 2.1: Harvesting known patterns from existing feedback JSON files...")
    harvested_patterns = PatternRegistry.collect_all_used_patterns(feedback_dir=feedback_directory)
    pattern_registry = PatternRegistry(initial_patterns=harvested_patterns)
    print(f"📋 PatternRegistry loaded with {len(pattern_registry.active_patterns)} unique active patterns.")

    print("\n🚀 Running PatternAuditAgent on existing feedback files...")
    pattern_auditor = PatternAuditAgent()
    feasibility_agent = AutomationFeasibilityAgent(lessons_manager=lessons_manager)

    for feature_file in feature_files:
        pattern_auditor.audit_and_remediate_feature(
            feature_path=str(feature_file),
            registry=pattern_registry,
            rematch_fn=feasibility_agent.rematch_step,
            lessons_manager=lessons_manager
        )

    del pattern_auditor, feasibility_agent
    gc.collect()
    print("✅ Audit evaluation complete!")
    return pattern_registry


# -------------------------------------------------------------------------
# Phase 3: Pattern Parameter Resolution & Syntax Harmonization
# -------------------------------------------------------------------------
def run_resolution_and_fixer_phase(feature_files, lessons_manager):
    print("\n🔧 Phase 3.1: Harmonizing Gherkin step syntax for automatable scenarios...")
    resolution_agent = PatternResolutionAgent()
    test_fixer_agent = TestFixerAgent()

    for feature_file in feature_files:
        feature_path = Path(feature_file)
        feedback_file = feature_path.parent / f"{feature_path.stem}_feasibility_feedback.json"

        if feedback_file.exists():
            resolution_agent.process_feedback_file(str(feedback_file))

            fix_result = test_fixer_agent.fix_feature_file(
                feature_path=str(feature_path),
                feedback_path=str(feedback_file)
            )

            fixed_gherkin = fix_result.get("harmonized_gherkin", "")
            fixes_applied = fix_result.get("fixes_applied", [])

            if fixed_gherkin:
                feature_path.write_text(fixed_gherkin, encoding="utf-8")

            if fixes_applied:
                print(f"   📝 Applied {len(fixes_applied)} fix(es) to {feature_path.name}")
                for fix in fixes_applied:
                    lessons_manager.add_lesson(
                        agent_id="TestGeneratorAgent",
                        category=fix.get("category", "gherkin_syntax"),
                        original_output=fix.get("original_step", ""),
                        corrected_output=fix.get("corrected_step", ""),
                        root_cause=fix.get("root_cause", ""),
                        rule_derived=fix.get("rule_derived", "")
                    )

    del resolution_agent, test_fixer_agent
    gc.collect()


# -------------------------------------------------------------------------
# Phase 4: Skeleton Generation, Implementation & AST Review
# -------------------------------------------------------------------------
def run_code_generation_phase(output_ai_steps_file, model_name, feedback_directory="features"):
    print("\n🔄 Phase 4.1: Re-scanning steps & generating skeletons...")
    latest_patterns = PatternRegistry.collect_all_used_patterns(feedback_dir=feedback_directory)

    if not latest_patterns:
        print("✅ No new automatable steps require skeleton generation.")
        return

    # 1. Generate Skeletons
    skeleton_agent = StepSkeletonGeneratorAgent()
    skeletons = skeleton_agent.generate_skeletons(latest_patterns, latest_patterns)
    del skeleton_agent
    gc.collect()

    if not skeletons:
        print("✅ No step skeletons were returned.")
        return

    combined_skeletons = "\n\n".join(skeletons)

    # 2. Implement Code
    print("\n⚙️ Phase 4.2: Generating step implementation code...")
    step_generator_agent = StepGeneratorAgent()
    draft_code = step_generator_agent.generate_missing_steps(combined_skeletons)
    del step_generator_agent
    gc.collect()

    # 3. AST Review & Fix
    print("\n🧹 Phase 4.3: Reviewing, sanitizing, and validating AST...")
    step_reviewer_agent = StepReviewAgent()
    cleaned_final_code = step_reviewer_agent.review_and_fix(draft_code)
    del step_reviewer_agent
    gc.collect()

    # 4. Write Output
    output_ai_steps_file.parent.mkdir(parents=True, exist_ok=True)
    with open(output_ai_steps_file, "w", encoding="utf-8") as out_f:
        out_f.write(f"# Auto-generated step definitions by Phase 3 Pipeline ({model_name})\n")
        out_f.write(cleaned_final_code + "\n")

    print("\n✨ Step generation pipeline completed successfully!")
    print(f"👉 Generated File: {output_ai_steps_file.resolve()}")


# -------------------------------------------------------------------------
# Main Controller Pipeline
# -------------------------------------------------------------------------
def main():
    parser = argparse.ArgumentParser(description="Batch QA Test Step Generator Pipeline")
    parser.add_argument("--skip-feasibility", action="store_true", help="Skip initial feasibility & pattern mining")
    parser.add_argument("--skip-audit", action="store_true", help="Skip pattern audit agent phase")
    parser.add_argument("--skip-fixer", action="store_true", help="Skip pattern resolution & Gherkin fixer phase")
    parser.add_argument("--only-generate", action="store_true", help="Only run code generation (Phase 4)")
    args = parser.parse_args()

    print("=" * 65)
    print("🚀 Starting Batch QA Test Step Generator Pipeline")
    print("=" * 65)

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

    feature_files = discover_all_feature_files(str(features_dir), model_slug=model_slug)
    if not feature_files:
        print(f"⚠️ No .feature files found matching suffix '*_{model_slug}.feature'")
        return

    clear_ai_generated_steps_file(str(output_ai_steps_file))

    # Fast-track for testing generation steps directly
    if args.only_generate:
        run_code_generation_phase(output_ai_steps_file, model_name)
        return

    # Execution Flow
    if not args.skip_feasibility:
        run_feasibility_phase(feature_files, lessons_manager)

    if not args.skip_audit:
        run_audit_phase(feature_files, lessons_manager)

    if not args.skip_fixer:
        run_resolution_and_fixer_phase(feature_files, lessons_manager)

    # Always generate output code unless fast-exited
    run_code_generation_phase(output_ai_steps_file, model_name)


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"\n❌ Pipeline Execution Error: {e}")
        sys.exit(1)
