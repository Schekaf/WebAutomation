

class ElementHelper:
    def __init__(self, driver):
        self.driver = driver

    def get_element_visible_text(self, element):
        visible_text = self.driver.execute_script(
            "return arguments[0].innerText || arguments[0].valueAsDate?.toLocaleDateString('en-GB') || arguments["
            "0].value;", element
        )
        return visible_text
