import json
from pathlib import Path
from typing import List, Dict, Any
from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_ollama import ChatOllama

from ai_agents.core.config import get_agent_model
from ai_agents.core.lessons_learned_manager import LessonsLearnedManager

PATTERN_AUDIT_PROMPT = """You are a QA Pattern Audit Agent.

Your ONLY task is to judge whether "assigned_pattern" semantically and structurally matches "step_text".

RULES FOR VALIDATION:

1. "status": "mismatch" MUST BE RETURNED IF ANY OF THESE ARE TRUE:
   - VERB/ACTION MISMATCH: The step verb does not match the pattern action.
     * Step: "And I accept the Terms and Conditions" vs Pattern: "I click on <*>" --> MISMATCH (accept != click on)
     * Step: "And I enter Furkan" vs Pattern: "I select <*>" --> MISMATCH (enter != select)
   - CONTRADICTORY MEANING: Step says "accept" but pattern says "do not accept".
   - ARTIFICIAL SENTENCES: Pattern adds specific strings not in the step (e.g. adding "You have tender postings").

2. "status": "valid" SHOULD BE RETURNED IF:
   - The verb/action matches AND the structural slots align correctly.
   - DO NOT flag as mismatch if the only difference is quote formatting around wildcards (e.g., 'I enter <*> as <*>' IS VALID for 'I enter "Furkan" as Name').

INPUT DATA:
{scenario_payload}

Output JSON ONLY matching this format:
{{
  "has_mismatches": true | false,
  "audit_results": [
    {{
      "step_text": "Exact step_text from input",
      "assigned_pattern": "Exact assigned_pattern from input",
      "status": "valid" | "mismatch",
      "root_cause": "Detailed reason if mismatch (leave empty string if valid)"
    }}
  ]
}}
"""


class PatternAuditAgent:
    """
    Lightweight auditor that checks step-to-pattern alignment.
    Returns binary match/mismatch flags without searching or suggesting new patterns.
    """

    def __init__(self, model_name: str | None = None):
        self.agent_name = self.__class__.__name__
        self.model_name = model_name or get_agent_model(self.agent_name)

        self.llm = ChatOllama(
            model=self.model_name,
            temperature=0.0,
            timeout=30.0,
            keep_alive="0s",  # Instantly release memory
            format="json"
        )
        prompt = PromptTemplate.from_template(PATTERN_AUDIT_PROMPT)
        self.chain = prompt | self.llm | StrOutputParser()
        self.lessons_manager = LessonsLearnedManager()

    def audit_scenario_steps(self, steps: List[Dict[str, Any]]) -> List[Dict[str, Any]]:
        """
        Audits steps and returns a list of audit results with 'status': 'valid' | 'mismatch'.
        """
        if not steps:
            return []

        try:
            raw_response = self.chain.invoke({
                "scenario_payload": json.dumps(steps, indent=2, ensure_ascii=False)
            })
            audit_out = json.loads(raw_response)
            return audit_out.get("audit_results", [])
        except Exception as e:
            print(f"   ⚠️ Scenario audit error: {e}")
            return []