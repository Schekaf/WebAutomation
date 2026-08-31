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

### 🔑 Supported Keywords

| Keyword | Description | Example Input | Example Output |
| :--- | :--- | :--- | :--- |
| `<TODAY>` | Replaces with current date (`DD/MM/YYYY`) | `Date: <TODAY>` | `Date: 21/08/2026` |
| `<PASTE>` | Replaces with OS clipboard contents | `<PASTE>` | `Clipboard text` |
| `<EMPTY>` | Replaces parameter with an empty string `""` | `<EMPTY>` | `""` |
| `<NOTHING>` | Replaces parameter with an empty string `""` | `<NOTHING>` | `""` |
| `<SKIP>` | Skips step execution entirely | `<SKIP>` | *(Step skipped)* |
| `<RANDOM>` | Generates a random 6-letter string and caches it | `User_<RANDOM>` | `User_aBqXzL` |
| `<RANDOM:N>` | Generates a random $N$-letter string (e.g., length 8) | `Code_<RANDOM:8>` | `Code_fRmLpQzA` |
| `<GETRANDOM>` | Retrieves the last generated `<RANDOM>` string | `Confirm <GETRANDOM>` | `Confirm aBqXzL` |
| `<RANDOM:key>` | Generates a random 4-digit number and caches it under `key` | `<RANDOM:user_id>` | `3921` |
| `<GET:key>` | Retrieves the cached value stored under `key` | `<GET:user_id>` | `3921` |

#### Gherkin Examples

```gherkin
Scenario: Dynamic parameter usage in feature files
  When I enter "<TODAY>" into "Registration Date" field
  And I enter "<PASTE>" into "Notes" field
  And I enter "<EMPTY>" into "Middle Name" field
  And I enter "<SKIP>" into "Optional Field" field
  And I enter "User_<RANDOM:8>" into "Username" field
  And I enter "<RANDOM:user_id>" into "User ID" field
  Then I verify field "Confirmation" matches "<GETRANDOM>"
  And I verify user "<GET:user_id>" was successfully created
```

## 📁 Project Architecture

```text
WebAutomation/
├── ai_agents/                            # AI agent pipeline (generators & prompts)
│   ├── core/                             # Shared agent data layer & shared utilities
│   │   ├── __init__.py                   # Core package exports
│   │   ├── model_selector.py             # Interactive CLI model switcher & model registry
│   │   ├── schemas.py                    # Shared Pydantic schemas
│   │   ├── tradehub_domain.py            # TradeHub domain entities & prompt contexts
│   │   └── utils.py                      # Gherkin sanitization, regex matching & chunking
│   │
│   ├── qa_test_generator_agent/          # Agent 1: Checklist -> Gherkin Feature Files
│   │   ├── __init__.py
│   │   └── test_generator.py             # TestFeatureGeneratorAgent class (LLM orchestration)
│   │
│   └── qa_test_step_generator_agent/     # Agent 2: Feature Steps -> Behave Step Definitions 🛠️ Upcoming!
│       ├── __init__.py
│       └── test_step_generator.py        # TestStepGeneratorAgent class (Missing step engine) 
│
├── elements/                             # Locators (external ini/json configs)
│   ├── home_page.ini
│   └── tradehub_home.ini
│
├── features/                             # Behave BDD Layer
│   ├── steps/                            # Step definitions (links Gherkin to PageObjects)
│   │   ├── action_steps.py
│   │   ├── browser_steps.py
│   │   ├── validation_steps.py
│   │   └── generated_by_ai_steps.py      # Auto-generated step definitions from Agent 2
│   ├── environment.py                    # Behave hooks (driver init, failure screenshots)
│   └── *.feature                         # Auto-generated feature files from Agent 1
│
├── page_objects/                         # Page Object Model Layer
│   ├── __init__.py
│   ├── base_page.py                      # Core driver wrappers (click, fill, wait)
│   └── home_page.py                      # Page-specific actions & locators
│
├── reports/                              # Test execution outputs & failure artifacts
│
├── utilities/                            # Framework core utilities
│   ├── common.py                         # General helper methods
│   ├── element_helper.py                 # Advanced element handling
│   ├── step_helper.py                    # Step logging / dynamic params
│   └── web_driver.py                     # Driver setup (via webdriver-manager)
│
├── .env                                  # Local environment variables
├── .gitignore                            # Excludes venv, reports, .env, drivers
├── behave.ini                            # Behave execution settings
├── generate_features.py                  # Entry point CLI runner for Agent 1
├── generate_steps.py                     # Entry point CLI runner for Agent 2 🛠️ Upcoming!
├── README.md                             # Project documentation
└── requirements.txt                      # Dependencies
```
### 📐 AI Agent Pipeline Architecture Schema
```text
                               +----------------------------------------+
                               |     Local LLMs / Ollama Framework      |
                               | (Qwen 2.5 Coder / Llama 3.2 / Qwen)    |
                               +-------------------+--------------------+
                                                   ^
                                                   | (ChatOllama Invocation)
                                                   v
+-------------------------------------------------------------------------------------------------------+
|                                      AI AGENTS PIPELINE                                               |
|                                                                                                       |
|   +-------------------------------------------------------------------------------------------+       |
|   |                                     ai_agents/core/                                       |       |
|   |  • model_selector.py   (CLI Interactive Model Picker)                                     |       |
|   |  • schemas.py          (Pydantic Data Schemas for Structured LLM Outputs)                 |       |
|   |  • tradehub_domain.py  (TradeHub Application Domain Context & Entity Prompts)             |       |
|   |  • utils.py            (Gherkin Sanitizer, Regex Pattern Matcher, Section Splitter)       |       |
|   +----------------------------------------------+--------------------------------------------+       |
|                                                  |                                                    |
|                   +------------------------------+------------------------------+                     |
|                   |                                                             |                     |
|                   v                                                             v                     |
|   +---------------+---------------------------+                 +---------------+-----------------+   |
|   |   qa_test_generator_agent/                |                 |   qa_test_step_generator_agent/ |   |
|   |   • test_generator.py                     |                 |   • test_step_generator.py      |   |
|   +---------------+---------------------------+                 +---------------+-----------------+   |
+-------------------|-------------------------------------------------------------|---------------------+   
                    ^                                                             ^
                    |                                                             |
+-------------------|-------------------------------------------------------------|---------------------+
|   CLI RUNNERS     |                                                             |                     |
|                   |                                                             |                     |
|         +---------+------------+                                      +---------+------------+        |
|         | generate_features.py |                                      |  generate_steps.py   |        |
|         +---------+------------+                                      +---------+------------+        |
+-------------------|-------------------------------------------------------------|---------------------+
                    |                                                             |
                    v                                                             v
+-------------------|-------------------------------------------------------------|---------------------+
|   FRAMEWORK       |                                                             |                     |
|   ARTIFACTS       v                                                             v                     |
|            features/*************.feature  ---------- (Reads) ----------> features/steps/             |
|            (Generated Gherkin Feature Files)                              generated_by_ai_steps.py    |
|                                                                           (Generated Step Definitions)|
+-------------------------------------------------------------------------------------------------------+
```
## 🚀 Test Execution Guide

Tests are executed using **Behave** (BDD framework). You can customize runs using tags, browser selection, and CLI flags.

### 1. Basic Execution Commands

Run all feature files in default browser (Chrome):
```bash
behave
```
Run a specific feature file:
```bash
behave features/practice_tests.feature
```
### 2. Running by Tags
Run tests tagged with @Register:
```bash
behave features/practice_tests.feature -t Register
```
### 3. Cross-Browser Testing
You can specify the target browser dynamically via the `-D browser` flag. Supported browsers: `chrome`, `firefox`, `edge`.
```bash
behave features/practice_tests.feature -t Register -k -D browser=chrome
```
