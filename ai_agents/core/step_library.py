import glob
import os
import re

# Static baseline library of framework step patterns
STEP_PATTERNS_LIBRARY = """STRICT STEP PATTERNS:
ActionSteps:
- I click on "{element}"
- I drag "{source}" to "{destination}" and drop
- I right click on "{element}"
- I select "{value}" as "{element}"
- I deselect "{value}" as "{element}"
- I enter "{value}" in "{element}"
- I paste "{value}" in "{element}"

BrowserSteps:
- I open "{url}"
- I click the Go Back Button
- I press on "{key}" Key

ValidationSteps:
- I see "{element}" is "{option}"
- I see "{values}" is selected as "{element}"
- I see "{values}" in "{element}" Values
- I do not see "{element}"
"""
import os
import glob
import re

def get_escaped_step_patterns() -> str:
    """Returns step patterns with escaped curly braces for LangChain templates."""
    return STEP_PATTERNS_LIBRARY.replace("{", "{{").replace("}", "}}")








