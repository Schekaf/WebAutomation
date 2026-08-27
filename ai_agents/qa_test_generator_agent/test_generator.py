import os
from openai import OpenAI
from dotenv import load_dotenv
from langchain_ollama import ChatOllama
from pydantic import BaseModel

from ai_agents.core.schemas import FeatureSuite
from ai_agents.core.tradehub_domain import TRADEHUB_BUSINESS_KNOWLEDGE
from ai_agents.core.step_library import STEP_PATTERNS_LIBRARY, get_escaped_step_patterns

load_dotenv()


class OllamaAgentService:
    def __init__(self):
        # 1. format="json" forces local GBNF grammar sampler
        # 2. low temperature (0.1) enforces strict rule-following
        self.llm = ChatOllama(model="llama3.2:3b", temperature=0.1, format="json")
        self.structured_llm = self.llm.with_structured_output(FeatureSuite)

    def generate_tests_for_instructions(self, test_instructions: str) -> dict | BaseModel:
        system_prompt = f"""You are an expert Senior QA Engineer. Analyze the TradeHub User Instructions and generate BDD Gherkin test scenarios.

CRITICAL SYNTAX RULES:
1. Scenario tags MUST use @CamelCase (e.g., @LoginSuccess, @RegisterAccount).
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
{STEP_PATTERNS_LIBRARY}

DYNAMIC TOKENS:
- Use "<RANDOM:8>" for randomized string inputs.
- Use "<TODAY>" for dynamic date inputs.

DOMAIN KNOWLEDGE:
{TRADEHUB_BUSINESS_KNOWLEDGE}

Target Requirements:
{test_instructions}

CRITICAL RULES FOR GENERATION:
1. Cover ALL 20 sections of the smoke test requirements (Account Creation, ABN restrictions, Job Lifecycle, Tenders, Mobile UX, Negative/Break-it scenarios).
2. Ensure specific step definitions for Free vs. Premium tier boundaries and ABN workflow triggers.
3. Every test case must rigidly adhere to the response schema.
"""
        return self.structured_llm.invoke(system_prompt)


class OpenAPIAgentService:
    def __init__(self):
        self.client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))

    def generate_tests_for_instructions(self, test_instructions: str) -> FeatureSuite:
        system_prompt = f"""
You are an expert Senior QA Engineer. Your task is to analyze the provided TradeHub Smoke Testing User Instructions and generate complete BDD Gherkin test scenarios.

STRICT SYNTAX & FORMAL FEW-SHOT EXAMPLES TO FOLLOW:

Scenario Structure:
- Each scenario MUST have a concise @CamelCase tag (e.g., @LoginSuccess, @Register, @ABNVerificationRequired, @PostJobFreeTier).
- Steps MUST follow these exact sentence patterns:
  - Given I open "https://www.tradehub.com.au/..."
  - And I click on [Element Name] button
  - When I enter "[Value]" into [Field Name] field
  - Then I see "[Expected Value]" as [Field Name] field value
  - And I should be redirected to the "[/path]" page
  
DYNAMIC TOKENS TO USE:
- Use "<RANDOM:8>" for randomized string inputs (e.g., username, email prefix).
- Use "<TODAY>" for dynamic date inputs.
  
INCORPORATE THIS DOMAIN KNOWLEDGE INTO ALL TEST CASES:
{TRADEHUB_BUSINESS_KNOWLEDGE}

CRITICAL RULES FOR GENERATION:
1. Cover ALL 20 sections of the smoke test requirements (Account Creation, ABN restrictions, Job Lifecycle, Tenders, Mobile UX, Negative/Break-it scenarios).
2. Ensure specific step definitions for Free vs. Premium tier boundaries and ABN workflow triggers.
3. Every test case must rigidly adhere to the response schema.
"""

        response = self.client.beta.chat.completions.parse(
            model="gpt-4o",
            temperature=0.0,  # Enforces maximum determinism
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user",
                 "content": f"Generate structured test cases for these instructions:\n\n{test_instructions}"}
            ],
            response_format=FeatureSuite
        )
        return response.choices[0].message.parsed
