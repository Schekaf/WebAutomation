import os
import re
import sys
from ai_agents.core.step_library import get_escaped_step_patterns
from ai_agents.core.tradehub_domain import TRADEHUB_RAW_INSTRUCTIONS
from ai_agents.core.model_selector import select_model_interactively, print_missing_model_error
from ai_agents.core.utils import sanitize_model_tag_for_filename, clean_gherkin_output, split_instructions_into_sections
from ollama import ResponseError
from langchain_ollama import ChatOllama
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser


PROMPT_TEMPLATE = """You are a Senior QA Automation Engineer writing Behave Gherkin `.feature` scenarios for TradeHub (https://tradehub.com.au).

TARGET SECTION REQUIREMENTS:
{section_text}

STRICT STEP PATTERNS LIBRARY (EVERY STEP MUST STRICTLY MATCH A PATTERN BELOW):
{step_patterns}

MANDATORY RULES:
1. Output EXACTLY ONE `Feature:` heading corresponding to the section title.
2. Generate specific Scenarios or Scenario Outlines for the requirements in this section.
3. Use @CamelCase tags for every scenario (e.g., @SmokeTest, @NegativeTesting).
4. DO NOT write conversational text, markdown bolding (e.g., **Header**), or commentary.
5. Do NOT invent fake UI elements (e.g., "Break Button", "Mobile Button").
6. Output ONLY raw Gherkin text. Do NOT use markdown code fences.

Generate the feature and scenarios now:
"""


def main():
    # Step 1: Select LLM model interactively
    selected_model_tag = select_model_interactively()
    model_slug = sanitize_model_tag_for_filename(selected_model_tag)
    llm = ChatOllama(model=selected_model_tag, temperature=0.1)

    # Step 2: Prepare the prompt template and chain
    prompt = PromptTemplate.from_template(PROMPT_TEMPLATE)
    chain = prompt | llm | StrOutputParser()

    # Step 3: Split raw instructions into distinct sections
    sections = split_instructions_into_sections(TRADEHUB_RAW_INSTRUCTIONS)
    print(f"Found {len(sections)} distinct sections to process...\n")

    # Step 4: Create output directory for generated feature files
    output_dir = "features"
    os.makedirs(output_dir, exist_ok=True)

    for index, section in enumerate(sections, 1):
        # Extract section title (e.g., "1. Create a New Account")
        first_line = section.split('\n')[0].strip()

        # Create a clean filename slug (e.g., "01_create_a_new_account.feature")
        sanitized_name = re.sub(r'[^a-zA-Z0-9_]', '_', first_line.lower())
        file_name = f"{index:02d}_{sanitized_name}_{model_slug}.feature"
        file_path = os.path.join(output_dir, file_name)

        print(f"[{index}/{len(sections)}] Generating: {first_line} -> {file_name}...")

        try:
            raw_output = chain.invoke(
                {
                    "section_text": section,
                    "step_patterns": get_escaped_step_patterns(),
                }
            )
        except ResponseError as e:
            if e.status_code == 404 or "not found" in str(e).lower():
                print_missing_model_error(selected_model_tag)
                sys.exit(1)
            else:
                raise e

        cleaned_gherkin = clean_gherkin_output(raw_output)

        # Write to an individual .feature file for Behave compatibility
        with open(file_path, "w", encoding="utf-8") as f:
            f.write(cleaned_gherkin + "\n")

    print(f"\nSuccess! Generated {len(sections)} distinct .feature files in: {os.path.abspath(output_dir)}")


if __name__ == "__main__":
    main()
