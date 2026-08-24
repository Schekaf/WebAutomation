import os
import re
from AI_Agent.tradehub_domain import TRADEHUB_RAW_INSTRUCTIONS
from langchain_ollama import ChatOllama
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser

PROMPT_TEMPLATE = """You are a Senior QA Automation Engineer writing detailed Behave Gherkin `.feature` scenarios for https://tradehub.com.au.

Target Section Requirements:
{section_text}

MANDATORY RULES FOR GHERKIN SCENARIO GENERATION:
1. Output EXACTLY ONE `Feature:` heading at the top corresponding to the section title.
2. For EVERY section write at least 1 Scenario by following check boxes (`* [ ] ...`) in the section, if you cannot combine all the ckeck boxes
as a test step in the scenario, write second or third scenario for the remaining check boxes.
3. The name of each `Scenario:` MUST be derived directly from the text of its specific bullet point. Never repeat scenario names.
4. DO NOT write duplicate scenarios. Every bullet point must produce a unique test case.
5. Syntax format to follow:
   Feature: [Section Title]

     @Tag_Name
     Scenario: [Bullet Point Text]
       Given I am logged in to "https://tradehub.com.au"
       When I perform the action specified by "[Bullet Point Action]"
       Then I verify "[Expected Result of Bullet Point]"

6. Output ONLY raw Gherkin text. Do NOT use markdown code fences (```). Do NOT write intro or outro text.

Generate the feature and scenarios now:

Generate the exact Behave Gherkin scenarios now:
"""


def split_instructions_into_sections(raw_text: str) -> list[str]:
    """Splits the raw instructions into distinct chunks by numbered sections (# 1. to # 20.)."""
    pattern = r'(?=# \d+\. )'
    sections = re.split(pattern, raw_text)
    return [sec.strip() for sec in sections if sec.strip()]


def main():
    llm = ChatOllama(model="llama3.2:3b", temperature=0.0)
    prompt = PromptTemplate.from_template(PROMPT_TEMPLATE)
    chain = prompt | llm | StrOutputParser()

    sections = split_instructions_into_sections(TRADEHUB_RAW_INSTRUCTIONS)
    print(f"Found {len(sections)} distinct sections to process...\n")

    os.makedirs("features", exist_ok=True)
    feature_file_path = os.path.join("features", "tradehub_smoke_tests.feature")

    with open(feature_file_path, "w", encoding="utf-8") as f:
        f.write("Feature: TradeHub Comprehensive Smoke Test Suite\n")
        f.write("  As a Trade Business user on TradeHub\n")
        f.write("  I want to test all features and edge cases across the platform\n")
        f.write("  So that I can verify full application stability and user experience\n\n")

        for index, section in enumerate(sections, 1):
            # Extract section heading for status tracking
            header_line = section.split('\n')[0]
            print(f"[{index}/{len(sections)}] Generating scenarios for: {header_line}...")

            gherkin_output = chain.invoke({"section_text": section})

            # Sanitize response to remove any accidental code fences
            cleaned_output = re.sub(r'```[a-zA-Z]*', '', gherkin_output).replace('```', '').strip()

            f.write(f"# ------------------------------------------------------------------\n")
            f.write(f"# Section: {header_line}\n")
            f.write(f"# ------------------------------------------------------------------\n")
            f.write(cleaned_output + "\n\n")

    print(f"\nSuccess! Full Gherkin suite written to: {os.path.abspath(feature_file_path)}")


if __name__ == "__main__":
    main()