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

import json
from pathlib import Path
from typing import Dict, Set, Any

from langchain_core.output_parsers import JsonOutputParser

from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.utils import rest_check

PROMPT = """You are a test automation step pattern formatter.

LESSONS LEARNED (PAST FAILURE MODES TO AVOID):
{lessons_learned}

Task:
Take the list of raw Gherkin step patterns and convert all `<*>` placeholders into named, typed parameters.
Ignore Gherkin keywords (Given, When, Then, And, But) if present in the text.

Rules for replacing `<*>`:
1. Wrap parameters in double quotes `"{{param_name}}"` if they represent string inputs, URLs, or variable values (e.g., `"{{url}}"`, `"{{value}}"`).
2. Do NOT use quotes `{{param_name}}` if they represent UI elements or actions (e.g., `{{element}}`, `{{button}}`).
3. Infer meaningful parameter names like `{{element}}`, `"{{url}}"`, `"{{text}}"`, `"{{option}}"`, `{{device}}` based on the verb/context.
4. NEVER change the patterns to include Gherkin keywords or alter the action verbs. Only replace `<*>` with typed parameters.

Input Patterns:
{patterns}

Return a JSON object mapping the original pattern to its resolved version:
{{
  "I open <*> on a <*>": "I open \\"{{url}}\\" on a {{device}}",
  "I click <*>": "I click {{element}}"
}}
"""


class PatternResolutionAgent(BaseAgent):
    """Agent that resolves generic step patterns into typed parameter schemas."""

    def __init__(self, **kwargs):
        # 1. Delegate LLM, model, and lessons_manager setup to BaseAgent
        super().__init__(temperature=0.0, format_json=True, **kwargs)

        # 2. Interactive HITL flag initialization
        self.interactive_mode = None

        # 3. Create chain using BaseAgent helper with JsonOutputParser
        self.chain = self.create_chain(
            PROMPT,
            output_parser=JsonOutputParser()
        )

    def resolve_patterns(self, raw_patterns: Set[str]) -> Dict[str, str]:
        """Takes raw patterns from collect_all_used_patterns and returns a mapping to typed patterns."""
        if not raw_patterns:
            return {}

        # BaseAgent.invoke automatically handles lessons_learned injection
        return self.invoke(
            self.chain,
            {
                "patterns": list(raw_patterns)
            }
        )

    @rest_check
    def process_feedback_file(self, feedback_path: str) -> bool:
        """Processes a single feedback JSON file, resolves any generic `<*>` step patterns,
        and updates the JSON file in-place with 'resolved_pattern'.
        """
        file_path = Path(feedback_path)
        if not file_path.exists():
            print(f"⚠️ Feedback file not found: {feedback_path}")
            return False

        with open(file_path, "r", encoding="utf-8") as f:
            feedback_data: Dict[str, Any] = json.load(f)

        # 1. Collect unique matched patterns within this feedback file
        file_patterns: Set[str] = set()
        for scenario in feedback_data.get("scenarios", []):
            for step in scenario.get("steps", []):
                pattern = step.get("matched_pattern") or step.get("pattern")
                if pattern and "<*>" in pattern:
                    file_patterns.add(pattern)

        if not file_patterns:
            print(f"ℹ️ No unresolved `<*>` patterns found in {file_path.name}")
            return False

        # 2. Invoke LLM chain to map patterns to resolved parameter schemas
        schema_map = self.resolve_patterns(file_patterns)
        if not schema_map:
            return False

        if self.interactive_mode is None:
            choice = input(
                "\nDo you want to enable Human-In-The-Loop review for pattern resolutions? (y/n): "
            ).strip().lower()
            self.interactive_mode = (choice == "y")
            if self.interactive_mode:
                print("Interactive mode ENABLED. You will review each proposed resolution.")
            else:
                print("Interactive mode DISABLED. Auto-accepting all proposed resolutions for this run.")

        print(f"\n🔍 [PatternResolutionAgent] Proposed resolutions for {file_path.name}:")
        for raw, resolved in schema_map.items():
            if not self.interactive_mode:
                continue
            print(f"   • Raw:      {raw}")
            print(f"     Resolved: {resolved}")

            user_input = input("\nIs this pattern resolution correct? (y/n): ").strip().lower()

            if user_input != "y":
                print("❌ Resolution rejected by user.")

                # Capture feedback for LessonsLearnedManager inherited from BaseAgent
                user_correction = input("Provide the correct expected format or rule derived: ").strip()
                self.lessons_manager.add_lesson(
                    agent_id=self.agent_name,
                    category="pattern_resolution_mismatch",
                    original_output=f"{raw} -> {resolved}",
                    corrected_output=user_correction,
                    root_cause="LLM parameter resolution rejected by user review",
                    rule_derived=user_correction or "Strictly adhere to explicit parameter typing rules."
                )
                print("📝 Lesson added to LessonsLearnedManager.")

        # 3. Decorate each step with 'resolved_pattern'
        updated = False
        for scenario in feedback_data.get("scenarios", []):
            for step in scenario.get("steps", []):
                pattern = step.get("matched_pattern") or step.get("pattern")
                if pattern in schema_map:
                    step["resolved_pattern"] = schema_map[pattern]
                    updated = True

        # 4. Save updated feedback payload back to disk
        if updated:
            with open(file_path, "w", encoding="utf-8") as f:
                json.dump(feedback_data, f, indent=2, ensure_ascii=False)
            print(f"✅ Updated resolved patterns in {file_path.name}")

        return updated