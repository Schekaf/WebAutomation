import os
import re
import json
import gc
from pathlib import Path
from typing import List, Set, Dict
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_ollama import ChatOllama

from ai_agents.core.config import get_agent_model
from ai_agents.core.lessons_learned_manager import LessonsLearnedManager
from ai_agents.qa_automation_feasibility_agent.pattern_audit_agent import PatternAuditAgent

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

    def evaluate_scenario(self, scenario_text: str, automatable_patterns: Set[str]) -> Dict:
        """Invokes LLM to judge feasibility of a single scenario."""
        try:
            raw_res = self.chain.invoke({
                "lessons_learned": self.lessons_manager.load_lessons(),
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

    @staticmethod
    def _write_feedback_file(feature_path: str, evaluation_results: List[Dict]):
        """
        Generates <feature_name>_feasibility_feedback.json in the same directory as the feature file.
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

        print(f"   📄 Generated feedback JSON: {feedback_json_path.name}")

    def tag_automatable_scenarios(self, feature_path: str, automatable_patterns: Set[str]):
        """
        Parses feature file scenarios, checks feasibility against Drain patterns,
        tags approved scenarios with @automatable, and outputs a feedback JSON file.
        """
        if "archive" in Path(feature_path).parts:
            return

        with open(feature_path, "r", encoding="utf-8") as f:
            content = f.read()

        raw_scenarios = content.split("Scenario:")
        approved_titles = set()
        evaluation_results = []
        pattern_auditor = PatternAuditAgent()

        # Evaluate each scenario in the feature file
        for s_idx, raw_s in enumerate(raw_scenarios[1:], start=1):
            s_lines = raw_s.strip().splitlines()
            s_title = s_lines[0].strip() if s_lines else f"Scenario {s_idx}"
            full_s_text = "Scenario: " + raw_s

            res = self.evaluate_scenario(full_s_text, automatable_patterns)
            is_auto = res.get("is_automatable", True)
            steps = res.get("steps", [])

            if is_auto and steps:
                approved_titles.add(s_title)

                # 1. Run lightweight binary audit on current scenario steps
                audit_results = pattern_auditor.audit_scenario_steps(steps)
                audit_map = {item["step_text"]: item for item in audit_results if "step_text" in item}

                # 2. Iterate through steps and trigger rematch if a mismatch was flagged
                for step_entry in steps:
                    s_text = step_entry.get("step_text")

                    if s_text in audit_map and audit_map[s_text].get("status") == "mismatch":
                        old_pattern = step_entry.get("matched_pattern", "")
                        root_cause = audit_map[s_text].get("root_cause",
                                                           "Pattern mismatch detected by PatternAuditAgent.")

                        # Call AutomationFeasibilityAgent's internal rematch_step method
                        rematch_res = self.rematch_step(s_text, old_pattern, automatable_patterns)

                        new_pattern = rematch_res.get("matched_pattern", old_pattern)
                        p_status = rematch_res.get("pattern_status", "corrected")

                        # Check if the generated pattern is new or pre-existing
                        if new_pattern in automatable_patterns:
                            p_status = "matched"
                        else:
                            p_status = "suggested"
                            # Dynamically expand the active pattern set for the current execution session
                            automatable_patterns.add(new_pattern)
                            print(
                                f"   🌱 Discovered new suggested pattern: '{new_pattern}' (Added to dynamic pattern set)")

                        # Update in-memory step entry
                        step_entry["matched_pattern"] = new_pattern
                        step_entry["pattern_status"] = p_status

                        # Log feedback to LessonsLearned.json for continuous improvement
                        self.lessons_manager.add_lesson(
                            agent_id="AutomationFeasibilityAgent",
                            category="drain_mapping_drift",
                            original_output=f"Step: {s_text} | Pattern: {old_pattern}",
                            corrected_output=f"New Pattern: {new_pattern}",
                            root_cause=root_cause,
                            rule_derived="Ensure matched patterns strictly preserve step sentence structure without adding extra terms."
                        )
                    # CASE B: Programmatic Verification of Pattern Status (Runs for ALL steps)
                    # Guarantees status is 'suggested' if pattern is missing from automatable_patterns set
                    current_pattern = step_entry.get("matched_pattern")

                    if current_pattern:
                        if current_pattern in automatable_patterns:
                            step_entry["pattern_status"] = "matched"
                        else:
                            step_entry["pattern_status"] = "suggested"
                            # Add to dynamic session set so future steps in this run recognize it
                            automatable_patterns.add(current_pattern)
                            print(
                                f"   🌱 Discovered new suggested pattern: '{current_pattern}' (Added to dynamic set)")

            evaluation_results.append({
                "title": s_title,
                "is_automatable": is_auto,
                "reason": res.get("reason", ""),
                "steps": res.get("steps", [])
            })

        # 1. Output the clean feedback .json file
        self._write_feedback_file(feature_path, evaluation_results)

        # 2. Apply @automatable tag above approved scenarios in feature file
        if approved_titles:
            with open(feature_path, "r", encoding="utf-8") as f:
                lines = f.readlines()

            updated_lines = []
            for idx, line in enumerate(lines):
                stripped = line.strip()
                if stripped.startswith("Scenario:") or stripped.startswith("Scenario Outline:"):
                    title = stripped.split(":", 1)[1].strip()
                    if title in approved_titles:
                        prev_line = lines[idx - 1].strip() if idx > 0 else ""
                        if "@automatable" not in prev_line:
                            indent = line[:len(line) - len(line.lstrip())]
                            updated_lines.append(f"{indent}@automatable\n")

                updated_lines.append(line)

            with open(feature_path, "w", encoding="utf-8") as f:
                f.writelines(updated_lines)

    def rematch_step(self, step_text: str, old_pattern: str, automatable_patterns: Set[str]) -> Dict[str, str]:
        """
        Re-evaluates a single mismatched step against the known Drain pattern set.
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