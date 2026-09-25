from ai_agents.core.base_agent import BaseAgent
from ai_agents.core.utils import clean_gherkin_output

STEP_GENERATION_PROMPT = """You are an Expert Test Automation Engineer specializing in Python Behave and Web UI Automation.
Your task is to take Python Behave step definition skeletons and implement realistic execution logic using custom step helper decorators.

STEP SKELETONS:
{skeletons}

LESSONS LEARNED (PAST BUG FIXES TO REMEMBER):
{lessons_learned}

CRITICAL EXECUTION RULES:
- REQUIRED IMPORT: The VERY FIRST line of the file MUST be EXACTLY:
  from utilities.step_helper import step
- BANNED IMPORTS: DO NOT import `given`, `when`, `then`, or `step` from `behave`. DO NOT import `time`.
- STRICT DECORATOR RULE: Every step definition MUST use `@step('...')` exclusively. NEVER use `@given`, `@when`, or `@then`.
- KEEP UNIQUE FUNCTION NAMES: Retain the unique function name for each step (e.g., `step_i_click_on_element`). DO NOT collapse or rename functions to `def step_impl`.
- IMPLEMENT BODY: Replace `pass` with clean execution logic using `context.page` or `context.element_helper`. Use existing context—do NOT instantiate new `Browser()` or `Page()` instances.
- NO STACKING: Do NOT combine multiple step decorators into a single function.
- OUTPUT ONLY VALID PYTHON CODE: Output ONLY clean Python code without markdown code fences (```) or explanatory prose.

Python Implementation:
"""


class StepGeneratorAgent(BaseAgent):
    """
    Phase 3 Code Generator Agent: Accepts skeleton function definitions (`pass`)
    and implements standard UI automation logic.
    """

    def __init__(self, **kwargs):
        # 1. Delegate LLM, model, and lessons_manager setup to BaseAgent
        super().__init__(temperature=0.0, timeout=60.0, **kwargs)

        # 2. Create chain via BaseAgent helper
        self.chain = self.create_chain(STEP_GENERATION_PROMPT)

    def generate_missing_steps(self, combined_skeletons: str) -> str:
        """
        Takes aggregated Python step skeletons and fills in execution logic.
        """
        if not combined_skeletons or not combined_skeletons.strip():
            return ""

        # Invokes chain via BaseAgent helper (automatically injects "lessons_learned")
        raw_generated_code = self.invoke(
            self.chain,
            {"skeletons": combined_skeletons}
        )

        # Sanitize and return draft code
        return clean_gherkin_output(raw_generated_code)