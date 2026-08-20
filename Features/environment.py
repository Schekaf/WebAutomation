import os

import behave

from Utilities.Common import Common
from Utilities.ElementHelper import ElementHelper
from Utilities.WebDriver import *

from PageObjects.HomePage import HomePage


def before_all(context):
    pass


def before_feature(context, feature):
    pass


def before_scenario(context, scenario):
    context.driver = get_driver()

    context.common = Common(context.driver)
    context.elementHelper = ElementHelper(context.driver)
    context.homepage = HomePage(context.driver)

    context.driver.maximize_window()


def before_step(context, step):
    pass


def after_step(context, step):
    pass


def after_scenario(context, scenario):
    context.driver.quit()


def after_feature(context, feature):
    pass

def after_all(context):
    pass
