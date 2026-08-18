from behave import given, when, then, step


@given('I open "{url}"')
def step_impl(context, url):
    assert context.homepage.open(url) is None, f'Failed to open URL: {url}'
