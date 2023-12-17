from behave import given, when, then, step
from Utilities.WebDriver import get_driver
from PageObjects.HomePage import HomePage as KitapYurduHomePage


@given('I open Kitapyurdu HomePage')
def step_open_kitapyurdu(context):
    context.driver = get_driver()
    context.homePage = KitapYurduHomePage(context.driver)
    context.homePage.open()


@then('the title should be "{expected_title}"')
def step_check_title(context, expected_title):
    actual_title = KitapYurduHomePage.get_title(context)
    assert actual_title == expected_title, f'Expected title: {expected_title}, Actual title: {actual_title}'
