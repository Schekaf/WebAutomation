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
from typing import List, Dict, Any, Optional, Callable, Set, Tuple

from langchain_core.output_parsers import JsonOutputParser

from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.step_library import PatternRegistry
from ai_agents.core.utils import timer, rest_check

PATTERN_AUDIT_PROMPT = """You are a QA Pattern Audit Agent.

LESSONS LEARNED (PAST FAILURE MODES TO AVOID):
{lessons_learned}

Your ONLY task is to judge whether "assigned_pattern" semantically and structurally matches "step_text".

RULES FOR VALIDATION:

1. "status": "mismatch" MUST BE RETURNED IF ANY OF THESE ARE TRUE:
   - VERB/ACTION MISMATCH: The step verb does not match the pattern action.
     * Step: "And I accept the Terms and Conditions" vs Pattern: "I click on <*>" --> MISMATCH (accept != click on)
     * Step: "And I enter Furkan" vs Pattern: "I select <*>" --> MISMATCH (enter != select)
   - CONTRADICTORY MEANING: Step says "accept" but pattern says "do not accept".
   - ARTIFICIAL SENTENCES: Pattern adds specific strings not in the step (e.g. adding "You have tender postings").

2. "status": "valid" SHOULD BE RETURNED IF:
   - The verb/action matches AND the structural slots align correctly.
   - DO NOT flag as mismatch if the only difference is quote formatting around wildcards (e.g., 'I enter <*> as <*>' IS VALID for 'I enter "Furkan" as Name').

INPUT DATA:
{scenario_payload}

Output JSON ONLY matching this format:
{{
  "has_mismatches": true | false,
  "audit_results": [
    {{
      "step_text": "Exact step_text from input",
      "assigned_pattern": "Exact assigned_pattern from input",
      "status": "valid" | "mismatch",
      "root_cause": "Detailed reason if mismatch (leave empty string if valid)"
    }}
  ]
}}
"""


class PatternAuditAgent(BaseAgent):
    """
    Lightweight auditor that checks step-to-pattern alignment.
    Returns binary match/mismatch flags without searching or suggesting new patterns.
    """

    def __init__(self, **kwargs):
        # 1. Delegate LLM, model, and lessons_manager setup to BaseAgent
        super().__init__(
            temperature=0.0,
            format_json=True,
            timeout=30.0,
            keep_alive="0s",  # Instantly release memory
            **kwargs
        )

        # 2. Build audit evaluation chain using JsonOutputParser
        self.chain = self.create_chain(
            PATTERN_AUDIT_PROMPT,
            output_parser=JsonOutputParser()
        )

    @timer
    @rest_check
    # -------------------------------------------------------------------------
    # 1. LLM Evaluation Method
    # -------------------------------------------------------------------------
    def audit_scenario_steps(self, steps: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """Audits steps with the LLM and returns audit results (valid vs mismatch)."""
        if not steps:
            return []
        try:
            # BaseAgent.invoke automatically handles lessons_learned injection
            audit_out = self.invoke(
                self.chain,
                {
                    "scenario_payload": json.dumps(steps, indent=2, ensure_ascii=False)
                }
            )
            return audit_out.get("audit_results", [])
        except Exception as e:
            print(f"   ⚠️ Scenario audit error: {e}")
            return []

    # -------------------------------------------------------------------------
    # 2. Granular Helper Functions
    # -------------------------------------------------------------------------
    def _remediate_step_mismatch(
            self,
            step_entry: Dict[str, Any],
            audit_info: Dict[str, Any],
            registry: PatternRegistry,
            rematch_fn: Callable[[str, str, Set[str]], Dict[str, Any]],
            lessons_manager: Optional[Any]
    ) -> None:
        """Rematches a single flagged step, updates registry, and logs drift feedback."""
        s_text = step_entry.get("step_text", "")
        old_pattern = step_entry.get("matched_pattern", "")
        root_cause = audit_info.get("root_cause", "Pattern mismatch detected by PatternAuditAgent.")

        # CALLABLE INJECTION: Rematch step via injected function pointer
        rematch_res = rematch_fn(s_text, old_pattern, registry.active_patterns)
        raw_new_pattern = rematch_res.get("matched_pattern", old_pattern)

        clean_old_p = registry.clean_pattern(old_pattern)
        clean_new_p = registry.clean_pattern(raw_new_pattern)

        # Register newly suggested pattern into active registry
        if clean_new_p and not registry.contains(clean_new_p):
            registry.add_pattern(clean_new_p, status="suggested")

        step_entry["matched_pattern"] = clean_new_p

        # Log lesson learned if pattern drift occurred
        mgr = lessons_manager or self.lessons_manager
        if mgr and clean_new_p != clean_old_p:
            mgr.add_lesson(
                agent_id="AutomationFeasibilityAgent",
                category="drain_mapping_drift",
                original_output=f"Step: {s_text} | Pattern: {clean_old_p}",
                corrected_output=f"New Pattern: {clean_new_p}",
                root_cause=root_cause,
                rule_derived="Ensure matched patterns strictly preserve step sentence structure."
            )

    @rest_check
    def _process_single_scenario(
            self,
            scenario: Dict[str, Any],
            registry: PatternRegistry,
            rematch_fn: Callable[[str, str, Set[str]], Dict[str, Any]],
            lessons_manager: Optional[Any]
    ) -> Optional[str]:
        """Audits and remediates steps within a single scenario.

        Returns scenario title if automatable.
        """
        s_title = scenario.get("title", "")
        is_auto = scenario.get("is_automatable", True)
        steps = scenario.get("steps", [])

        if not (is_auto and steps):
            return None

        # 1. Audit steps via LLM
        audit_results = self.audit_scenario_steps(steps)
        audit_map = {item["step_text"]: item for item in audit_results if "step_text" in item}

        # 2. Iterate through steps for remediation & usage tracking
        for step_entry in steps:
            s_text = step_entry.get("step_text")

            # Remediate if flagged as mismatch
            if s_text in audit_map and audit_map[s_text].get("status") == "mismatch":
                self._remediate_step_mismatch(
                    step_entry=step_entry,
                    audit_info=audit_map[s_text],
                    registry=registry,
                    rematch_fn=rematch_fn,
                    lessons_manager=lessons_manager
                )

            # Record deterministic usage in PatternRegistry
            current_pattern = step_entry.get("matched_pattern")
            if current_pattern:
                p_status = registry.record_usage(
                    pattern=current_pattern,
                    step_text=s_text,
                    scenario_title=s_title
                )
                step_entry["pattern_status"] = p_status

        return s_title

    def _load_feedback_file(self, feature_path: str) -> Tuple[Optional[Path], Dict[str, Any]]:
        """Loads and parses the feedback JSON file corresponding to a feature file."""
        feat_path = Path(feature_path)
        feedback_path = feat_path.parent / f"{feat_path.stem}_feasibility_feedback.json"

        if not feedback_path.exists():
            print(f"⚠️ Feedback file not found: {feedback_path}")
            return None, {}

        try:
            with open(feedback_path, "r", encoding="utf-8") as f:
                return feedback_path, json.load(f)
        except (json.JSONDecodeError, Exception) as e:
            print(f"❌ Error reading feedback file {feedback_path}: {e}")
            return None, {}

    def _save_feedback_file(self, feedback_path: Path, evaluation_results: Dict[str, Any]) -> None:
        """Saves updated scenario results back to the feedback JSON file."""
        with open(feedback_path, "w", encoding="utf-8") as f:
            json.dump(evaluation_results, f, indent=2, ensure_ascii=False)

    # -------------------------------------------------------------------------
    # 3. Main Orchestration Method (Clean & Readable)
    # -------------------------------------------------------------------------
    @rest_check
    def audit_and_remediate_feature(
            self,
            feature_path: str,
            registry: PatternRegistry,
            rematch_fn: Callable[[str, str, Set[str]], Dict[str, Any]],
            lessons_manager: Optional[Any] = None
    ) -> Set[str]:
        """High-level pipeline coordinator for feature feedback auditing and remediation."""
        feedback_path, evaluation_results = self._load_feedback_file(feature_path)
        if not feedback_path or not evaluation_results:
            return set()

        approved_titles: Set[str] = set()

        for scenario in evaluation_results.get("scenarios", []):
            approved_title = self._process_single_scenario(
                scenario=scenario,
                registry=registry,
                rematch_fn=rematch_fn,
                lessons_manager=lessons_manager
            )
            if approved_title:
                approved_titles.add(approved_title)

        self._save_feedback_file(feedback_path, evaluation_results)
        return approved_titles
