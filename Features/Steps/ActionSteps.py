from behave import given, when, then, step
from Utilities.WebDriver import get_driver


@step('I click on {button_name} button')
def step_impl(context, button_name):
    assert context.common.element_click(button_name) is None, f'Failed to click on button: {button_name}'
