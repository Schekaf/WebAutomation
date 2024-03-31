import configparser
from selenium.webdriver.remote.webelement import WebElement


class Common:
    def __init__(self, driver, ini_file_path):
        self.driver = driver
        self.config = configparser.ConfigParser()
        self.config.read(ini_file_path)

    def get_xpath(self,  element_name, section='locator') -> str:
        return self.config.get(section, element_name)

    def get_element(self, element_name) -> WebElement:
        return self.driver.find_element_by_xpath(element_name)