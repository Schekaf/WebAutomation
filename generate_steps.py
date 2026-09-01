import os
import sys

from ai_agents.core.model_selector import select_model_interactively
from ai_agents.qa_test_step_generator_agent.test_step_generator import TestStepGeneratorAgent


def main():
    print("=" * 65)
    print("🚀 Starting Batch QA Test Step Generator Agent")
    print("=" * 65)

    # Interactive Model Selection from ai_agents/core
    selected_model = select_model_interactively()

    # Define paths relative to project root
    project_root = os.path.dirname(os.path.abspath(__file__))
    features_directory = os.path.join(project_root, "features")
    steps_directory = os.path.join(features_directory, "steps")

    # Delete existing generated_by_ai_steps.py if it exists
    os.remove(steps_directory + "\\generated_by_ai_steps.py") if os.path.exists(os.path.join(steps_directory + "\\generated_by_ai_steps.py")) else None
    output_ai_steps_file = os.path.join(steps_directory, "generated_by_ai_steps.py")

    print(f"📂 Features Directory : {features_directory}")
    print(f"📂 Existing Steps Dir : {steps_directory}")
    print(f"📝 AI Output File     : {output_ai_steps_file}\n")

    # Initialize agent with chosen model
    agent = TestStepGeneratorAgent(model_name=selected_model)

    try:
        agent.generate_missing_steps(
            features_dir=features_directory,
            steps_dir=steps_directory,
            output_file_path=output_ai_steps_file
        )
        print("\n✨ Step generation pipeline completed successfully!")

    except FileNotFoundError as e:
        print(f"\n❌ Path Error: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"\n❌ Execution Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()