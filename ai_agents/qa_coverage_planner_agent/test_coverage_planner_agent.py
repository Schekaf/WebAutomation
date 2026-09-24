from langchain_core.prompts import PromptTemplate

from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.schemas import CoveragePlan

PLANNER_PROMPT = """You are a Lead Test Architect specializing in Test Scenario Planning and Coverage.

YOUR TASK:
Analyze the following business requirement text and determine ALL necessary test scenarios required to achieve 100% functional test coverage.

REQUIREMENT TEXT ({section_name}):
{requirement_text}

LESSONS LEARNED (PAST FAILURE MODES TO AVOID):
{lessons_learned}

INSTRUCTIONS:
1. Identify all explicit rules, acceptance criteria, and implicit edge cases.
2. Generate scenarios covering:
   - HAPPY_PATH: Standard successful flows.
   - NEGATIVE: Invalid inputs, insufficient permissions, rejected transactions.
   - BOUNDARY_EDGE_CASE: Limit caps, zero/negative quantities, threshold boundaries.
3. Output strictly valid JSON matching the specified schema.
"""


class CoveragePlannerAgent(BaseAgent):
    """
    Analyzes business requirements and determines the exact list of
    test scenarios required for complete test coverage before generating Gherkin.
    """

    def __init__(self, **kwargs):
        # 1. Delegate LLM, model, and lessons_manager setup to BaseAgent
        super().__init__(temperature=0.0, format_json=True, **kwargs)

        # 2. Build structured output chain using BaseAgent's LLM
        prompt = PromptTemplate.from_template(PLANNER_PROMPT)
        self.chain = prompt | self.llm.with_structured_output(CoveragePlan)

    def plan_coverage(self, requirement_text: str, section_name: str = "Requirement Section") -> CoveragePlan:
        """
        Executes the scenario coverage planning chain for the provided requirement text.
        """
        # BaseAgent.invoke automatically loads and injects {lessons_learned}
        response = self.invoke(
            self.chain,
            {
                "section_name": section_name,
                "requirement_text": requirement_text,
            }
        )

        # 1. If LangChain returned a CoveragePlan object directly, return it
        if isinstance(response, CoveragePlan):
            return response

        # 2. If it returned a dictionary (raw JSON fallback), unpack into CoveragePlan
        if isinstance(response, dict):
            return CoveragePlan(**response)

        raise TypeError(f"Expected CoveragePlan instance, but received {type(response).__name__}: {response}")