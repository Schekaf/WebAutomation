from langchain_core.prompts import PromptTemplate

from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.schemas import CoveragePlan
from ai_agents.core.utils import rest_check

PLANNER_PROMPT = """You are a Lead Test Architect specializing in Test Scenario Planning and Functional Coverage Analysis.

YOUR TASK:
Analyze the provided business requirement text and construct a complete, high-density test coverage plan that achieves 100% functional, operational, and edge-case coverage.

REQUIREMENT SECTION:
{requirement_section}

REQUIREMENT TEXT:
{requirement_text}

LESSONS LEARNED (PAST FAILURE MODES TO AVOID):
{lessons_learned}

COVERAGE SCOPE & CATEGORIES:
1. HAPPY_PATH: Core business flows, multi-step end-to-end user journeys, and valid default states.
2. NEGATIVE: Unauthorized access, invalid payload inputs, rejected transactions, business logic violations, and exception handlings.
3. BOUNDARY_EDGE_CASE: Numerical thresholds ($0$, negative numbers, max integer caps), empty/null string inputs, character limits, rate limits, state transition conflicts, and concurrent operations.

STRICT GENERATION RULES:
1. EXHAUSTIVE SPECIFICATION COVERAGE: Every explicit rule, business constraint, and acceptance criterion in the text MUST map to at least one test scenario.
2. FIELD LENGTH LIMITS (CRITICAL):
   - "title": Maximum 8 words. Direct, action-oriented, and specific.
   - "objective": Exactly 1 concise sentence (max 18 words). State precisely what condition is verified and the expected result.
3. NO HALTING OR OMISSION: Do not summarize or combine distinct scenarios. Generate explicit, discrete scenarios for each distinct logic path.
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

    @rest_check
    def plan_coverage(self, requirement_text: str, requirement_section: str = "Requirement Section") -> CoveragePlan:
        """
        Executes the scenario coverage planning chain for the provided requirement text.
        """
        # BaseAgent.invoke automatically loads and injects {lessons_learned}
        response = self.invoke(
            self.chain,
            {
                "requirement_section": requirement_section,
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