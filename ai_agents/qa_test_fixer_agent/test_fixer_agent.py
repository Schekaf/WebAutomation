import json
from pathlib import Path
from typing import Dict, Any, Optional

from langchain_core.output_parsers import StrOutputParser, JsonOutputParser
from langchain_core.prompts import PromptTemplate
from langchain_ollama import ChatOllama

from ai_agents.core.config import get_agent_model

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


class TestFixerAgent:

    def __init__(self, model_name: str | None = None):
        self.agent_name = self.__class__.__name__
        self.model_name = model_name or get_agent_model(self.agent_name)
        self.llm = ChatOllama(model=self.model_name, temperature=0.0, repeat_penalty=1.2)

        # Chain 1: Audit & JSON extraction
        analyzer_prompt = PromptTemplate.from_template(ANALYZER_PROMPT)
        self.analyzer_chain = analyzer_prompt | self.llm.bind(format="json") | JsonOutputParser()

        # Chain 2: Gherkin rewrite execution
        modifier_prompt = PromptTemplate.from_template(MODIFIER_PROMPT)
        self.modifier_chain = modifier_prompt | self.llm | StrOutputParser()

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

        # Pass 1: Analyze violations
        analysis_result: Dict[str, Any] = self.analyzer_chain.invoke({
            "feature_name": feature_file.name,
            "feedback_json": feedback_json,
            "raw_gherkin": raw_gherkin
        })

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

        # Pass 2: Apply fixes to feature file
        fixes_summary = json.dumps(fixes_applied, indent=2)

        updated_gherkin: str = self.modifier_chain.invoke({
            "raw_gherkin": raw_gherkin,
            "fixes_summary": fixes_summary
        })

        return {
            "harmonized_gherkin": updated_gherkin.strip(),
            "explanation_report": explanation_report,
            "fixes_applied": fixes_applied
        }
