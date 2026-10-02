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
from typing import List, Dict, Any, Union, Set
import json
from langchain_core.prompts import PromptTemplate
from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.schemas import StepImplementationCoachResponse

STEP_IMPLEMENTATION_COACH_PROMPT = """You are the Step Implementation Generation Coach Agent responsible for gatekeeping Phase 4 code generation.

UNDEFINED STEP PATTERNS (FROM BEHAVE DRY-RUN / PATTERN MINING):
{undefined_step_patterns}

EXISTING STEP DEFINITIONS CODEBASE:
{existing_step_definitions}

YOUR TASK:
Analyze the undefined step patterns extracted from the test suite against existing step definitions and past lessons learned.
Determine EXACTLY which step definitions must be GENERATE or SKIPPED.

RULES & DIRECTIVES:
1. "GENERATE": The step is undefined and requires new Python step definition code.
2. "SKIP": The step pattern is already covered in existing step definitions, invalid, or non-automatable.

CRITICAL INSTRUCTION:
For EVERY pattern listed in UNDEFINED STEP PATTERNS, you MUST create a corresponding entry in `target_scope`.
Set `should_run_generator=True` ONLY if at least one step pattern requires "GENERATE".
"""


class StepImplementationGenerationCoachAgent(BaseAgent):
    """
    Supervisory Coach Agent that evaluates undefined Gherkin step patterns
    against existing step definitions before triggering Python code generation.
    """

    def __init__(self, **kwargs):
        super().__init__(temperature=0.0, **kwargs)

        prompt = PromptTemplate.from_template(STEP_IMPLEMENTATION_COACH_PROMPT)
        self.chain = prompt | self.llm.with_structured_output(StepImplementationCoachResponse)

    def evaluate_execution(
        self,
        undefined_step_patterns: Union[List[str], Set[str]],
        existing_step_definitions: List[str]
    ) -> StepImplementationCoachResponse:
        """
        Evaluates gate criteria for Phase 4 step code generation based on undefined steps.
        """
        try:
            patterns_list = list(undefined_step_patterns)

            if not patterns_list:
                return StepImplementationCoachResponse(
                    should_run_generator=False,
                    target_scope=[]
                )

            coach_response: StepImplementationCoachResponse = self.invoke(
                self.chain,
                {
                    "undefined_step_patterns": json.dumps(patterns_list, indent=2, ensure_ascii=False),
                    "existing_step_definitions": json.dumps(existing_step_definitions, indent=2, ensure_ascii=False)
                }
            )
            return coach_response
        except Exception as e:
            print(f"   ⚠️ [StepImplementationGenerationCoachAgent] Scope analysis error: {e}")
            return StepImplementationCoachResponse(
                should_run_generator=True,
                target_scope=[]
            )