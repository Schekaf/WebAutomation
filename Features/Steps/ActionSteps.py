from Utilities.StepHelper import step


@step('I click on {button_name} button')
def step_impl(context, button_name):
    assert context.common.element_click(button_name) is None, f'Failed to click on button: {button_name}'


@step('I enter "{text}" into {field_name} field')
def step_impl(context, text, field_name):
    assert context.common.enter_text(field_name, text) is None, f'Failed to enter text into field: {field_name}'
