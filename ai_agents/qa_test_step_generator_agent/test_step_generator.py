from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_ollama import ChatOllama

from ai_agents.core.config import get_agent_model
from ai_agents.core.utils import clean_gherkin_output

PROMPT = """You are an Expert Test Automation Engineer specializing in Python Behave and Web UI Automation.
Your task is to take Python Behave step definition skeletons (signatures with `pass`) and implement realistic execution code for a Web UI framework.

CRITICAL RULES:
- Implement the body of each step function replace `pass` with clean execution logic (e.g., using context, element interactions, or assertions).
- Keep parameter names and decorators (@given, @when, @then, @step) intact.
- Do NOT output markdown code fences (```) or explanations.
- Output ONLY valid, executable Python code.

STEP SKELETONS:
{skeletons}

Python Implementation:
"""


class StepGeneratorAgent:
    """
    Phase 3 Code Generator Agent: Accepts skeleton function definitions (`pass`)
    and implements standard UI automation logic.
    """

    def __init__(self, model_name: str | None = None):
        # 1. Resolve agent name and lookup default model from central config
        self.agent_name = self.__class__.__name__
        self.model_name = model_name or get_agent_model(self.agent_name)

        # 2. Initialize LLM instance using the resolved static model
        self.llm = ChatOllama(
            model=self.model_name,
            temperature=0.0,
            repeat_penalty=1.2
        )

        # 3. Build execution chain
        prompt = PromptTemplate.from_template(PROMPT)
        self.chain = prompt | self.llm | StrOutputParser()

    def generate_missing_steps(self, combined_skeletons: str) -> str:
        """
        Takes aggregated Python step skeletons and fills in execution logic.
        """
        if not combined_skeletons or not combined_skeletons.strip():
            return ""

        raw_generated_code = self.chain.invoke({
            "skeletons": combined_skeletons
        })

        # Sanitize and return draft code
        return clean_gherkin_output(raw_generated_code)
