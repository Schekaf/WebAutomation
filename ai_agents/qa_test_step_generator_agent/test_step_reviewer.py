import subprocess

from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import PromptTemplate
from langchain_ollama import ChatOllama

from ai_agents.core.utils import sanitize_model_tag_for_filename, clean_gherkin_output

REVIEW_PROMPT = """... [Keep existing system instructions] ...

--- RUFF FEEDBACK ---
{ruff_errors}

--- ORIGINAL CODE ---
{code_str}

CRITICAL: Output ONLY executable Python code. 
Start your response immediately with the code below. Do NOT write conversational introductions.

# Fixed Behave Step Definitions
"""


class StepReviewAgent:
    """Agent that takes broken code string along with Ruff error reports and fixes it using LLM."""

    def __init__(self, llm: ChatOllama):
        prompt = PromptTemplate.from_template(REVIEW_PROMPT)
        self.chain = prompt | llm | StrOutputParser()

    def run_ruff_check(self, code_str: str) -> str:
        """Passes Python code as a raw string to Ruff via stdin and returns stdout error output."""
        result = subprocess.run(
            ["ruff", "check", "-"],
            input=code_str,
            text=True,
            capture_output=True,
        )
        return result.stdout.strip()

    def review_and_fix(self, code_str: str) -> str:
        """Invokes the LLM chain to fix the code based on Ruff errors."""
        ruff_errors = self.run_ruff_check(code_str)
        raw_fix = self.chain.invoke(
            {"code_str": code_str, "ruff_errors": ruff_errors}
        )
        return clean_gherkin_output(raw_fix)
