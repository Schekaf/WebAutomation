# Static Model Assignments
GENERAL = "qwen2.5:7b"
CODER = "qwen2.5-coder:7b"

AGENT_MODEL_MAP = {
    # Phase 0: Planning
    "RequirementsRouterAgent": GENERAL,
    "CoveragePlannerAgent": GENERAL,
    "XrayToGherkinAgent": CODER,
    "GherkinSyntaxAgent": CODER,

    # Phase 1: Test Generation
    "TestGeneratorAgent": CODER,

    # Phase 2: Step Generation
    "AutomationFeasibilityAgent": CODER,
    "StepSkeletonAgent": CODER,
    "StepGeneratorAgent": CODER,
    "StepReviewAgent": CODER,

    # Phase 3: Locator & Element Discovery
    "LocatorGeneratorAgent": CODER
}


def get_agent_model(agent_name: str) -> str:
    """Returns the model type assigned to a specific agent."""
    return AGENT_MODEL_MAP.get(agent_name, GENERAL)
