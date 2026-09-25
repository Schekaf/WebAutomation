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

from utilities.common import Common


class HomePage:
    def __init__(self, driver):
        self.driver = driver
        self.common = Common(self.driver)

    def open(self, url):
        return self.driver.get(url)

    def get_title(self):
        return self.driver.title

    def search_book(self, text):
        element = self.common.get_element('Search')
        element.send_keys(text)
        return element.get_attribute("value") == text
