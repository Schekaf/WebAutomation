import subprocess
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_ollama import ChatOllama

from ai_agents.core.config import get_agent_model
from ai_agents.core.utils import clean_gherkin_output

REVIEW_PROMPT = """You are an expert Python QA Automation Engineer specializing in the Behave BDD framework.
Your job is to review Python step definition code and fix any syntax errors, formatting issues, or linting errors reported by Ruff.

CRITICAL RULES:
- Fix all syntax errors, bad imports, and linting issues identified in the Ruff feedback.
- Preserve the exact test logic, step decorators (@given, @when, @then, @step), and function signatures unless a syntax fix directly requires a modification.
- Ensure all function bodies remain valid Python.
- Do NOT output markdown explanations, conversational prose, or code block wrappers.
- Output ONLY valid, executable Python code.

--- RUFF FEEDBACK ---
{ruff_errors}

--- ORIGINAL CODE ---
{code_str}

Python Code:
"""


class StepReviewAgent:
    """Agent that takes step definition code along with Ruff error reports and fixes it using an LLM."""

    def __init__(self, model_name: str | None = None, temperature: float = 0.0):
        # 1. Resolve agent name and lookup default model from central config
        self.agent_name = self.__class__.__name__
        self.model_name = model_name or get_agent_model(self.agent_name)

        # 2. Instantiate ChatOllama internally
        self.llm = ChatOllama(
            model=self.model_name,
            temperature=temperature
        )

        prompt = PromptTemplate.from_template(REVIEW_PROMPT)
        self.chain = prompt | self.llm | StrOutputParser()

    def run_ruff_check(self, code_str: str) -> str:
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

        raw_fix = self.chain.invoke(
            {"code_str": code_str, "ruff_errors": ruff_errors}
        )
        return clean_gherkin_output(raw_fix)
