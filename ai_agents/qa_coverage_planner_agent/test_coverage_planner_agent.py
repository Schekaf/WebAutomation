from langchain_ollama import ChatOllama
from ai_agents.core.config import get_agent_model

from ai_agents.core.schemas import CoveragePlan


class CoveragePlannerAgent:
    """
    Analyzes business requirements and determines the exact list of
    test scenarios required for complete test coverage before generating Gherkin.
    """

    def __init__(self, model_name: str | None = None):
        # 1. Resolve agent name and model lookup dynamically
        self.agent_name = self.__class__.__name__
        self.model_name = model_name or get_agent_model(self.agent_name)

        # 2. Initialize Ollama instance with resolved model
        self.llm = ChatOllama(
            model=self.model_name,
            temperature=0.0,
            format="json"
        )
        self.structured_llm = self.llm.with_structured_output(CoveragePlan)

    def plan_coverage(self, requirement_text: str, section_name: str = "Requirement Section") -> CoveragePlan:
        prompt = f"""You are a Lead Test Architect specializing in Test Scenario Planning and Coverage.

YOUR TASK:
Analyze the following business requirement text and determine ALL necessary test scenarios required to achieve 100% functional test coverage.

REQUIRMENT TEXT ({section_name}):
{requirement_text}

INSTRUCTIONS:
1. Identify all explicit rules, acceptance criteria, and implicit edge cases.
2. Generate scenarios covering:
   - HAPPY_PATH: Standard successful flows.
   - NEGATIVE: Invalid inputs, insufficient permissions, rejected transactions.
   - BOUNDARY_EDGE_CASE: Limit caps, zero/negative quantities, threshold boundaries.
3. Output strictly valid JSON matching the specified schema.
"""
        response = self.structured_llm.invoke(prompt)
        # 1. If LangChain already returned a CoveragePlan object, return it directly
        if isinstance(response, CoveragePlan):
            return response

        # 2. If it returned a dictionary (raw JSON fallback), unpack into CoveragePlan
        elif isinstance(response, dict):
            return CoveragePlan(**response)
        else:
            raise TypeError(f"Expected CoveragePlan instance, but received {type(response).__name__}: {response}")
