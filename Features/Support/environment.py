import os

from Utilities.Common import Common
from Utilities.WebDriver import *

from PageObjects.HomePage import HomePage


def before_all(context):
    pass


def before_feature(context, feature):
    pass


def before_scenario(context, scenario):
    context.driver = get_driver()

    context.common = Common(context.driver, ini_file_path=rf"{os.getcwd()}/Elements/homepage.ini")

    context.kitap_yurdu_homepage = HomePage

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
