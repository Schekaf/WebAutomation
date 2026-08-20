from Utilities.StepHelper import step



@step('I see "{text}" as {field_name} field value')
def step_impl(context, text, field_name):
    element = context.common.get_element(field_name)
    actual_value = element.get_attribute("value")
    actual_visible_text = context.elementHelper.get_element_visible_text(element)
    assert actual_value == text or actual_visible_text == text, f'Expected value "{text}" but got "{actual_value}" for field: {field_name}'


@step('I should be redirected to the "{expected_path}" page')
def step_impl(context, expected_path):
    context.common.get_redirected_url(expected_path)
    assert expected_path in context.driver.current_url
