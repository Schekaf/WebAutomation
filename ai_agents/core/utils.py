import glob
import os
import re
import functools
import time

PERF_LIST = {
}


def timer(func):
    """Decorator to measure execution time of any function."""

    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        t_start = time.perf_counter()
        result = func(*args, **kwargs)
        t_end = time.perf_counter()
        print(f"\033[33m⚡ [PERF] `{func.__name__}` took {t_end - t_start:.3f}s to run.\033[0m")
        PERF_LIST[func.__name__] = t_end - t_start
        return result

    return wrapper


def pre_mask_step(step_text: str) -> str:
    """
    Masks string literals in quotes and numbers into explicit placeholders BEFORE
    Drain processes them, protecting verbs like 'click', 'enter', and 'see'.
    """
    # Preserve quotes, mask inner content to "<PARAM>"
    masked = re.sub(r'(["\'])(.*?)\1', r'"<PARAM>"', step_text)
    # Mask standalone numbers
    masked = re.sub(r'\b\d+(\.\d+)?\b', '<PARAM>', masked)
    return masked


def collapse_drain_patterns(drain_lines: list[str]) -> list[str]:
    """
    Transforms Drain3 output lines by replacing all double-quoted strings
    and Drain3 tokens (<PARAM>, <NUM>, <*>) with unified {param} placeholders.
    """
    collapsed_patterns = set()

    for line in drain_lines:
        line = line.strip()
        if not line:
            continue

        # 1. Replace ANY double-quoted string "..." with {param}
        # Handles long phrases like "Develop a new web application with advanced features"
        line_clean = re.sub(r'"[^"]*"', '{param}', line)

        # 2. Replace single-quoted strings '...' with {param}
        line_clean = re.sub(r"'[^']*'", '{param}', line_clean)

        # 3. Replace Drain3 wildcard tokens (<PARAM>, <NUM>, <*>)
        line_clean = re.sub(r'(\<(PARAM|NUM|\*)\>\s*)+', '{param} ', line_clean)
        line_clean = line_clean.replace('<PARAM>', '{param}').replace('<NUM>', '{param}').replace('<*>', '{param}')

        # 4. Collapse multiple consecutive {param} placeholders into a single {param}
        # (e.g., if Drain3 produced "<*> <*>", collapse it to one "{param}")
        line_clean = re.sub(r'(\{param\}\s*)+', '{param} ', line_clean)

        # 5. Clean up extra spaces
        line_clean = re.sub(r'\s+', ' ', line_clean).strip()

        # 6. Re-wrap parameters in clean quotes for standard Gherkin syntax
        line_clean = line_clean.replace('{param}', '"{param}"')

        collapsed_patterns.add(line_clean)

    return sorted(list(collapsed_patterns))


def aggregate_by_verb_prefix(patterns: list[str]) -> list[str]:
    """
  If a longer, more parameterized pattern exists for a verb prefix,
  drops the shorter ambiguous versions.
  """
    # Sort by length descending so longer, more specific patterns take priority
    sorted_patterns = sorted(patterns, key=len, reverse=True)
    final_patterns = []

    for p in sorted_patterns:
        # Check if this pattern is a subset/prefix of an already accepted pattern
        is_subset = False
        for accepted in final_patterns:
            # If 'I select "{param}"' is inside 'I select "{param}" as "{param}"', skip the short one!
            prefix_stem = p.split('"{param}"')[0].strip()
            if prefix_stem and prefix_stem in accepted and len(p) < len(accepted):
                is_subset = True
                break

        if not is_subset:
            final_patterns.append(p)

    return sorted(final_patterns)


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


def discover_all_feature_files(features_dir: str, model_slug: str = None) -> list[str]:
    """Recursively finds .feature files under features/. Filtered by model_slug if provided."""
    all_feature_files = glob.glob(os.path.join(features_dir, "**", "*.feature"), recursive=True)

    if model_slug:
        # Match files ending with `_{model_slug}.feature`
        target_suffix = f"_{model_slug}.feature"
        matched_files = [f for f in all_feature_files if os.path.basename(f).endswith(target_suffix)]
        return sorted(matched_files)

    return sorted(all_feature_files)


def sanitize_model_tag_for_filename(model_tag: str) -> str:
    """Converts a model tag like 'qwen2.5-coder:7b' to a clean file-friendly string 'qwen2_5_coder_7b'."""
    # Replace colons, hyphens, and dots with underscores
    clean_tag = re.sub(r"[:\.\-]", "_", model_tag)
    # Remove any other non-alphanumeric/underscore characters
    return re.sub(r"[^a-zA-Z0-9_]", "", clean_tag)
