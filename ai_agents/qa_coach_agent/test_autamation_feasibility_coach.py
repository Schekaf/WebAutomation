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
from typing import List, Dict, Any, Optional
from langchain_core.prompts import PromptTemplate
from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.schemas import AutomationFeasibilityCoachResponse, FeasibilityTargetScope
AUTOMATION_FEASIBILITY_COACH_PROMPT = """You are the Supervisory Automation Feasibility Coach Agent responsible for QA pipeline integrity.

FEATURE FILE + FEATURE CONTENT + FEASIBILITY REPORT:
{single_feature_payload}

YOUR TASK:
Take your time to thoroughly audit the feasibility report against the feature file. Do NOT rush or make assumptions.

CRITICAL AUDIT CHECKS:
1. COMPLETENESS CHECK: Is the report empty, incomplete, or missing the `scenarios` array? Does `total_scenarios` in the report equal 0 while the feature file has active scenarios?
2. COVERAGE CHECK: Does the report contain an evaluation entry for EVERY scenario and step present in the feature file?
3. DRIFT CHECK: Are there new scenarios, modified step texts, or added tags in the feature file that are not evaluated in the report?

DECISION RULES:
- "RE_EVALUATE": If the report fails ANY of the audit checks above (empty report, missing scenarios, un-evaluated steps, or content drift).
- "SKIP": Output "SKIP" ONLY IF you are 100% satisfied that the report is complete, fully populated, and accounts for every scenario and step in the feature file.

OUTPUT DIRECTIVES:
- `feature_file_name`: Copy exact string from `target_feature_file`.
- `feedback_file_name`: Copy exact string from `target_feedback_file`.
- `action`: "RE_EVALUATE" or "SKIP".
- `reason`: Provide a detailed sentence explaining your audit verdict.
"""


class AutomationFeasibilityCoachAgent(BaseAgent):
    """
    Supervisory Coach Agent that checks root feature files and feasibility reports
    to dictate exact execution scope for FeasibilityAgent and PatternRegistry harvesting.
    """

    def __init__(self, **kwargs):
        super().__init__(temperature=0.0, **kwargs)

        prompt = PromptTemplate.from_template(AUTOMATION_FEASIBILITY_COACH_PROMPT)
        self.chain = prompt | self.llm.with_structured_output(FeasibilityTargetScope)

    @staticmethod
    def discover_missing_feasibility_targets(
            features_dir: Path = Path("features")) -> AutomationFeasibilityCoachResponse:
        """
        Scans the features directory for .feature files lacking a corresponding
        *_feasibility_feedback.json file and wraps the findings into a
        script-generated AutomationFeasibilityCoachResponse.
        """
        root_feature_files = [f for f in features_dir.glob("*.feature") if f.is_file()]
        missing_scope: List[FeasibilityTargetScope] = []

        for feature_file in root_feature_files:
            feedback_path = features_dir / f"{feature_file.stem}_feasibility_feedback.json"

            if not feedback_path.exists():
                missing_scope.append(
                    FeasibilityTargetScope(
                        feature_file_name=feature_file.name,
                        feedback_file_name=feedback_path.name,
                        action="EVALUATE",
                        reason="Feasibility feedback JSON file is missing on disk."
                    )
                )

        return AutomationFeasibilityCoachResponse(
            target_scope=missing_scope,
            should_run_feasibility=len(missing_scope) > 0,
            should_harvest_patterns=True
        )

    def evaluate_single_feature(self, feature_file: Path, feedback_path: Path) -> FeasibilityTargetScope:
        """
        Invokes the agent for ONE feature and feedback file pair to detect content drift.
        Returns a single FeasibilityTargetScope object.
        """
        payload = {
            "target_feature_file": feature_file.name,
            "raw_feature_text": feature_file.read_text(encoding="utf-8"),
            "raw_feedback_json": feedback_path.read_text(encoding="utf-8")
        }

        response: FeasibilityTargetScope = self.invoke(
            self.chain,
            {
                "single_feature_payload": json.dumps(payload, indent=2, ensure_ascii=False)
            }
        )

        # DETERMINISTIC OVERWRITE: Ensure file names are NEVER corrupted by LLM placeholders
        response.feature_file_name = feature_file.name
        response.feedback_file_name = feedback_path.name

        return response

    def evaluate_execution(self) -> AutomationFeasibilityCoachResponse:
        """
        1. Runs script logic to catch features missing feedback files on disk.
        2. Passes features that DO have feedback files to the Coach Agent to check for missing scenario coverage.
        3. Combines both responses into a single AutomationFeasibilityCoachResponse.
        """
        features_dir = Path("features")

        # 1. Deterministic script check for missing feedback targets
        script_response = self.discover_missing_feasibility_targets(features_dir)
        combined_scope: List[FeasibilityTargetScope] = list(script_response.target_scope)

        # TODO: Make the agent able to check .feature and related feedback files and come up with a decision on
        #       whether to re-evaluate or skip. This is currently commented out because it is not yet implemented.
        """
        # 2. Process existing feedback files ONE BY ONE
        root_feature_files = [f for f in features_dir.glob("*.feature") if f.is_file()]

        for feature_file in root_feature_files:
            feedback_path = features_dir / f"{feature_file.stem}_feasibility_feedback.json"

            if feedback_path.exists():
                target_directive = self.evaluate_single_feature(feature_file, feedback_path)
                if target_directive:
                    combined_scope.append(target_directive)
        """

        # 3. Final aggregation check
        should_run = any(item.action in ("EVALUATE", "RE_EVALUATE") for item in combined_scope)

        return AutomationFeasibilityCoachResponse(
            target_scope=combined_scope,
            should_run_feasibility=should_run,
            should_harvest_patterns=True
        )
