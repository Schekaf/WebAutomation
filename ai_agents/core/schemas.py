from enum import Enum
from typing import List, Dict, Any
from pydantic import BaseModel, Field


# ==========================================
# 1. COVERAGE PLANNER AGENT SCHEMAS
# ==========================================

class ScenarioType(str, Enum):
    HAPPY_PATH = "HAPPY_PATH"
    NEGATIVE = "NEGATIVE"
    BOUNDARY_EDGE_CASE = "BOUNDARY_EDGE_CASE"
    SECURITY_AUTH = "SECURITY_AUTH"


class TestScenarioPlan(BaseModel):
    scenario_id: str = Field(description="Unique scenario identifier, e.g., SCENARIO_01")
    title: str = Field(description="Clear title of the test scenario")
    type: ScenarioType = Field(description="Category of the test scenario")
    objective: str = Field(description="Brief explanation of what business rule or acceptance criteria is being verified")
    tag: str = Field(description="CamelCase tag without spaces, e.g., @LoginSuccess, @InsufficientBalance")


class CoveragePlan(BaseModel):
    requirement_section: str = Field(description="Title or section name of the analyzed business requirement")
    total_scenarios_planned: int = Field(description="Total count of scenarios generated")
    scenarios: List[TestScenarioPlan] = Field(description="List of planned test scenarios")


# ==========================================
# 2. FEATURE & CODE GENERATOR SCHEMAS
# ==========================================

class BDDStep(BaseModel):
    keyword: str = Field(description="Given, And, When, or Then")
    statement: str = Field(
        description="Step statement using syntax like 'I open \"...\"', 'I enter \"...\" into Field field', 'I see \"...\" as Field field value'"
    )


class ScenarioItem(BaseModel):
    tag: str = Field(description="CamelCase tag without spaces, e.g., @Register, @LoginSuccess, @ABNPrompt")
    name: str = Field(description="Clear title of the scenario")
    steps: List[BDDStep]


class FeatureSuite(BaseModel):
    feature_title: str = Field(default="Web Automation with Behave", description="Title of the feature suite")
    scenarios: List[ScenarioItem]