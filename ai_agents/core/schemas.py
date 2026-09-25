# Web Automation Framework Empowered by Local AI Agents
# Copyright (C) 2026  A. Furkan KIZILTEPE <furkan.kiziltepe@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

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