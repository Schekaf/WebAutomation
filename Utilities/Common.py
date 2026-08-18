import glob
import configparser
import os.path

from selenium.webdriver.common.by import By


class Common:
    def __init__(self, driver):
        self.driver = driver
        self.config = configparser.ConfigParser()
        elements_dir = os.path.join(os.getcwd(), "Elements")
        ini_files = glob.glob(os.path.join(elements_dir, "*.ini"))
        self.config.read(ini_files, encoding="utf-8")

    def get_locator(self, key_name, section="locator"):
        """Retrieves the XPath locator string from the .ini file."""
        try:
            return self.config.get(section, key_name.lower())
        except (configparser.NoSectionError, configparser.NoOptionError) as e:
            raise KeyError(f"Locator key '{key_name}' not found in section '[{section}]'") from e

    def element_click(self, key_name):
        """Example usage: clicks an element using locator key from .ini file."""
        xpath_val = self.get_locator(key_name)
        element = self.driver.find_element(By.XPATH, xpath_val)
        element.click()