# 🎭 (Behavior-Driven) Web Automation Framework

A scalable, maintainable End-to-End (E2E) UI testing framework built with **Python**, **Selenium WebDriver**, and **Behave (BDD)**, implementing the **Page Object Model (POM)** architecture.

---

## 🌟 Key Features

* **Behavior-Driven Development (BDD):** Human-readable Gherkin scenarios enabling clear communication between technical and non-technical stakeholders.
* **Page Object Model (POM):** Clean separation of test logic, step definitions, and UI locators for high maintainability and low test flakiness.
* **Cross-Browser & Headless Support:** Easily toggle execution across Chrome, Firefox, or Edge in both headed and headless modes.
* **Hooks & Dynamic Environment Setup:** Automated browser lifecycle management, teardown, and screenshot capture on failure via `environment.py`.
* **Rich Test Reporting:** Out-of-the-box integration for interactive Allure and HTML test reports.

---

## 🛠️ Tech Stack & Dependencies

* **Language:** Python 3.x
* **BDD Framework:** [Behave](https://behave.readthedocs.io/)
* **Browser Automation:** [Selenium WebDriver](https://www.selenium.dev/)
* **Design Pattern:** Page Object Model (POM)
* **Designated Runner / Utils:** `webdriver-manager`, `pytest-html` / `allure-behave`

---

## 📁 Project Architecture

```text
├── Elements/                  # UI element locators (XPaths, CSS selectors)
│   └── home_page.ini          
├── Features/
│   ├── Steps/                 # Step definitions (links Gherkin to Page Objects)
│   │   └── Steps.py
│   ├── environment.py         # Hooks (before/after scenario, screenshot capture)
│   └── Search.feature         # Gherkin feature files
├── PageObjects/               # Page Object Model classes (UI elements & interactions)
│   ├── BasePage.py            # Core wrapper around Selenium actions (clicks, waits, inputs)
│   └── HomePage.py            # Page-specific locators and actions
├── Reports/                   # Execution reports and failure screenshots
├── Utilities/
│   ├── Common.py              # Common functions
│   └── WebDriver.py           # WebDriver Functions (browser setup, teardown, waits)
├── behave.ini                 # Behave configuration file (tags, formatters, etc.)
├── README.md                  # Project documentation
└── requirements.txt           # Python dependencies
