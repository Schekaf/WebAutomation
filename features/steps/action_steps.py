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


@step('I click on {element} button')
def step_impl(context, element):
    assert context.common.element_click(element) is None, f'Failed to click on button: {element}'


@step('I enter "{text}" into {field_name} field')
def step_impl(context, text, field_name):
    assert context.common.enter_text(field_name, text) is None, f'Failed to enter text into field: {field_name}'
