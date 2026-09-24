import json
from pathlib import Path
from typing import Dict, Set
from langchain_core.prompts import PromptTemplate
from ai_agents.core.lessons_learned_manager import LessonsLearnedManager
from langchain_core.output_parsers import JsonOutputParser
from langchain_ollama import ChatOllama

from ai_agents.core.config import get_agent_model

PROMPT = """You are a test automation step pattern formatter.

LESSONSLEARNED CONTEXT FOR YOU:
{lessons_learned}

Task:
Take the list of raw Gherkin step patterns and convert all `<*>` placeholders into named, typed parameters.
Ignore Gherkin keywords (Given, When, Then, And, But) if present in the text.

Rules for replacing `<*>`:
1. Wrap parameters in double quotes `"{{param_name}}"` if they represent string inputs, URLs, or variable values (e.g., `"{{url}}"`, `"{{value}}"`).
2. Do NOT use quotes `{{param_name}}` if they represent UI elements or actions (e.g., `{{element}}`, `{{button}}`).
3. Infer meaningful parameter names like `{{element}}`, `"{{url}}"`, `"{{text}}"`, `"{{option}}"`, `{{device}}` based on the verb/context.
4. NEVER change the patterns to include Gherkin keywords or alter the action verbs. Only replace `<*>` with typed parameters.

Input Patterns:
{patterns}

Return a JSON object mapping the original pattern to its resolved version:
{{
  "I open <*> on a <*>": "I open \\"{{url}}\\" on a {{device}}",
  "I click <*>": "I click {{element}}"
}}
"""


class PatternResolutionAgent:
    """Agent that resolves generic step patterns into typed parameter schemas."""

    def __init__(self, model_name: str | None = None):
        self.agent_name = self.__class__.__name__
        self.model_name = model_name or get_agent_model(self.agent_name)
        self.llm = ChatOllama(
            model=self.model_name,
            temperature=0.0,
            repeat_penalty=1.2
        )
        self.lessons_manager = LessonsLearnedManager()
        self.interactive_mode = None

        prompt = PromptTemplate.from_template(PROMPT)
        self.chain = prompt | self.llm.bind(format="json") | JsonOutputParser()

    def resolve_patterns(self, raw_patterns: Set[str]) -> Dict[str, str]:
        """Takes raw patterns from collect_all_used_patterns and returns a mapping to typed patterns."""
        if not raw_patterns:
            return {}

        return self.chain.invoke({"lessons_learned": self.lessons_manager.load_lessons(self.agent_name), "patterns": list(raw_patterns)})

    def process_feedback_file(self, feedback_path: str) -> bool:
        """Processes a single feedback JSON file, resolves any generic `<*>` step patterns,

        and updates the JSON file in-place with 'resolved_pattern'.
        """
        file_path = Path(feedback_path)
        if not file_path.exists():
            print(f"⚠️ Feedback file not found: {feedback_path}")
            return False

        with open(file_path, "r", encoding="utf-8") as f:
            feedback_data = json.load(f)

        # 1. Collect unique matched patterns within this feedback file
        file_patterns: Set[str] = set()
        for scenario in feedback_data.get("scenarios", []):
            for step in scenario.get("steps", []):
                pattern = step.get("matched_pattern") or step.get("pattern")
                if pattern and "<*>" in pattern:
                    file_patterns.add(pattern)

        if not file_patterns:
            print(f"ℹ️ No unresolved `<*>` patterns found in {file_path.name}")
            return False

        # 2. Invoke LLM chain to map patterns to resolved parameter schemas
        schema_map = self.resolve_patterns(file_patterns)
        if not schema_map:
            return False
        if self.interactive_mode is None:
            choice = input(
                "\nDo you want to enable Human-In-The-Loop review for pattern resolutions? (y/n): ").strip().lower()
            self.interactive_mode = (choice == 'y')
            if self.interactive_mode:
                print("Interactive mode ENABLED. You will review each proposed resolution.")
            else:
                print("Interactive mode DISABLED. Auto-accepting all proposed resolutions for this run.")

        print(f"\n🔍 [PatternResolutionAgent] Proposed resolutions for {file_path.name}:")
        for raw, resolved in schema_map.items():
            if not self.interactive_mode:
                continue
            print(f"   • Raw:      {raw}")
            print(f"     Resolved: {resolved}")

            user_input = input("\nIs this pattern resolution correct? (y/n): ").strip().lower()

            if user_input != 'y':
                print("❌ Resolution rejected by user.")

                # Capture feedback for LessonsLearnedManager
                if self.lessons_manager:
                    user_correction = input("Provide the correct expected format or rule derived: ").strip()
                    self.lessons_manager.add_lesson(
                        agent_id=self.agent_name,
                        category="pattern_resolution_mismatch",
                        original_output=f"{raw} -> {resolved}",
                        corrected_output=user_correction,
                        root_cause="LLM parameter resolution rejected by user review",
                        rule_derived=user_correction or "Strictly adhere to explicit parameter typing rules."
                    )
                print("📝 Lesson added to LessonsLearnedManager.")

        # 3. Decorate each step with 'resolved_pattern'
        updated = False
        for scenario in feedback_data.get("scenarios", []):
            for step in scenario.get("steps", []):
                pattern = step.get("matched_pattern") or step.get("pattern")
                if pattern in schema_map:
                    step["resolved_pattern"] = schema_map[pattern]
                    updated = True

        # 4. Save updated feedback payload back to disk
        if updated:
            with open(file_path, "w", encoding="utf-8") as f:
                json.dump(feedback_data, f, indent=2)
            print(f"✅ Updated resolved patterns in {file_path.name}")

        return updated
