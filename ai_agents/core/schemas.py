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
from typing import List, Dict, Any, Literal
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
    objective: str = Field(
        description="Brief explanation of what business rule or acceptance criteria is being verified")
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


# ==========================================
# 3. PATTERN AUDIT AGENT SCHEMAS
# ==========================================

class StepAuditItem(BaseModel):
    step_text: str = Field(description="Exact step_text from the audited scenario input")
    assigned_pattern: str = Field(description="Exact assigned_pattern from input evaluated against step_text")
    status: Literal["valid", "mismatch"] = Field(
        description="'mismatch' if verbs, meaning, or structure disagree; otherwise 'valid'")
    root_cause: str = Field(default="", description="Detailed explanation if status is mismatch; empty string if valid")


class PatternAuditResponse(BaseModel):
    has_mismatches: bool = Field(description="True if any step item in audit_results has status 'mismatch'")
    audit_results: List[StepAuditItem] = Field(default_factory=list,
                                               description="List of step-to-pattern audit evaluations")


# ==========================================
# 4. COACH AGENT SCHEMAS
# ==========================================

class FeatureTargetScope(BaseModel):
    section_index: int = Field(description="The 1-based index of the requirement section, e.g., 1")
    section_title: str = Field(description="Title of the requirement section, e.g., '1. Create a New Account'")
    feature_file_name: str = Field(description="Target .feature file name, e.g., '01_create_a_new_account.feature'")
    action: Literal["GENERATE", "REGENERATE", "SKIP"] = Field(description="Action directive for the section")
    reason: str = Field(description="Justification based on requirement coverage or historical failure modes")
    lessons_for_agent: List[str] = Field(default_factory=list,
                                         description="Failure modes or rules to pass to TestGeneratorAgent")


class TestGenerationCoachResponse(BaseModel):
    should_run_generator: bool = Field(description="True if at least one feature needs generation or re-generation")
    target_scope: List[FeatureTargetScope] = Field(default_factory=list,
                                                   description="List of feature targets and their directives")


class FeasibilityTargetScope(BaseModel):
    feature_file_name: str = Field(description="Name of the .feature file")
    feedback_file_name: str = Field(description="Name of the feasibility feedback JSON file")
    action: Literal["EVALUATE", "RE_EVALUATE", "SKIP"] = Field(description="Directive action for FeasibilityAgent")
    reason: str = Field(description="Reason for decision taking lessons_learned and status into account")


class AutomationFeasibilityCoachResponse(BaseModel):
    should_run_feasibility: bool = Field(description="True if at least one feature needs EVALUATE or RE_EVALUATE")
    target_scope: List[FeasibilityTargetScope] = Field(description="MUST contain an entry for EVERY feature where feedback_exists is false or re-evaluation is needed")
    should_harvest_patterns: bool = Field(default=True)
