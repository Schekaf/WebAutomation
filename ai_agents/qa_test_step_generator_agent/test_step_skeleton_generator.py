from typing import Dict, Any, Set
from ai_agents.core.base_agent import BaseAgent

STEP_SKELETON_GENERATION_PROMPT = """You are an Expert BDD Architect specializing in Python Behave and Step Skeleton Design.

Look at these raw BDD steps alongside the templates extracted by Drain3.

Drain Templates:
{drain_patterns}

LESSONS LEARNED (STRICT RULES TO AVOID PAST FAILURE MODES):
{lessons_learned}

TASK:
Generate the most meaningful, reusable step pattern strings and skeleton signatures for Python Behave definitions.

CRITICAL PATTERN ORDERING RULE (PREVENT STEP INTERCEPTION):
- SORT ALL STEPS BY PATTERN LENGTH IN DESCENDING ORDER (LONGEST / MOST SPECIFIC PATTERNS FIRST).
- Specific multi-parameter patterns (e.g., `@step('I see {{element}} is "{{state}}"')`) MUST appear BEFORE shorter/generic patterns (e.g., `@step('I see "{{element}}"')`). Otherwise, Behave's regex engine will intercept all execution using the shorter rule.

RULES FOR PATTERNS & PARAMETERS:
- Abstract dynamic values into descriptive parameters like {{element}}, {{text}}, {{option}}, {{state}}, {{location}}, {{value}}.
- MAXIMUM 3 parameters per step pattern.
- If 1 parameter: Prefer {{element}} (e.g., `I click on {{element}}`).
- If 2 parameters: Prefer {{action_value}} and {{element}} (e.g., `I select "{{option}}" as {{element}}`).
- If 3 parameters: At least one parameter MUST be {{element}}.

STRICT CODE OUTPUT FORMAT RULES:
1. NO DUPLICATE FUNCTION NAMES. Every function name MUST be unique and derived from the step text in snake_case (e.g., `def step_input_value_into_element(context, value, element):`). NEVER output `def step_impl`.
2. SINGLE DECORATOR PER FUNCTION. Do NOT stack multiple `@given` / `@when` / `@then` decorators on top of a single `step_impl` function.
3. QUOTE ESCAPING: Use single quotes `'` for decorators. If a parameter string inside contains single quotes, double-quote the decorator string or escape it properly (e.g., `@given('I enter "{{value}}" as {{element}}')`).
4. Output ONLY the clean Python skeleton code without markdown blocks or explanations.

Output ONE step definition skeleton per pattern.
"""


class StepSkeletonGeneratorAgent(BaseAgent):
    """
    Phase 3 Agent: Generates Python step signatures (skeletons with `pass`)
    from step patterns, leaving implementation logic completely empty.
    """

    def __init__(self, **kwargs):
        # 1. Delegate LLM, model, and lessons_manager setup to BaseAgent
        super().__init__(temperature=0.0, timeout=60.0, **kwargs)

        # 2. Cross-feature memory pool
        self.generated_patterns_memory: Set[str] = set()

        # 3. Create chain via BaseAgent helper
        self.chain = self.create_chain(STEP_SKELETON_GENERATION_PROMPT)

    def generate_skeletons(self, drain_patterns: set, raw_steps: list[str]) -> list[str]:
        if not raw_steps:
            return []

        # 2. Filter out patterns already generated from earlier features
        unseen_patterns = [p for p in drain_patterns if p not in self.generated_patterns_memory]
        if not unseen_patterns:
            print("   ⏩ All step patterns in this feature are already covered.")
            return []

        # 3. Invoke LLM only for new patterns
        raw_output = self.invoke(
            self.chain,
            {"drain_patterns": "\n".join(unseen_patterns)}
        )

        # 4. Save to cross-feature memory
        self.generated_patterns_memory.update(unseen_patterns)

        # 5. Clean each line and return a flat list of step pattern strings
        step_patterns = []
        for line in raw_output.strip().splitlines():
            clean_line = line.strip().strip("`'\"")
            if clean_line and not clean_line.startswith("```"):
                step_patterns.append(clean_line)
        # Return as a multiline string block
        return step_patterns
