import os
import re
import sys
from ai_agents.core.step_library import STEP_PATTERNS_LIBRARY, get_escaped_step_patterns
from ai_agents.core.tradehub_domain import TRADEHUB_RAW_INSTRUCTIONS
from ollama import ResponseError
from langchain_ollama import ChatOllama
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser

AVAILABLE_MODELS = {
    "1": ("Qwen 2.5 Coder 7B (Recommended for BDD)", "qwen2.5-coder:7b"),
    "2": ("Qwen 2.5 General 7B", "qwen2.5:7b"),
    "3": ("Llama 3.2 3B (Fast / Small)", "llama3.2:3b"),
    "4": ("DeepSeek R1 8B", "deepseek-r1:8b"),
}

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


def select_model_interactively() -> str:
    """Displays available models and prompts user for choice."""
    print("=" * 60)
    print("🤖 SELECT LLM ENGINE FOR FEATURE GENERATION")
    print("=" * 60)

    for key, (description, tag) in AVAILABLE_MODELS.items():
        print(f" [{key}] {description} -> (Tag: {tag})")

    print("=" * 60)
    choice = input("Enter option number [Default: 1]: ").strip()

    # Fallback to option 1 if invalid or empty selection
    if choice not in AVAILABLE_MODELS:
        print("⚡ No option chosen or invalid entry. Defaulting to Option [1].\n")
        choice = "1"

    selected_desc, selected_tag = AVAILABLE_MODELS[choice]
    print(f"✅ Selected Model: {selected_desc} ({selected_tag})\n")
    return selected_tag


def print_missing_model_error(missing_tag: str):
    """Displays a clean error message and prompt instructions when a model is not pulled."""
    print("\n" + "❌ " + "=" * 58)
    print(f" ERROR: Model '{missing_tag}' is not found locally!")
    print("=" * 60)
    print(" Please pull the model(s) using your terminal before running:")
    print()
    for _, (_, tag) in AVAILABLE_MODELS.items():
        prefix = "👉 " if tag == missing_tag else "   "
        print(f"{prefix}ollama pull {tag}")
    print("=" * 60 + "\n")


def split_instructions_into_sections(raw_text: str) -> list[str]:
    """Splits raw instructions into section chunks (matching lines starting with numbers like '1. ', '2. ')."""
    pattern = r'(?=\b\d+\.\s+[A-Z])'
    sections = re.split(pattern, raw_text)
    return [sec.strip() for sec in sections if sec.strip()]


def clean_gherkin_output(raw_text: str) -> str:
    """Removes conversational AI intros, markdown artifacts, and code fences."""
    # Strip markdown code fences
    cleaned = re.sub(r'```[a-zA-Z]*', '', raw_text).replace('```', '').strip()

    clean_lines = []
    for line in cleaned.splitlines():
        trimmed = line.strip()
        # Filter out conversational headers and markdown bold artifacts
        if (trimmed.startswith("**") or
                "Here are the" in trimmed or
                "Behave Gherkin" in trimmed or
                trimmed.startswith("Here is")):
            continue
        clean_lines.append(line)

    return "\n".join(clean_lines).strip()


def sanitize_model_tag_for_filename(model_tag: str) -> str:
    """Converts a model tag like 'qwen2.5-coder:7b' to a clean file-friendly string 'qwen2_5_coder_7b'."""
    # Replace colons, hyphens, and dots with underscores
    clean_tag = re.sub(r"[:\.\-]", "_", model_tag)
    # Remove any other non-alphanumeric/underscore characters
    return re.sub(r"[^a-zA-Z0-9_]", "", clean_tag)


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
