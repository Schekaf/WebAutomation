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



class ElementHelper:
    def __init__(self, driver):
        self.driver = driver

    def get_element_visible_text(self, element):
        visible_text = self.driver.execute_script(
            "return arguments[0].innerText || arguments[0].valueAsDate?.toLocaleDateString('en-GB') || arguments["
            "0].value;", element
        )
        return visible_text
