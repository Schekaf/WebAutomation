import re


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