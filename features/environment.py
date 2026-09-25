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

import os

import behave

from utilities.common import Common
from utilities.element_helper import ElementHelper
from utilities.web_driver import *

from page_objects.home_page import HomePage


def before_all(context):
    pass


def before_feature(context, feature):
    pass


def before_scenario(context, scenario):
    # Reads '-D browser=...' from terminal input; defaults to 'chrome' if omitted
    browser = context.config.userdata.get("browser", "chrome")
    context.driver = get_driver(browser)

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
