import os
from langchain_ollama import ChatOllama
from openai import OpenAI
from pydantic import BaseModel

from .schemas import FeatureSuite
from .tradehub_domain import TRADEHUB_BUSINESS_KNOWLEDGE
from dotenv import load_dotenv

load_dotenv()


class OllamaAgentService:
    def __init__(self):
        # Local free model (e.g. llama3 or llama3.2:3b)
        self.llm = ChatOllama(model="llama3.2:3b", temperature=0.0)
        self.structured_llm = self.llm.with_structured_output(FeatureSuite)

    def generate_tests_for_instructions(self, test_instructions: str) -> dict | BaseModel:
        system_prompt = f"""
You are an expert Senior QA Engineer. Analyze the TradeHub User Instructions and generate BDD Gherkin test scenarios.

STRICT SYNTAX & FORMAL FEW-SHOT EXAMPLES:
- Scenario tags: @CamelCase (e.g., @LoginSuccess, @Register)
- Sentence patterns:
  - Given I open "https://www.tradehub.com.au/..."
  - And I click on [Element Name] button
  - When I enter "[Value]" into [Field Name] field
  - Then I see "[Expected Value]" as [Field Name] field value
  - And I should be redirected to the "[/path]" page

DYNAMIC TOKENS:
- "<RANDOM:8>" for randomized string inputs
- "<TODAY>" for dynamic date inputs

DOMAIN KNOWLEDGE:
{TRADEHUB_BUSINESS_KNOWLEDGE}

Target Requirements:
{test_instructions}
"""
        # Execute using Ollama locally
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
