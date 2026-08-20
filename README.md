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

## ⚡ Dynamic Step Parameters

The framework automatically intercepts step arguments at runtime and transforms special keyword placeholders before executing the step logic.

### Supported Keywords

| Keyword | Description                                                 | Example Input | Example Output     |
| :--- |:------------------------------------------------------------| :--- |:-------------------|
| `<TODAY>` | Replaces with current date (`DD/MM/YYYY`)                   | `Date: <TODAY>` | `Date: 20/08/2026` |
| `<PASTE>` | Replaces with OS clipboard contents                         | `<PASTE>` | `Clipboard text`   |
| `<RANDOM>` | Generates a random 4-digit number and caches it             | `User_<RANDOM>` | `User_4819`        |
| `<GETRANDOM>` | Retrieves the last generated `<RANDOM>` number              | `Confirm <GETRANDOM>` | `Confirm 4819`     |
| `<RANDOM:key>` | Generates a random 4-digit number and caches it under `key` | `<RANDOM:user_id>` | `3921`             |
| `<GET:key>` | Retrieves the cached number stored under `key`              | `<GET:user_id>` | `3921`             |

### Gherkin Examples

```gherkin
Scenario: Dynamic parameter usage in feature files
  When I enter "<TODAY>" into "Registration Date" field
  And I enter "<PASTE>" into "Notes" field
  And I enter "<RANDOM:user_id>" into "User ID" field
  And I enter "<RANDOM:order_id>" into "Order ID" field
  Then I verify user "<GET:user_id>" created order "<GET:order_id>"
  And I verify the last generated ID matches "<GETRANDOM>"
```

### 📁 Project Architecture

```text
├── Elements/                  # UI element locators (XPaths, CSS selectors)
│   └── home_page.ini          
├── Features/
│   ├── Steps/                 # Step definitions (links Gherkin to Page Objects)
│   │   ├── ActionSteps.py   
│   │   ├── BrowserSteps.py   
│   │   └── ValidationSteps.py
│   ├── environment.py         # Hooks (before/after scenario, screenshot capture)
│   └── WebInputs.feature      # Gherkin feature files
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



