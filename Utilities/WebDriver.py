import os
from selenium import webdriver
from selenium.webdriver.chrome.service import Service

browser_options = ["--disable-notifications", "--disable-infobars", "--disable-extensions",
                   "--disable-gpu", "--no-sandbox", "--disable-dev-shm-usage", "--disable-popup-blocking"]


def get_driver():
    chrome_options = webdriver.ChromeOptions()
    default_chrome_path = os.path.expandvars(r"%USERPROFILE%\AppData\Local\Programs\chrome-win64\chrome.exe")
    chrome_options.binary_location = default_chrome_path

    for option in browser_options:
        chrome_options.add_argument(option)

    # Preferences dictionary for popup settings
    prefs = {
        # 1 = Allow, 2 = Block
        "profile.default_content_setting_values.notifications": 2,
        "profile.default_content_setting_values.geolocation": 2,
        "profile.default_content_setting_values.media_stream": 2,
        "profile.default_content_setting_values.popups": 2,
        "profile.popups_disabled": 1,
        "browser.popups.show_popup_blocker": False
    }

    chrome_options.add_experimental_option("prefs", prefs)
    chrome_options.add_experimental_option('excludeSwitches', ['enable-logging'])
    chrome_driver = Service('chromedriver.exe')
    return webdriver.Chrome(service=chrome_driver, options=chrome_options)
