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

import subprocess
from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.utils import clean_gherkin_output

REVIEW_PROMPT = """You are an Expert Python QA Automation Engineer specializing in the Behave BDD framework.
Your job is to review Python step definition code, fix syntax/AST errors, and resolve linting issues reported by Ruff.

--- RUFF FEEDBACK ---
{ruff_errors}

--- ORIGINAL CODE ---
{code_str}

LESSONS LEARNED:
{lessons_learned}

CRITICAL REVIEW RULES:
- FIX DUPLICATE FUNCTION NAMES: If any functions are named `step_impl`, rename them uniquely to match their decorator intent (e.g., `step_impl_1`, `step_impl_2` or `step_enter_value`).
- FIX SYNTAX ERRORS: Fix mismatched quotes, invalid decorator parameters, missing arguments, or bad import paths.
- REMOVE WILDCARD STACKS: If you find stacked decorators over `def step_impl(context, *args): pass`, expand them back into individual functions.
- PRESERVE TEST LOGIC: Do not alter element interaction logic unless required to fix syntax errors.
- OUTPUT RAW PYTHON ONLY: Do NOT output markdown explanations, code block wrappers (```python), or summaries.

Python Code:
"""


class StepReviewAgent(BaseAgent):
    """Agent that takes step definition code along with Ruff error reports and fixes it using an LLM."""

    def __init__(self, **kwargs):
        # 1. Delegate LLM, model, and lessons_manager setup to BaseAgent
        super().__init__(temperature=0.0, timeout=60.0, **kwargs)

        # 2. Create chain via BaseAgent helper
        self.chain = self.create_chain(REVIEW_PROMPT)

    @staticmethod
    def run_ruff_check(code_str: str) -> str:
        """Passes Python code as a raw string to Ruff via stdin and returns stdout error output."""
        try:
            result = subprocess.run(
                ["ruff", "check", "-"],
                input=code_str,
                text=True,
                capture_output=True,
            )
            return result.stdout.strip()
        except FileNotFoundError:
            # Fallback if ruff CLI is not installed in current environment
            return ""

    def review_and_fix(self, code_str: str) -> str:
        """Invokes the LLM chain to fix the code based on Ruff errors."""
        if not code_str.strip():
            return ""

        ruff_errors = self.run_ruff_check(code_str)

        # If Ruff passes with zero errors, return original code string directly without LLM call
        if not ruff_errors:
            return code_str

        # Invokes chain via BaseAgent helper (automatically injects "lessons_learned")
        raw_fix = self.invoke(
            self.chain,
            {"code_str": code_str, "ruff_errors": ruff_errors}
        )
        return clean_gherkin_output(raw_fix)