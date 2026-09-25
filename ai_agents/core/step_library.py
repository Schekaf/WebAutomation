# Web Automation Framework Empowered by Local AI Agents
# Copyright (C) 2026  A. Furkan KIZILTEPE <furkan.kiziltepe@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

import json
from pathlib import Path
from typing import Dict, Set, Any, List
import re

# Static baseline library of framework step patterns
STEP_PATTERNS_LIBRARY = """STRICT STEP PATTERNS:
ActionSteps:
- I click on {element}
- I drag {source} to {destination} and drop
- I right click on {element}
- I select "{value}" as {element}
- I deselect "{value}" as {element}
- I enter "{value}" in {element}
- I paste "{value}" in {element}

BrowserSteps:
- I open "{url}"
- I click the Go Back Button
- I press on {key} Key

ValidationSteps:
- I see {element} is "{option}"
- I see "{values}" is selected as {element}
- I see {values} in "{element}" Values
- I do not see {element}
"""


def get_escaped_step_patterns() -> str:
    """Returns step patterns with escaped curly braces for LangChain templates."""
    return STEP_PATTERNS_LIBRARY.replace("{", "{{").replace("}", "}}")


class PatternRegistry:
    def __init__(self, initial_patterns: Set[str]):
        # Active pattern lookup set
        self._patterns: Set[str] = set(initial_patterns)

        # Pattern Metadata Tracking
        self.registry: Dict[str, Dict[str, Any]] = {
            p: {
                "usage_count": 0,
                "status": "matched",
                "sources": []
            }
            for p in initial_patterns
        }

    @staticmethod
    def clean_pattern(pattern: str) -> str:
        """
        Normalizes pattern strings by fixing truncated wildcards and stripping stray quotes.
        """
        if not pattern:
            return ""

        p = pattern.strip()

        # 1. Strip leading/trailing double or single quotes if present
        if (p.startswith('"') and p.endswith('"')) or (p.startswith("'") and p.endswith("'")):
            p = p[1:-1].strip()

        # 2. Fix malformed/truncated wildcards like '<*' at the end of the string -> '<*>'
        p = re.sub(r'<\*(?!>)', '<*>', p)

        # 3. Collapse multiple spaces into a single space
        p = re.sub(r'\s+', ' ', p)

        return p

    @property
    def active_patterns(self) -> Set[str]:
        """Returns the current set of known patterns (initial + dynamic)."""
        return self._patterns

    def contains(self, pattern: str) -> bool:
        """Fast check if a pattern is in the active set."""
        return pattern in self._patterns

    def add_pattern(self, pattern: str, status: str = "suggested"):
        """Adds a new pattern to both lookup set and registry map."""
        if pattern not in self._patterns:
            self._patterns.add(pattern)
            self.registry[pattern] = {
                "usage_count": 0,
                "status": status,
                "sources": []
            }
            print(f"   🌱 Added new {status} pattern to registry: '{pattern}'")

    def record_usage(self, pattern: str, step_text: str, scenario_title: str) -> str:
        """
        Tracks usage count, dynamically registers new patterns if missing,
        and returns the deterministic pattern_status ('matched' vs 'suggested').
        """
        if pattern not in self.registry:
            self.add_pattern(pattern, status="suggested")

        entry = self.registry[pattern]
        entry["usage_count"] += 1
        entry["sources"].append({"scenario": scenario_title, "step": step_text})
        return entry["status"]

    def get_used_patterns(self) -> List[str]:
        """Returns all patterns that have at least 1 usage."""
        return [p for p, data in self.registry.items() if data["usage_count"] > 0]

    def get_new_suggested_patterns(self) -> List[str]:
        """Returns only suggested patterns that were actually used."""
        return [
            p for p, data in self.registry.items()
            if data["status"] == "suggested" and data["usage_count"] > 0
        ]

    @staticmethod
    def get_used_patterns_from_feedback_file(feedback_file_path: str) -> Set[str]:
        """Extracts and returns a Set of all unique patterns used in a single feedback JSON file."""
        used_patterns: Set[str] = set()
        path = Path(feedback_file_path)

        if not path.exists():
            print(f"⚠️ Feedback file not found: {feedback_file_path}")
            return set()

        try:
            with open(path, "r", encoding="utf-8") as f:
                feature_feedback_files = json.load(f)

            for scenario in feature_feedback_files.get("scenarios"):
                # Only collect patterns from automatable scenarios
                if scenario.get("is_automatable", True):
                    for step in scenario.get("steps", []):
                        pattern = step.get("matched_pattern")
                        if pattern:
                            clean_p = PatternRegistry.clean_pattern(pattern)
                            if clean_p:
                                used_patterns.add(clean_p)

            return used_patterns

        except (json.JSONDecodeError, Exception) as e:
            print(f"❌ Error parsing {path.name}: {e}")
            return set()

    @classmethod
    def collect_all_used_patterns(cls, feedback_dir: str = "features") -> Set[str]:
        """Scans a directory recursively for all feedback JSON files and aggregates every unique used pattern as a Set."""
        all_patterns: Set[str] = set()
        dir_path = Path(feedback_dir)

        # Use rglob instead of glob to search nested directories
        feedback_files = list(dir_path.rglob("*_feasibility_feedback.json"))

        if not feedback_files:
            print(f"⚠️ No feedback JSON files found in directory: {feedback_dir}")
            return set()

        print(f"🔍 Found {len(feedback_files)} feedback file(s). Collecting unique step patterns...")

        for json_file in feedback_files:
            file_patterns = cls.get_used_patterns_from_feedback_file(str(json_file))
            all_patterns.update(file_patterns)

        print(f"📜 Successfully collected {len(all_patterns)} unique active patterns across all feedback files.")
        return all_patterns
