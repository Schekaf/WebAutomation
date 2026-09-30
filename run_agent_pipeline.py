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
from ai_agents.qa_automation_feasibility_agent.test_automatable_feasibility_agent import AutomationFeasibilityAgent
from ai_agents.qa_coach_agent.test_autamation_feasibility_coach import AutomationFeasibilityCoachAgent
from ai_agents.qa_coach_agent.test_generation_coach import TestGenerationCoachAgent
from ai_agents.qa_coverage_planner_agent.test_coverage_planner_agent import CoveragePlannerAgent
from ai_agents.qa_test_generator_agent.test_generator import TestGeneratorAgent
from generate_steps import collect_raw_steps


def generate_tests(section: str, first_line: str, coverage_planner: CoveragePlannerAgent,
                   test_generator: TestGeneratorAgent) -> FeatureSuite:
    try:
        # -----------------------------------------------------------------
        # PHASE 0: Generate Structured Coverage Plan Matrix
        # -----------------------------------------------------------------
        print("  ↳ Phase 0: Planning test scenario coverage matrix...")
        coverage_plan = coverage_planner.plan_coverage(
            requirement_text=section,
            requirement_section=first_line
        )
        print(f"    Planned {coverage_plan.total_scenarios_planned} test scenario(s).")

        # -----------------------------------------------------------------
        # PHASE 1: Generate Schema-Validated Gherkin FeatureSuite
        # -----------------------------------------------------------------
        print("  ↳ Phase 1: Synthesizing Gherkin feature suite...")

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
    print("Initializing Agentic Test Automation Pipeline...")
    parser = argparse.ArgumentParser(description="Batch QA Test Step Generator Pipeline")
    parser.add_argument("--skip-test-generation", action="store_true", help="Skip initial feasibility & pattern mining")
    args = parser.parse_args()

    # Instantiate Phase 0 and Phase 1 Agents statically
    test_gen_coach = TestGenerationCoachAgent()
    coverage_planner = CoveragePlannerAgent()
    test_generator = TestGeneratorAgent()

    # File naming tag reflecting the synthesis model
    model_slug = sanitize_model_tag_for_filename(test_generator.model_name)

    # Step 1: Split raw instructions into distinct sections
    sections = split_instructions_into_sections(TRADEHUB_RAW_INSTRUCTIONS)
    print(f"Found {len(sections)} distinct section(s) to process...\n")

    if not args.skip_test_generation:
        print("\n🤖 [TestGenerationCoachAgent] Evaluating requirements sections vs existing root feature files...")
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
                print(f"⏩ [Coach Directive] SKIP [{index}/{len(sections)}]: {first_line}")
                continue

            print(f"\n🎯 [Coach Directive] {directive.action} [{index}/{len(sections)}]: {first_line}")
            print(f"   Reason: {directive.reason}")

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

            print(f"  ✔ Saved: {directive.feature_file_name}")

    feasibility_coach = AutomationFeasibilityCoachAgent()
    feasibility_agent = AutomationFeasibilityAgent()

    lessons_manager = LessonsLearnedManager()
    project_root = Path(__file__).resolve().parent
    features_dir = project_root / "features"
    steps_dir = features_dir / "steps"
    output_ai_steps_file = steps_dir / "generated_by_ai_steps.py"

    feature_files = discover_all_feature_files(str(features_dir), model_slug=model_slug)

    # 2. Evaluate scope via AutomationFeasibilityCoachAgent
    print("🤖 [Feasibility Coach] Evaluating feature feasibility status...")

    feasibility_coach_response = feasibility_coach.evaluate_execution()

    # 3. Run FeasibilityAgent ONLY for target files marked EVALUATE / RE_EVALUATE
    directives_map = {target.feature_file_name: target for target in feasibility_coach_response.target_scope}

    if feasibility_coach_response.should_run_feasibility:
        print("\n🔍 Phase 1.1: Collecting initial undefined steps...")
        feature_steps_map, all_raw_steps = collect_raw_steps(feature_files)
        print("\n🦴 Phase 1.2: Mining Drain3 patterns and evaluating feasibility...")
        drain_patterns = mine_patterns_with_drain(all_raw_steps)
        automatable_patterns = {p for p in drain_patterns if "<*>" in p}
        registry = PatternRegistry(initial_patterns=automatable_patterns)
        features_dir = Path("features")
        root_feature_files = [f for f in features_dir.glob("*.feature") if f.is_file()]
        for feature_file in root_feature_files:
            directive = directives_map.get(feature_file.name)
            if directive and directive.action in ["EVALUATE", "RE_EVALUATE"]:
                print(f"🎯 [Feasibility Coach] {directive.action} -> {feature_file.name}")
                feasibility_agent.process_feature_file(str(feature_file), registry)
            else:
                print(f"⏩ [Feasibility Coach] SKIP -> {feature_file.name} (Feedback intact)")
    else:
        print("⏩ [Feasibility Coach]: All feasibility feedback reports are valid and up to date.")


if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"\n❌ Pipeline Execution Error: {e}")
        sys.exit(1)
