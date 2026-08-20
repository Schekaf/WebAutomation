Feature: Web Automation with Behave

  Scenario: Open Web Inputs on Practice
    Given I open "https://practice.expandtesting.com/"
    And I click on Web Inputs Try it out button
    When I enter "5" into Input Number field
    Then I see "5" as Input Number field value
    When I enter "Hello" into Input Text field
    Then I see "Hello" as Input Text field value
    When I enter "Password" into Input Password field
    Then I see "Password" as Input Password field value
    When I enter "<TODAY>" into Input Date field
    Then I see "<TODAY>" as Input Date field value
