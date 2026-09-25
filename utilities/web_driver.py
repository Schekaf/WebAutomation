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