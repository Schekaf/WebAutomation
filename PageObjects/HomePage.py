from Utilities.Common import Common


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
