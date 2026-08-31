import sys

# Centralized benchmarked local models for all BDD AI Agents
AVAILABLE_MODELS = {
    "1": ("Qwen 2.5 Coder 7B (Recommended for BDD)", "qwen2.5-coder:7b"),
    "2": ("Qwen 2.5 General 7B", "qwen2.5:7b"),
    "3": ("Llama 3.2 3B (Fast / Small)", "llama3.2:3b"),
    "4": ("DeepSeek R1 8B", "deepseek-r1:8b"),
}

DEFAULT_MODEL_KEY = "1"


def select_model_interactively() -> str:
    """Displays an interactive CLI prompt to select an Ollama LLM model."""
    print("\nSelect LLM Model for Generation:")
    for key, (label, model_id) in AVAILABLE_MODELS.items():
        default_tag = " [DEFAULT]" if key == DEFAULT_MODEL_KEY else ""
        print(f" [{key}] {label} ({model_id}){default_tag}")

    try:
        choice = input(f"\nEnter choice (1-{len(AVAILABLE_MODELS)}) [Default: {DEFAULT_MODEL_KEY}]: ").strip()

        if not choice:
            choice = DEFAULT_MODEL_KEY

        if choice in AVAILABLE_MODELS:
            selected_name, model_id = AVAILABLE_MODELS[choice]
            print(f"👉 Selected: {selected_name}\n")
            return model_id
        else:
            print(f"⚠️ Invalid choice '{choice}'. Falling back to default: {AVAILABLE_MODELS[DEFAULT_MODEL_KEY][1]}\n")
            return AVAILABLE_MODELS[DEFAULT_MODEL_KEY][1]

    except (KeyboardInterrupt, EOFError):
        print("\n\nOperation cancelled by user.")
        sys.exit(0)


def print_missing_model_error(missing_tag: str):
    """Displays a clean error message and prompt instructions when a model is not pulled."""
    print("\n" + "❌ " + "=" * 58)
    print(f" ERROR: Model '{missing_tag}' is not found locally!")
    print("=" * 60)
    print(" Please pull the model(s) using your terminal before running:")
    print()
    for _, (_, tag) in AVAILABLE_MODELS.items():
        prefix = "👉 " if tag == missing_tag else "   "
        print(f"{prefix}ollama pull {tag}")
    print("=" * 60 + "\n")
