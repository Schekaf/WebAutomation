from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import PromptTemplate
from langchain_ollama import ChatOllama

from ai_agents.core.step_scanner import get_undefined_steps_via_behave
from ai_agents.core.utils import *

from drain3 import TemplateMiner
from drain3.template_miner_config import TemplateMinerConfig


PROMPT = """You are an Expert Test Automation Engineer. Your task is to generate Python step definitions for the 
Behave BDD framework based on the provided step patterns.
- Feel free to add parameterization to the step definitions where appropriate.
- You don't have to stick with exact patterns.
- Keep in mind that the step definitions are for a Web UI automation framework. Step patterns may include generally 
element - action relation. A step definition without an element or action is not useful.

Generate a Python @step definition for all of the step patterns below:

Patterns: {pattern}

Rules:
- Output ONLY valid Python code (@step decorator + def step_impl + pass).
- Do NOT output markdown code fences (```) or explanations.

Python Code:
"""


def clear_ai_generated_steps_file(output_file_path: str):
    """Safely clears/truncates the generated step file without deleting it."""
    os.makedirs(os.path.dirname(output_file_path), exist_ok=True)
    with open(output_file_path, "w", encoding="utf-8") as f:
        f.truncate(0)


class TestStepGeneratorAgent:

    def __init__(self, model_name: str = "qwen2.5-coder:7b"):
        self.model_name = model_name
        self.model_slug = sanitize_model_tag_for_filename(model_name)

        # LLM instance
        self.llm = ChatOllama(model=self.model_name, temperature=0.0, repeat_penalty=1.2)

        # LangChain chain
        prompt = PromptTemplate.from_template(PROMPT)
        self.chain = prompt | self.llm | StrOutputParser()

    def generate_missing_steps(self, features_dir: str, steps_dir: str, output_file_path: str):
        print(f"\n📖 Discovering .feature files matching '*_{self.model_slug}.feature'...")
        feature_files = discover_all_feature_files(features_dir, model_slug=self.model_slug)

        if not feature_files:
            print(f"⚠️ No .feature files found matching suffix '*_{self.model_slug}.feature'")
            return

        print("\n🧹 Pre-clean: Truncating generated step file...")
        clear_ai_generated_steps_file(output_file_path)

        print("\n🔍 Phase 2: Running 'behave --dry-run' to collect undefined steps...")
        uncovered_steps = get_undefined_steps_via_behave(feature_files)

        config = TemplateMinerConfig()
        config.profiling_enabled = False
        template_miner = TemplateMiner(config=config)
        raw_drain_output = []

        for step in uncovered_steps:
            template_miner.add_log_message(step)

        for step in template_miner.drain.clusters:
            raw_drain_output.append(step.get_template())

        # 1. Python collapses over-segmented wildcards instantly
        clean_patterns = collapse_drain_patterns(raw_drain_output)

        # 2. Aggregator drops ambiguous sub-patterns
        master_patterns = aggregate_by_verb_prefix(clean_patterns)

        print(
            f"🚀 Drain3 output reduced from {len(uncovered_steps)} lines ->"
            f" {len(master_patterns)} master patterns!"
        )
        print(f"   Collected {len(master_patterns)} missing step snippet(s).")

        if not uncovered_steps:
            print("\n✅ All steps are already covered by your codebase!")
            return

        print(f"\n🤖 Phase 3: Generating minimal parameterized step definitions with {self.model_name}...\n")

        generated_code = self.chain.invoke({"pattern": master_patterns})

        cleaned_code = clean_gherkin_output(generated_code)

        os.makedirs(os.path.dirname(output_file_path), exist_ok=True)
        with open(output_file_path, "w", encoding="utf-8") as out_f:
            out_f.write(f"# Auto-generated step definitions by TestStepGeneratorAgent ({self.model_name})\n")
            out_f.write("from behave import step\n\n")
            out_f.write(cleaned_code + "\n")

        print(f"\n🎉 Clean step definitions successfully generated:\n👉 {os.path.abspath(output_file_path)}")
