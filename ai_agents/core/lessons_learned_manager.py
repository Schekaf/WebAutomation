import json
import os
from pathlib import Path
from typing import Dict, Any, List


class LessonsLearnedManager:
    """
    Manages reading, writing, and updating the centralized lessons_learned.json store
    located under ai_agents/core/.
    """

    def __init__(self, file_path: str | Path | None = None):
        if file_path:
            self.file_path = Path(file_path)
        else:
            # Default location: ai_agents/core/lessons_learned.json
            core_dir = Path(__file__).resolve().parent
            self.file_path = core_dir / "lessons_learned.json"

        self._ensure_file_exists()

    def _ensure_file_exists(self) -> None:
        """Creates the JSON file with an empty list if it does not exist."""
        if not self.file_path.exists():
            self.file_path.parent.mkdir(parents=True, exist_ok=True)
            with open(self.file_path, "w", encoding="utf-8") as f:
                json.dump([], f, indent=2)

    def load_lessons(self) -> List[Dict[str, Any]]:
        """Reads all lessons from lessons_learned.json."""
        try:
            with open(self.file_path, "r", encoding="utf-8") as f:
                return json.load(f)
        except (json.JSONDecodeError, FileNotFoundError):
            return []

    def add_lesson(
        self,
        agent_id: str,
        category: str,
        original_output: str,
        corrected_output: str,
        root_cause: str,
        rule_derived: str,
    ) -> None:
        """
        Logs a fix applied by a Review/Fixer agent. If an identical fix/rule
        already exists, increments occurrence_count instead of creating a duplicate.
        """
        lessons = self.load_lessons()

        # Check for existing lesson based on original vs corrected output
        matched = False
        for entry in lessons:
            if (
                entry.get("agent_id") == agent_id
                and entry.get("original_output") == original_output
                and entry.get("corrected_output") == corrected_output
            ):
                entry["occurrence_count"] = entry.get("occurrence_count", 1) + 1
                matched = True
                break

        if not matched:
            new_entry = {
                "agent_id": agent_id,
                "category": category,
                "original_output": original_output,
                "corrected_output": corrected_output,
                "root_cause": root_cause,
                "rule_derived": rule_derived,
                "occurrence_count": 1,
            }
            lessons.append(new_entry)

        # Write updated array back to disk
        with open(self.file_path, "w", encoding="utf-8") as f:
            json.dump(lessons, f, indent=2, ensure_ascii=False)