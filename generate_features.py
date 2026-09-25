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

import os
import re
import sys
from pathlib import Path
from ollama import ResponseError

from ai_agents.core.schemas import FeatureSuite
# Core Agents
from ai_agents.qa_coverage_planner_agent.test_coverage_planner_agent import CoveragePlannerAgent
from ai_agents.qa_test_generator_agent.test_generator import TestGeneratorAgent

# Central Configuration
from ai_agents.core.config import GENERAL, CODER

# Domain & Step Libraries
from ai_agents.core.step_library import get_escaped_step_patterns
from ai_agents.core.tradehub_domain import TRADEHUB_RAW_INSTRUCTIONS, TRADEHUB_BUSINESS_KNOWLEDGE

# Helpers & Selectors
from ai_agents.core.model_selector import select_model_interactively, print_missing_model_error
from ai_agents.core.utils import sanitize_model_tag_for_filename, split_instructions_into_sections


def main():
    print("Initializing Agentic Test Automation Pipeline...")

    # Instantiate Phase 0 and Phase 1 Agents statically
    coverage_planner = CoveragePlannerAgent()
    test_generator = TestGeneratorAgent()

    # File naming tag reflecting the synthesis model
    model_slug = sanitize_model_tag_for_filename(test_generator.model_name)

    # Step 3: Split raw instructions into distinct sections
    sections = split_instructions_into_sections(TRADEHUB_RAW_INSTRUCTIONS)
    print(f"Found {len(sections)} distinct section(s) to process...\n")

    # Step 4: Create output directory for generated feature files
    output_dir = "features"
    os.makedirs(output_dir, exist_ok=True)

    for index, section in enumerate(sections, 1):
        # Extract section title (e.g., "1. Create a New Account")
        first_line = section.split('\n')[0].strip()

        # Create a clean filename slug
        sanitized_name = re.sub(r'[^a-zA-Z0-9_]', '_', first_line.lower())
        file_name = f"{index:02d}_{sanitized_name}_{model_slug}.feature"
        file_path = os.path.join(output_dir, file_name)

        print(f"[{index}/{len(sections)}] Processing Section: {first_line}")

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

        except ResponseError as e:
            if e.status_code == 404 or "not found" in str(e).lower():
                print_missing_model_error(test_generator.model_name)
                sys.exit(1)
            else:
                raise e

        # ---------------------------------------------------------------------
        # Write FeatureSuite directly to .feature file using typed properties
        # ---------------------------------------------------------------------
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(f"Feature: {feature_suite.feature_title}\n\n")
            for scenario in feature_suite.scenarios:
                if scenario.tag:
                    f.write(f"  {scenario.tag}\n")
                f.write(f"  Scenario: {scenario.name}\n")
                for step in scenario.steps:
                    f.write(f"    {step.keyword} {step.statement}\n")
                f.write("\n")

        print(f"  ✔ Generated feature file: {file_name}\n")

    print(f"\nSuccess! Generated {len(sections)} distinct .feature files in: {os.path.abspath(output_dir)}")


if __name__ == "__main__":
    main()