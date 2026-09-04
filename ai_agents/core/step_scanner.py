import json
import os
import re
import subprocess
from typing import List

from ai_agents.core.utils import timer


def strip_gherkin_prefix(step_text: str) -> str:
    """Removes leading Given, When, Then, And, But keywords from a step string."""
    return re.sub(r"^(Given|When|Then|And|But)\s+", "", step_text.strip(), flags=re.IGNORECASE)


def get_undefined_steps_via_behave(feature_files: List[str]) -> List[str]:
    """
    Runs Behave in dry-run mode per feature file to identify genuinely missing steps,
    stripping Given/When/Then/And/But prefixes from the returned step strings.
    """
    if not feature_files:
        return []

    undefined_steps = set()

    for feature_file in feature_files:
        cmd = [
            "behave",
            "--dry-run",
            "--format",
            "json",
            "--no-summary",
            "--no-snippets",
            feature_file,
        ]

        result = subprocess.run(cmd, capture_output=True, text=True)

        # Check if Behave failed due to ParserError
        if result.returncode != 0 and "ParserError" in result.stderr:
            rel_path = os.path.basename(feature_file)
            print(f"   ⚠️ Skipping malformed feature file (Gherkin syntax error): {rel_path}")
            continue

        try:
            features_data = json.loads(result.stdout)
            for feature in features_data:
                for element in feature.get("elements", []):
                    for step in element.get("steps", []):
                        result_info = step.get("result", {})
                        status = result_info.get("status")

                        # If step is undefined or missing a step match
                        if status == "undefined" or not step.get("match"):
                            raw_name = step.get("name", "").strip()
                            if raw_name:
                                # Strip any inline or explicit Gherkin prefix
                                clean_step = strip_gherkin_prefix(raw_name)
                                undefined_steps.add(clean_step)

        except json.JSONDecodeError:
            # Fallback parsing in case stdout contained extra text
            for line in result.stdout.splitlines():
                if "undefined" in line.lower():
                    clean_step = strip_gherkin_prefix(line.strip())
                    if clean_step:
                        undefined_steps.add(clean_step)

    return sorted(list(undefined_steps))
