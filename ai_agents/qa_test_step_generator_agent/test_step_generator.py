from langchain_core.output_parsers import StrOutputParser
from langchain_core.prompts import PromptTemplate
from langchain_ollama import ChatOllama
from typing import Set
from ai_agents.core.step_scanner import get_undefined_steps_via_behave
from ai_agents.core.utils import *

from drain3 import TemplateMiner
from drain3.template_miner_config import TemplateMinerConfig

from ai_agents.qa_test_step_generator_agent.test_step_reviewer import StepReviewAgent

PROMPT = """You are an Expert Test Automation Engineer. Your task is to generate Python step definitions for the 
Behave BDD framework based on the provided step patterns.
- Feel free to add parameterization to the step definitions where appropriate.
- You don't have to stick with exact patterns.
- Keep in mind that the step definitions are for a Web UI automation framework. Step patterns may include generally 
element - action relation. A step definition without an element or action is not useful.

EXISTING STEP DEFINITIONS (DO NOT RE-GENERATE THESE):
{existing_steps}

Generate a Python @step definition for all of the step patterns below:

Patterns: {pattern}

CRITICAL RULES:
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

        # Track generated patterns as a Set to prevent duplicates and enable fast lookup
        self.generated_patterns_memory: Set[str] = set()

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

        print("\n🔍 Phase 2: Running 'behave --dry-run' per feature to collect undefined steps...")

        # 1. Collect undefined steps per feature file
        feature_steps_map = []
        for feature_file in feature_files:
            steps = get_undefined_steps_via_behave([feature_file])
            if steps:
                feature_steps_map.append({"file": feature_file, "steps": steps})

        if not feature_steps_map:
            print("\n✅ All steps are already covered by your codebase!")
            return

        # 2. Execution Pipeline per Feature
        all_generated_code_blocks = []

        print(f"🤖 Phase 3: Generating parameterized step definitions with {self.model_name}...")

        for item in feature_steps_map:
            feature_file = item["file"]
            uncovered_steps_ind = item["steps"]

            print(f"\n📂 Processing feature: {os.path.basename(feature_file)}")
            print(f"   Found {len(uncovered_steps_ind)} undefined step(s).")

            # Re-initialize local Drain miner per feature to prevent cross-feature cluster leaking
            config = TemplateMinerConfig()
            config.profiling_enabled = False
            config.drain_depth = 5
            config.drain_sim_th = 0.85
            config.masking_instructions = []
            local_template_miner = TemplateMiner(config=config)

            # Pre-mask and feed steps to local Drain instance
            for step in uncovered_steps_ind:
                masked_step = pre_mask_step(step)
                local_template_miner.add_log_message(masked_step)

            raw_drain_output = [
                cluster.get_template() for cluster in local_template_miner.drain.clusters
            ]

            # Post-process templates into clean master patterns
            clean_patterns = collapse_drain_patterns(raw_drain_output)
            master_patterns = aggregate_by_verb_prefix(clean_patterns)

            # --- DEDUPLICATION FILTER ---
            # Filter out patterns that were already processed in earlier features
            unseen_patterns = [
                p for p in master_patterns if p not in self.generated_patterns_memory
            ]

            print(
                f"🚀 Drain3 reduced {len(uncovered_steps_ind)} lines -> "
                f"{len(master_patterns)} master pattern(s) "
                f"({len(unseen_patterns)} new, unseen pattern(s))."
            )

            if not unseen_patterns:
                print("   ⏩ All patterns for this feature were already generated in earlier runs!")
                continue

            # Prepare existing steps context formatted cleanly as a string
            existing_steps_context = "\n".join(sorted(self.generated_patterns_memory))

            # Invoke LLM for ONLY unseen patterns
            raw_generated_code = self.chain.invoke({
                "existing_steps": existing_steps_context,
                "pattern": "\n".join(unseen_patterns)
            })

            # Clean output immediately for this block
            cleaned_block = clean_gherkin_output(raw_generated_code)
            all_generated_code_blocks.append(cleaned_block)

            # Update memory pool with the newly generated patterns
            self.generated_patterns_memory.update(unseen_patterns)

        if not all_generated_code_blocks:
            print("\n✅ No new code required generation.")
            return

        # Final combined Python code across all feature files
        final_step_definitions_code = "\n\n".join(all_generated_code_blocks)

        # 🧹 REFINE STEP OUTPUT (Strips explanations, prose, duplicate params, and syntax glitches)
        print("\n🧹 Reviewing and sanitizing step definitions...")
        review_agent = StepReviewAgent(self.llm)
        cleaned_final_code = review_agent.review_and_fix(final_step_definitions_code)

        # Save refined code to file
        os.makedirs(os.path.dirname(output_file_path), exist_ok=True)
        with open(output_file_path, "w", encoding="utf-8") as out_f:
            out_f.write(f"# Auto-generated step definitions by TestStepGeneratorAgent ({self.model_name})\n")
            out_f.write("from behave import step\n\n")
            out_f.write(cleaned_final_code + "\n")

        print(f"\n🎉 Clean step definitions successfully generated:\n👉 {os.path.abspath(output_file_path)}")
