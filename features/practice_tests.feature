Feature: Web Automation with Behave

  @WebInputs
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

  @LoginSuccess
  Scenario: Successful Login
    Given I open "https://practice.expandtesting.com/"
    And I click on Test Login Page Try it out button
    When I enter "practice" into Username field
    And I enter "SuperSecretPassword!" into Password field
    And I click on Login button
    And I should be redirected to the "/secure" page

  @LoginFailurePassword
  Scenario: Invalid Password Login
    Given I open "https://practice.expandtesting.com/"
    And I click on Test Login Page Try it out button
    When I enter "practice" into Username field
    And I enter "123456" into Password field
    And I click on Login button
    Then I see "Your password is invalid!" as Login Error Message field value

  @LoginFailureUserName
  Scenario: Invalid Username Login
    Given I open "https://practice.expandtesting.com/"
    And I click on Test Login Page Try it out button
    When I enter "invalidUser" into Username field
    And I enter "SuperSecretPassword!" into Password field
    And I click on Login button
    Then I see "Invalid username." as Login Error Message field value

  @Register
  Scenario: Successful Register
    Given I open "https://practice.expandtesting.com/"
    And I click on Test Register Page Try it out button
    When I enter "<RANDOM:8>" into Username field
    And I enter "Password1234!" into Password field
    And I enter "Password1234!" into Confirm Password field
    And I click on Register button
    Then I see "Successfully registered, you can log in now." as Register Message field value
