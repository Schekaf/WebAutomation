import os
import re
import json
import gc
from pathlib import Path
from typing import List, Set, Dict, Optional
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_ollama import ChatOllama

from ai_agents.core.config import get_agent_model
from ai_agents.core.lessons_learned_manager import LessonsLearnedManager
from ai_agents.core.step_library import PatternRegistry
from ai_agents.core.utils import timer, rest_check

FEASIBILITY_PROMPT = """You are a QA Test Automation Architect reviewing BDD Scenarios for Web Automation suitability.

LESSONSLEARNED CONTEXT FOR YOU:
{lessons_learned}

Determine if the following BDD Scenario can be automated using standard Web Browser Automation (Selenium/Playwright in Python).
Match scenario steps against the provided Drain3 patterns.

Known Valid Automatable Step Patterns:
{drain_patterns}

Scenario Content:
{scenario_text}

TASK:
Analyze the scenario steps and return JSON ONLY matching this format:
{{
  "is_automatable": true,
  "reason": "Brief reason if non-automatable, otherwise empty string",
  "steps": [
    {{
      "step_text": "Exact full Gherkin step string (e.g. Given I open \\"https://example.com\\")",
      "matched_pattern": "Exact matching Drain pattern (or suggestion pattern like 'I see <*> is <*>')",
      "pattern_status": "matched" | "suggested" | "unmatched"
    }}
  ]
}}

RULES:
- Do NOT concatenate steps and patterns into a single string with arrows or delimiters (NEVER use '-->'). Keep 'step_text' and 'matched_pattern' completely isolated.
- Mark 'is_automatable': true for standard Web UI interactions (navigation, typing, clicking buttons, verifying web text/elements).
- Mark 'is_automatable': false if steps require manual human intervention (CAPTCHA solved by human, physical hardware check, mobile SMS 2FA code without API, third-party phone verification).
- If EVEN ONE step in the scenario is marked as "(NOT AUTOMATABLE)" (e.g. manual backend checks, physical interactions, employer actions outside the app), you MUST set "is_automatable": false for the ENTIRE scenario.
- If proposing a new pattern for an unmatched step (not existing pattern in "Known Valid Automatable Step Patterns"), set "pattern_status": "suggested" and put the proposed wildcard format in "matched_pattern".
"""

RE_MATCH_PROMPT = """You are a QA Test Automation Architect.

A step pattern match was flagged as invalid by an auditor. Find a better matching pattern from the known valid Drain patterns for this single step.

Step Text: "{step_text}"
Flawed Previous Pattern: "{old_pattern}"

Known Valid Drain Patterns:
{drain_patterns}

RULES:
1. Select the exact matching pattern from "Known Valid Drain Patterns" if a valid fit exists.
2. If NO existing pattern fits, propose a clean Drain wildcard pattern (e.g., 'I click <*>' or 'I see <*> is Visible') and set "pattern_status" to "suggested".
3. Do NOT invent extra words, artificial quotes, or change the step's core verb structure.

RULES FOR WILDCARD PATTERN SYNTAX:
- Use `<*>` to replace any dynamic parameter, quoted string, button name, or input value.
- NEVER truncate or leave wildcards unclosed (e.g., WRONG: `<*` | CORRECT: `<*>`).
- NEVER put quotes around the wildcard itself. 
  * WRONG: 'I click on "<*>"'
  * WRONG: 'I enter "<*>" as "<*>"'
  * CORRECT: 'I click on <*>'
  * CORRECT: 'I enter <*> as <*>'
- A single `<*>` wildcard accounts for both quoted and unquoted parameter values (e.g. "Furkan", "Apply Button", or 123).

TASK:
Return JSON ONLY matching this format:
{{
  "matched_pattern": "Best matching pattern from list or new wildcard suggestion",
  "pattern_status": "matched" | "suggested"
}}
"""


class AutomationFeasibilityAgent:
    """
    Agent responsible for evaluating BDD feature files, determining if scenarios
    are suitable for web browser automation, and tagging automatable scenarios.
    """

    def __init__(self, model_name: str | None = None, lessons_manager: LessonsLearnedManager | None = None):
        self.agent_name = self.__class__.__name__
        self.model_name = model_name or get_agent_model(self.agent_name)
        self.lessons_manager = lessons_manager or LessonsLearnedManager()

        self.llm = ChatOllama(
            model=self.model_name,
            temperature=0.0,
            timeout=40.0,
            format="json"  # Guarantees structured JSON
        )
        prompt = PromptTemplate.from_template(FEASIBILITY_PROMPT)
        self.chain = prompt | self.llm | StrOutputParser()

        # Add the re-match chain
        rematch_prompt = PromptTemplate.from_template(RE_MATCH_PROMPT)
        self.rematch_chain = rematch_prompt | self.llm | StrOutputParser()

    @timer
    @rest_check
    def evaluate_scenario(self, scenario_text: str, automatable_patterns: Set[str]) -> Dict:
        """Invokes LLM to judge feasibility of a single scenario."""
        try:
            raw_res = self.chain.invoke({
                "lessons_learned": self.lessons_manager.load_lessons(self.agent_name),
                "scenario_text": scenario_text,
                "drain_patterns": "\n".join(automatable_patterns)
            })
            return json.loads(raw_res)
        except Exception as e:
            # Fallback to True if JSON parsing or connection error occurs
            return {
                "is_automatable": True,
                "reason": f"Bypassed on evaluation error: {e}",
                "steps": []
            }

    def rematch_step(self, step_text: str, old_pattern: str, automatable_patterns: Set[str]) -> Dict[str, str]:
        """
        Re-evaluates a single mismatched step against the known Drain pattern set.
        Exposed so auditing pipelines/agents can trigger step-level rematching.
        """
        try:
            raw_response = self.rematch_chain.invoke({
                "step_text": step_text,
                "old_pattern": old_pattern,
                "drain_patterns": "\n".join(sorted(automatable_patterns))
            })
            return json.loads(raw_response)
        except Exception as e:
            print(f"   ⚠️ Re-match fallback failed for step '{step_text}': {e}")
            return {
                "matched_pattern": old_pattern,
                "pattern_status": "mismatch_unresolved"
            }

    @staticmethod
    def _write_feedback_file(feature_path: str, evaluation_results: List[Dict]) -> Path:
        """
        Generates <feature_name>_feasibility_feedback.json in the same directory as the feature file.
        Returns the Path object of the generated file.
        """
        base_name = Path(feature_path).stem
        feedback_json_path = Path(feature_path).parent / f"{base_name}_feasibility_feedback.json"

        report_data = {
            "feature_file": Path(feature_path).name,
            "feature_path": str(feature_path),
            "total_scenarios": len(evaluation_results),
            "automatable_scenarios_count": sum(1 for item in evaluation_results if item.get("is_automatable", False)),
            "scenarios": evaluation_results
        }

        with open(feedback_json_path, "w", encoding="utf-8") as f:
            json.dump(report_data, f, indent=2, ensure_ascii=False)

        print(f"   📄 Generated feasibility feedback JSON: {feedback_json_path.name}")
        return feedback_json_path

    @timer
    def process_feature_file(self, feature_path: str, registry: PatternRegistry) -> Optional[Path]:
        """
        Parses a feature file, evaluates scenarios against active Drain patterns,
        and generates the feedback JSON report.

        Does NOT modify the feature file directly or perform step remediation.
        """
        base_name = Path(feature_path).stem
        feedback_json_path = Path(feature_path).parent / f"{base_name}_feasibility_feedback.json"
        if "archive" in Path(feature_path).parts or feedback_json_path.exists():
            print(f"⏩ [FeasibilityAgent] Skipping {base_name}: Feedback file already exists or path archived.")
            return None

        with open(feature_path, "r", encoding="utf-8") as f:
            content = f.read()

        raw_scenarios = content.split("Scenario:")
        evaluation_results = []

        # Evaluate each scenario
        for s_idx, raw_s in enumerate(raw_scenarios[1:], start=1):
            s_lines = raw_s.strip().splitlines()
            s_title = s_lines[0].strip() if s_lines else f"Scenario {s_idx}"
            full_s_text = "Scenario: " + raw_s

            res = self.evaluate_scenario(full_s_text, registry.active_patterns)

            evaluation_results.append({
                "title": s_title,
                "is_automatable": res.get("is_automatable", True),
                "reason": res.get("reason", ""),
                "steps": res.get("steps", [])
            })

        # Generate and return feedback JSON file path
        return self._write_feedback_file(feature_path, evaluation_results)