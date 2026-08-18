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
├── Elements/
├── Features/
│   ├── environment.py         # Hooks (before/after scenario, screenshot capture)
│   ├── steps/                 # Step definitions (links Gherkin to Page Objects)
│   │   └── login_steps.py
│   └── login.feature          # Gherkin feature files
├── PageObjects/                     # Page Object Model classes (UI elements & interactions)
│   ├── base_page.py           # Core wrapper around Selenium actions (clicks, waits, inputs)
│   └── login_page.py          # Page-specific locators and actions
├── PageObjects/   
├── reports/                   # Execution reports and failure screenshots
├── config.py                  # Environment configurations and driver setups
├── requirements.txt           # Python dependencies
└── README.md                  # Project documentation