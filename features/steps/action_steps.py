from utilities.step_helper import step


@step('I click on {element} button')
def step_impl(context, element):
    assert context.common.element_click(element) is None, f'Failed to click on button: {element}'


@step('I enter "{text}" into {field_name} field')
def step_impl(context, text, field_name):
    assert context.common.enter_text(field_name, text) is None, f'Failed to enter text into field: {field_name}'
