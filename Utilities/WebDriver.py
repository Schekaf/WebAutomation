import os
from selenium import webdriver
from selenium.webdriver.chrome.service import Service


def get_driver():
    chrome_options = webdriver.ChromeOptions()
    default_chrome_path = os.path.expandvars(r"%USERPROFILE%\AppData\Local\Programs\chrome-win64\chrome.exe")
    chrome_options.binary_location = default_chrome_path
    chrome_options.add_experimental_option('excludeSwitches', ['enable-logging'])
    chrome_driver = Service('chromedriver.exe')
    return webdriver.Chrome(service=chrome_driver, options=chrome_options)
