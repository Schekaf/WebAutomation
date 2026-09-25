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

import glob
import configparser
import os.path

from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

class Common:
    def __init__(self, driver):
        self.driver = driver
        self.config = configparser.ConfigParser()
        elements_dir = os.path.join(os.getcwd(), "elements")
        ini_files = glob.glob(os.path.join(elements_dir, "*.ini"))
        self.config.read(ini_files, encoding="utf-8")

    def get_locator(self, key_name, section="locator"):
        """Retrieves the XPath locator string from the .ini file."""
        try:
            return self.config.get(section, key_name.lower())
        except (configparser.NoSectionError, configparser.NoOptionError) as e:
            raise KeyError(f"Locator key '{key_name}' not found in section '[{section}]'") from e

    def get_element(self, field_name):
        """Example usage: retrieves a web element using locator key from .ini file."""
        xpath_val = self.get_locator(field_name)
        return self.driver.find_element(By.XPATH, xpath_val)

    def get_redirected_url(self, expected_path, timeout=10):
        return WebDriverWait(self.driver, timeout).until(
            EC.url_contains(expected_path),
            message=f"Timed out waiting for URL to contain '{expected_path}'. Current URL: '{self.driver.current_url}'"
        )

    def element_click(self, key_name):
        """Example usage: clicks an element using locator key from .ini file."""
        xpath_val = self.get_locator(key_name)
        element = self.driver.find_element(By.XPATH, xpath_val)
        return element.click()

    def enter_text(self, key_name, text):
        """Example usage: enters text into an input field using locator key from .ini file."""
        xpath_val = self.get_locator(key_name)
        element = self.driver.find_element(By.XPATH, xpath_val)
        element.clear()
        return element.send_keys(text)