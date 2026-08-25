import os
from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.firefox.service import Service as FirefoxService
from selenium.webdriver.edge.service import Service as EdgeService

browser_options = ["--disable-notifications", "--disable-infobars", "--disable-extensions",
                   "--disable-gpu", "--no-sandbox", "--disable-dev-shm-usage", "--disable-popup-blocking"]


def get_driver(browser):
    if browser == "chrome":
        chrome_options = webdriver.ChromeOptions()
        default_chrome_path = os.path.expandvars(r"%USERPROFILE%\AppData\Local\Programs\chrome-win64\chrome.exe")
        chrome_options.binary_location = default_chrome_path

        for option in browser_options:
            chrome_options.add_argument(option)

        chrome_service = ChromeService('chromedriver.exe')
        return webdriver.Chrome(service=chrome_service, options=chrome_options)

    elif browser == "firefox":
        firefox_options = webdriver.FirefoxOptions()
        for option in browser_options:
            firefox_options.add_argument(option)

        firefox_service = FirefoxService('geckodriver.exe')
        return webdriver.Firefox(service=firefox_service, options=firefox_options)

    elif browser in ["edge", "msedge"]:
        edge_options = webdriver.EdgeOptions()
        for option in browser_options:
            edge_options.add_argument(option)

        edge_service = EdgeService('msedgedriver.exe')
        return webdriver.Edge(service=edge_service, options=edge_options)

    else:
        raise ValueError(f"Unsupported browser: {browser_name}. Choose from 'chrome', 'firefox', or 'edge'.")