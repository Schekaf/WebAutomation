Feature: TradeHub Smoke Test
  Background: Create Temp Email
    Given I open "https://temp-mail.org/en/"
    And I click on Copy the temp email address button

  Scenario: Create a New Account
    Given I open "https://www.tradehub.com.au/"
    And I click on Get started button
    When I enter "John" in Full Name Field
    And I enter "Jony" in Profile Name Field
    And I enter "john@example.com" in Email Adress Field
    And I enter "Password123" in Password Field
    And I enter "Password123" in Confirm Password Field


