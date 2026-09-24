import json
from pathlib import Path
from typing import Dict, Any

from langchain_core.output_parsers import JsonOutputParser

from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.utils import rest_check

MODIFIER_PROMPT = """You are an expert BDD QA Automation Engineer specializing in Gherkin step harmonization.

Your task is to review a BDD Feature File along with the approved list of fixes, and rewrite the file into clean, standardized Gherkin.

### CORE RULES:
1. PROCESS ONLY AUTOMATABLE SCENARIOS:
   - If a scenario was marked non-automatable, leave it unchanged or omit as per project guidelines.
2. VALUE QUOTING STANDARD:
   - Wrap literal values/inputs in double quotes: "VALUE".
   - NEVER quote field labels or keywords.
   - CORRECT: When I enter "HALLO" as Message
   - INCORRECT: When I enter "HALLO" as "Message"
3. EXACT FIX EXECUTION:
   - Apply all modifications specified in the FIXES TO APPLY list.

LESSONS LEARNED (STRICT RULES TO AVOID PAST FAILURE MODES):
{lessons_learned}

RAW FEATURE FILE:
{raw_gherkin}

FIXES TO APPLY:
{fixes_summary}

### TASK:
Return the full, corrected Feature file containing ONLY clean, harmonized Gherkin syntax for automatable scenarios. 
Output ONLY the valid feature file content without markdown code blocks or explanations.
"""

ANALYZER_PROMPT = """You are a strict BDD QA Inspector auditing Gherkin feature steps.

CRITICAL DIRECTIVE:
If a step is already syntactically valid, DO NOT include it in "fixes_applied".
NEVER return an entry where "original_step" matches "corrected_step".

STRICT SYNTAX RULES:
1. Check parameter quoting: Input values in double quotes, field labels/buttons without quotes.
2. If the step already follows this, IGNORE IT.
3. Return ONLY steps that genuinely need modifications. If 0 steps need changes, return "fixes_applied": [].

LESSONS LEARNED (STRICT RULES TO AVOID PAST FAILURE MODES):
{lessons_learned}

### INPUT DATA:
Feature Name: {feature_name}

Feasibility Report (JSON):
{feedback_json}

Raw Feature File Content:
{raw_gherkin}

### OUTPUT TASK:
Analyze step by step and output JSON ONLY matching this format:
{{
  "has_fixes": true | false,
  "explanation_report": "Brief explanation",
  "fixes_applied": [
    {{
      "category": "gherkin_syntax",
      "original_step": "EXACT step text requiring a fix",
      "corrected_step": "Modified step text (MUST NOT EQUAL original_step)",
      "root_cause": "Reason for fix",
      "rule_derived": "Rule description"
    }}
  ]
}}
"""


class TestFixerAgent(BaseAgent):
    """
    Phase 2 Agent: Analyzes Gherkin step syntax violations against feasibility reports
    and applies standardized harmonization fixes.
    """

    def __init__(self, **kwargs):
        # 1. Delegate LLM, model, and lessons_manager setup to BaseAgent
        super().__init__(temperature=0.0, timeout=60.0, **kwargs)

        # 2. Chain 1: Audit & JSON extraction (custom JSON parser)
        self.analyzer_chain = self.create_chain(
            ANALYZER_PROMPT,
            output_parser=JsonOutputParser()
        )

        # 3. Chain 2: Gherkin rewrite execution (default StrOutputParser)
        self.modifier_chain = self.create_chain(MODIFIER_PROMPT)

    @rest_check
    def fix_feature_file(self, feature_path: str, feedback_path: str) -> Dict[str, Any]:
        """
        Executes a 2-pass workflow:
        1. Analyzes needed fixes and returns audit report & lessons.
        2. Applies fixes to output the clean Gherkin feature file.
        """
        feature_file = Path(feature_path)
        feedback_file = Path(feedback_path)

        with open(feature_file, "r", encoding="utf-8") as f:
            raw_gherkin = f.read()

        with open(feedback_file, "r", encoding="utf-8") as f:
            feedback_json = f.read()

        # Pass 1: Analyze violations (BaseAgent automatically injects lessons_learned)
        analysis_result: Dict[str, Any] = self.invoke(
            self.analyzer_chain,
            {
                "feature_name": feature_file.name,
                "feedback_json": feedback_json,
                "raw_gherkin": raw_gherkin,
            }
        )

        has_fixes = analysis_result.get("has_fixes", False)
        fixes_applied = analysis_result.get("fixes_applied", [])
        explanation_report = analysis_result.get("explanation_report", "")

        # Shortcut if no fixes are needed
        if not has_fixes or not fixes_applied:
            return {
                "harmonized_gherkin": raw_gherkin,
                "explanation_report": "No syntax harmonization fixes were required.",
                "fixes_applied": []
            }

        # Pass 2: Apply fixes to feature file (BaseAgent automatically injects lessons_learned)
        fixes_summary = json.dumps(fixes_applied, indent=2)

        updated_gherkin: str = self.invoke(
            self.modifier_chain,
            {
                "raw_gherkin": raw_gherkin,
                "fixes_summary": fixes_summary,
            }
        )

        return {
            "harmonized_gherkin": updated_gherkin.strip(),
            "explanation_report": explanation_report,
            "fixes_applied": fixes_applied
        }
