Feature: Web Automation with Behave

  Scenario: Open Web Inputs on Practice
    Given I open "https://practice.expandtesting.com/"
    And I click on Web Inputs Try it out button
    When I enter "5" into Input Number field
    Then I see "5" as Input Number field value
