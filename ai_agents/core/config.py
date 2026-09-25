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

# Static Model Assignments
GENERAL = "qwen2.5:7b"
CODER = "qwen2.5-coder:7b"

AGENT_MODEL_MAP = {
    # Phase 0: Planning
    "RequirementsRouterAgent": GENERAL,
    "CoveragePlannerAgent": GENERAL,
    "XrayToGherkinAgent": CODER,
    "GherkinSyntaxAgent": CODER,

    # Phase 1: Test Generation & Remediation
    "TestGeneratorAgent": CODER,
    "TestFixerAgent": CODER,

    # Phase 2: Step Generation & Audit
    "AutomationFeasibilityAgent": CODER,
    "PatternAuditAgent": CODER,
    "PatternResolutionAgent": CODER,
    "StepSkeletonAgent": CODER,
    "StepGeneratorAgent": CODER,
    "StepReviewAgent": CODER,

    # Phase 3: Locator & Element Discovery
    "LocatorGeneratorAgent": CODER
}


def get_agent_model(agent_name: str) -> str:
    """Returns the model type assigned to a specific agent."""
    return AGENT_MODEL_MAP.get(agent_name, GENERAL)