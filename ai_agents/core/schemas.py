from pydantic import BaseModel, Field
from typing import List


class BDDStep(BaseModel):
    keyword: str = Field(description="Given, And, When, or Then")
    statement: str = Field(
        description="Step statement using syntax like 'I open \"...\"', 'I enter \"...\" into Field field', 'I see \"...\" as Field field value'")


class ScenarioItem(BaseModel):
    tag: str = Field(description="CamelCase tag without spaces, e.g., @Register, @LoginSuccess, @ABNPrompt")
    name: str = Field(description="Clear title of the scenario")
    steps: List[BDDStep]


class FeatureSuite(BaseModel):
    feature_title: str = "Web Automation with Behave"
    scenarios: List[ScenarioItem]
