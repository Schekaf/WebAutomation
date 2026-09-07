import os
from openai import OpenAI
from dotenv import load_dotenv
from langchain_ollama import ChatOllama
from pydantic import BaseModel

from ai_agents.core.config import get_agent_model
from ai_agents.core.schemas import FeatureSuite, CoveragePlan
from ai_agents.core.tradehub_domain import TRADEHUB_BUSINESS_KNOWLEDGE
from ai_agents.core.step_library import STEP_PATTERNS_LIBRARY, get_escaped_step_patterns
from langchain_ollama import ChatOllama

load_dotenv()

PROMPT = """You are an expert Senior QA Engineer writing Behave BDD Gherkin scenarios.

YOUR TASK:
Translate the planned scenarios from the provided CoveragePlan into concrete Gherkin steps matching the FeatureSuite schema.

FEATURE CONTEXT:
Requirement Section: {requirement_section}

PLANNED SCENARIOS TO TRANSLATE:
{coverage_plan}

CRITICAL SYNTAX RULES:
1. Scenario tags MUST use @CamelCase (e.g., @LoginSuccess, @RegisterAccount). Preserve tags from the CoveragePlan where applicable.
2. EVERY step in EVERY scenario MUST be an EXACT literal instance from the STEP PATTERNS library below.
3. Replace all placeholders inside double quotes with real literal data or UI elements.
4. NEVER write generic descriptive text.

FEW-SHOT SYNTAX EXAMPLES:
  ALLOWED:
  - Given I open "https://www.tradehub.com.au/register"
  - When I click on Create Account
  - And I select "Trade Business" as Account Type
  - And I enter "Furkan" as Name
  - Then I see Success Message is Visible

  DISALLOWED (DO NOT WRITE STEPS LIKE THIS):
  - When I enter my name in the "Name" field
  - Then I should see a success message
  - And I select option to register

STEP PATTERNS:
{step_patterns}

DYNAMIC TOKENS:
- Use "<RANDOM:8>" for randomized string inputs.
- Use "<TODAY>" for dynamic date inputs.

DOMAIN KNOWLEDGE:
{business_knowledge}

CRITICAL RULES FOR GENERATION:
1. Translate EVERY planned scenario from the CoveragePlan into a ScenarioItem.
2. Ensure specific step definitions for Free vs. Premium tier boundaries and ABN workflow triggers where specified.
3. Every test case must rigidly adhere to the response schema.
"""


class TestGeneratorAgent:
    """
    Phase 1 Agent: Translates structured CoveragePlan objects into complete,
    schema-validated Gherkin FeatureSuite objects.
    """

    def __init__(self, model_name: str | None = None):
        # 1. Resolve agent name and model lookup dynamically
        self.agent_name = self.__class__.__name__
        self.model_name = model_name or get_agent_model(self.agent_name)

        # 1. format="json" forces local GBNF grammar sampler
        # 2. low temperature (0.1) enforces strict rule-following
        self.llm = ChatOllama(model=self.model_name,  temperature=0.1, format="json")
        self.structured_llm = self.llm.with_structured_output(FeatureSuite)

    def generate_tests_for_instructions(
            self,
            coverage_plan: CoveragePlan,
            step_patterns: str = "",
            business_knowledge: str = ""
    ) -> FeatureSuite:
        formatted_prompt = PROMPT.format(
            requirement_section=coverage_plan.requirement_section,
            coverage_plan=coverage_plan.model_dump_json(indent=2),
            step_patterns=step_patterns,
            business_knowledge=business_knowledge
        )
        response = self.structured_llm.invoke(formatted_prompt)
        if isinstance(response, FeatureSuite):
            return response

        if isinstance(response, dict):
            return FeatureSuite(**response)

        raise TypeError(f"Expected FeatureSuite instance, received: {type(response).__name__}")


class SampleOpenAPIAgentService:
    def __init__(self):
        self.client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

    def generate_tests_for_instructions(self,
            coverage_plan: CoveragePlan,
            step_patterns: str = "",
            business_knowledge: str = ""
    ) -> FeatureSuite:
        formatted_prompt = PROMPT.format(
            requirement_section=coverage_plan.requirement_section,
            coverage_plan_json=coverage_plan.model_dump_json(indent=2),
            step_patterns=step_patterns,
            business_knowledge=business_knowledge
        )

        response = self.client.beta.chat.completions.parse(
            model="gpt-4o",
            temperature=0.0,  # Enforces maximum determinism
            messages=[
                {"role": "system", "content": formatted_prompt},
                {"role": "user",
                 "content": f"Generate structured test cases for these instructions:\n\n{coverage_plan.requirement_section}"}
            ],
            response_format=FeatureSuite
        )
        return response.choices[0].message.parsed
