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
from pathlib import Path
from typing import List, Dict, Any
import re
import json
from langchain_core.prompts import PromptTemplate
from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.schemas import TestGenerationCoachResponse

TEST_GENERATION_COACH_PROMPT = """You are the Test Generation Coach Agent responsible for gatekeeping the BDD feature generation phase.

BUSINESS REQUIREMENTS DOCUMENT:
{requirements_doc}

EXISTING FEATURE FILES IN ROOT (SUMMARY):
{existing_features_summary}

YOUR TASK:
Analyze the business requirements document against existing feature files and past lessons learned.
Determine EXACTLY which feature files must be GENERATED from scratch, REGENERATED due to requirements updates/past failure modes, or SKIPPED.

RULES & DIRECTIVES:
1. "GENERATE": Feature is explicitly or implicitly required by the business document but missing from existing feature files.
2. "REGENERATE": Feature file exists, but requirements have changed OR past lessons learned indicate known structure/step failures in this feature.
3. "SKIP": Feature file exists, fully covers requirements, and has no flagged historical failure patterns.

For each feature in your target scope:
- Provide a clear `feature_file_name` (e.g., '11_create_a_project_tender.feature').
- Provide an explicit `action` ("GENERATE", "REGENERATE", or "SKIP").
- Provide a precise `reason` for your directive.
- Pass relevant `lessons_for_agent` strings if historical patterns failed in similar features.
"""


class TestGenerationCoachAgent(BaseAgent):
    """
    Supervisory Coach Agent that inspects current pipeline state
    and determines whether test generation agents should execute or skip.
    """

    def __init__(self, **kwargs):
        super().__init__(temperature=0.0, **kwargs)

        prompt = PromptTemplate.from_template(TEST_GENERATION_COACH_PROMPT)
        # Bind structured output directly to ensure deterministic CoachDecision objects
        self.chain = prompt | self.llm.with_structured_output(TestGenerationCoachResponse)

    @staticmethod
    def get_section_summary(sections: List[str], model_slug: str) -> List[Dict[str, Any]]:
        sections_payload = []
        for index, section in enumerate(sections, 1):
            first_line = section.split('\n')[0].strip()
            sanitized_name = re.sub(r'[^a-zA-Z0-9_]', '_', first_line.lower())
            file_name = f"{index:02d}_{sanitized_name}_{model_slug}.feature"

            sections_payload.append({
                "section_index": index,
                "section_title": first_line,
                "target_file_name": file_name,
                "file_exists": (Path("features") / file_name).exists()
            })
        return sections_payload

    def evaluate_execution(self, requirements_doc: str, existing_features_summary: List[Dict[str, Any]]) -> TestGenerationCoachResponse:
        """
        Evaluates gate criteria for target_agent based on current pipeline context.
        """
        try:
            # BaseAgent.invoke automatically injects lessons_learned for TestGenerationCoachAgent
            coach_response: TestGenerationCoachResponse = self.invoke(
                self.chain,
                {
                    "requirements_doc": requirements_doc,
                    "existing_features_summary": json.dumps(existing_features_summary, indent=2, ensure_ascii=False)
                }
            )
            return coach_response
        except Exception as e:
            print(f"   ⚠️ [TestGenerationCoachAgent] Scope analysis error: {e}")
            # Fallback safe response to ensure pipeline continuity
            return TestGenerationCoachResponse(
                should_run_generator=True,
                target_scope=[]
            )