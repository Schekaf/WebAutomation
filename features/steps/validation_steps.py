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

from utilities.step_helper import step


@step('I see "{text}" as {field_name} field value')
def step_impl(context, text, field_name):
    element = context.common.get_element(field_name)
    actual_value = element.get_attribute("value")
    actual_visible_text = context.elementHelper.get_element_visible_text(element)
    actual_value = actual_value if actual_value is not None else actual_visible_text
    assert actual_value == text or actual_visible_text == text, f'Expected value "{text}" but got "{actual_value}" for field: {field_name}'


@step('I should be redirected to the "{expected_path}" page')
def step_impl(context, expected_path):
    context.common.get_redirected_url(expected_path)
    assert expected_path in context.driver.current_url
