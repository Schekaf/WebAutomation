from selenium import webdriver
from selenium.webdriver.chrome.service import Service


def get_driver():
    chrome_options = webdriver.ChromeOptions()
    chrome_options.add_experimental_option('excludeSwitches', ['enable-logging'])
    chrome_driver = Service('chromedriver.exe')
    return webdriver.Chrome(service=chrome_driver, options=chrome_options)
