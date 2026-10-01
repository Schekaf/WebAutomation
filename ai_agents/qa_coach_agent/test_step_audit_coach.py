import json
from pathlib import Path
from typing import List, Optional
from langchain_core.prompts import PromptTemplate
from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.schemas import AuditCoachResponse, AuditCoachTargetScope

AUDIT_COACH_PROMPT = """You are the Supervisory Audit Coach Agent controlling Phase 2 execution.

FEATURE FILE: {feature_file_name}
FEEDBACK FILE: {feedback_file_name}

FEEDBACK FILE PAYLOAD:
{feedback_payload}

LESSONS LEARNED:
{lessons_learned}

YOUR TASK:
Inspect the feedback file payload to determine whether `PatternAuditAgent` needs to remediate step pattern resolutions.

EVALUATION RULES:
1. "EXECUTE_AUDIT":
   - If any step with `pattern_status: "matched"` is missing a `resolved_pattern` field.
   - If any step has `pattern_status: "undefined"`.
   - If a `resolved_pattern` violates any syntax rules outlined in `lessons_learned` (e.g., invalid placeholder syntax or deprecated signatures).

2. "SKIP_AUDIT":
   - ONLY IF every scenario and step in the feedback file has a valid, non-deprecated `resolved_pattern` populated that complies with `lessons_learned`.

OUTPUT DIRECTIVES:
- `feature_file_name`: Exact string from input
- `feedback_file_name`: Exact string from input
- `action`: "EXECUTE_AUDIT" or "SKIP_AUDIT"
- `unresolved_step_count`: Total number of steps lacking a valid resolved pattern
- `reason`: Concise explanation of the audit verdict
"""


class AuditCoachAgent(BaseAgent):
    """
    Supervisory agent that evaluates whether a feature's feedback file requires
    remediation by PatternAuditAgent based on the presence and validity of `resolved_pattern`.
    """

    def __init__(self, lessons_manager=None, **kwargs):
        super().__init__(
            temperature=0.0,
            **kwargs
        )
        self.lessons_manager = lessons_manager
        prompt = PromptTemplate.from_template(AUDIT_COACH_PROMPT)
        self.chain = prompt | self.llm.with_structured_output(AuditCoachTargetScope)

    def evaluate_single_feature(
            self, feature_file: Path, feedback_path: Path
    ) -> AuditCoachTargetScope:
        """
        Evaluates a single feature/feedback file pair using deterministic checks,
        falling back to LLM evaluation for complex lessons_learned validation.
        """
        if not feedback_path.exists() or feedback_path.stat().st_size == 0:
            return AuditCoachTargetScope(
                feature_file_name=feature_file.name,
                feedback_file_name=feedback_path.name,
                action="EXECUTE_AUDIT",
                unresolved_step_count=-1,
                reason="Feedback JSON file is missing or empty on disk."
            )

        try:
            feedback_data = json.loads(feedback_path.read_text(encoding="utf-8"))
        except Exception as e:
            return AuditCoachTargetScope(
                feature_file_name=feature_file.name,
                feedback_file_name=feedback_path.name,
                action="EXECUTE_AUDIT",
                unresolved_step_count=-1,
                reason=f"Feedback JSON is corrupted: {str(e)}"
            )

        # 1. Fast Deterministic Inspection: Count steps lacking 'resolved_pattern'
        scenarios = feedback_data.get("scenarios", [])
        unresolved_steps = []
        total_steps = 0

        for scenario in scenarios:
            for step in scenario.get("steps", []):
                total_steps += 1
                pattern_status = step.get("pattern_status")
                resolved_pattern = step.get("resolved_pattern")

                if pattern_status == "matched" and not resolved_pattern:
                    unresolved_steps.append(step.get("step_text"))
                elif pattern_status == "undefined":
                    unresolved_steps.append(step.get("step_text"))

        # Deterministic trigger: If steps are blatantly missing resolved_pattern
        if unresolved_steps:
            return AuditCoachTargetScope(
                feature_file_name=feature_file.name,
                feedback_file_name=feedback_path.name,
                action="EXECUTE_AUDIT",
                unresolved_step_count=len(unresolved_steps),
                reason=f"Found {len(unresolved_steps)}/{total_steps} steps lacking a valid 'resolved_pattern'."
            )

        # 2. If all steps have resolved_pattern, invoke LLM to check against lessons_learned rules
        lessons_learned_str = "None"
        if self.lessons_manager and hasattr(self.lessons_manager, "get_lessons_formatted"):
            lessons_learned_str = self.lessons_manager.get_lessons_formatted() or "None"

        try:
            directive: AuditCoachTargetScope = self.invoke(
                self.chain,
                {
                    "feature_file_name": feature_file.name,
                    "feedback_file_name": feedback_path.name,
                    "feedback_payload": json.dumps(feedback_data, indent=2, ensure_ascii=False),
                    "lessons_learned": lessons_learned_str
                }
            )
        except Exception as e:
            directive = AuditCoachTargetScope(
                feature_file_name=feature_file.name,
                feedback_file_name=feedback_path.name,
                action="SKIP_AUDIT",
                unresolved_step_count=0,
                reason=f"All steps contain resolved_pattern (LLM check bypassed due to error: {str(e)})"
            )

        # Deterministic Overwrite to prevent LLM string placeholders
        directive.feature_file_name = feature_file.name
        directive.feedback_file_name = feedback_path.name

        return directive

    def evaluate_audit_execution(self) -> AuditCoachResponse:
        """
        Evaluates all feature files in the batch and yields a unified AuditCoachResponse.
        """
        directives: List[AuditCoachTargetScope] = []
        features_dir = Path("features")
        feature_files = [f for f in features_dir.glob("*.feature") if f.is_file()]
        for feature_file in feature_files:
            feedback_path = features_dir / f"{feature_file.stem}_feasibility_feedback.json"
            directive = self.evaluate_single_feature(feature_file, feedback_path)
            directives.append(directive)

        should_run = any(item.action == "EXECUTE_AUDIT" for item in directives)

        return AuditCoachResponse(
            target_scope=directives,
            should_run_audit=should_run
        )
