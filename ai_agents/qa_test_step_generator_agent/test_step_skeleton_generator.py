from typing import Set, List, Dict, Any

from langchain_core.prompts import PromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_ollama import ChatOllama

from ai_agents.core.config import get_agent_model
from ai_agents.core.utils import mine_patterns_with_drain

PROMPT = """Look at these raw BDD steps from a feature file alongside the templates extracted by Drain3.

    
Drain Templates:
{drain_patterns}

TASK:
Generate the most meaningful, reusable step pattern strings for Python Behave definitions.
- Abstract dynamic values into descriptive parameters like {{button_name}}, {{location}}, {{state}}.
- A step implementation can have max 3 parameters. If a step has more than 3 dynamic values, combine them into a 
single descriptive parameter.

- Optimum step patterns have mostly 2 parameters {{action}} --> could be text, option, ..
and {{element}} --> could be button, field, link, dropdown, checkbox, radio button, tab, menu item, icon, image, label, section, card, modal, popup, tooltip, etc.
EXAMPLE:
-> I select "{{option}}" as {{element}}
-> I click on {{element}} with text "{{text}}"

- If a step has to have 1 parameter only, prefer {{element}}
EXAMPLE:
-> I click on {{element}}
-> I press on {{key}} Key

- I a step has to have 3 parameters, at least one of the params has to be {{element}}, the other to can be {{text}}, {{option}}, {{state}}, {{location}}, {{value}}, etc. 
- Output ONLY the pattern strings, ONE PER LINE.
- Do NOT output code blocks, @step decorators, or explanations.
"""


class StepSkeletonGeneratorAgent:
    """
    Phase 3 Agent: Generates Python step signatures (skeletons with `pass`)
    from step patterns, leaving implementation logic completely empty.
    """

    def __init__(self, model_name: str | None = None):
        # 1. Resolve agent name and lookup default model from central config
        self.agent_name = self.__class__.__name__
        self.model_name = model_name or get_agent_model(self.agent_name)

        # 2. Memory pool to avoid generating duplicate patterns across features in a single run
        self.generated_patterns_memory: Set[str] = set()

        # 3. LLM Setup
        self.llm = ChatOllama(
            model=self.model_name,
            temperature=0.0,
            timeout=60.0
        )

        prompt = PromptTemplate.from_template(PROMPT)
        self.chain = prompt | self.llm | StrOutputParser()

    def generate_skeletons(self, drain_patterns: set, raw_steps: list[str]) -> list[str]:
        if not raw_steps:
            return []

        # 2. Filter out patterns already generated from earlier features
        unseen_patterns = [p for p in drain_patterns if p not in self.generated_patterns_memory]
        if not unseen_patterns:
            print("   ⏩ All step patterns in this feature are already covered.")
            return []

        # 3. Invoke LLM only for new patterns
        raw_output = self.chain.invoke({
            # "raw_steps": "\n".join(raw_steps),
            "drain_patterns": "\n".join(unseen_patterns)
        })

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
