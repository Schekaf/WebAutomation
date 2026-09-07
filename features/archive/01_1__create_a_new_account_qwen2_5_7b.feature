Feature: Create a New Account

Scenario: Register a New Trade Business Account
    Given I open "https://tradehub.com.au"
    When I click on "Create an Account"
    And I select "Trade Business" as Account Type
    And I enter "John Doe" as Name
    And I enter "TradeBusinessInc" as Business Name
    And I enter "johndoe@example.com" as Email Address
    And I enter "1234567890" as Phone Number
    And I select "Construction" as Primary Trade
    And I enter "Sydney" as Suburb/Location
    And I enter "Password123" as Password
    And I accept the Terms and Conditions
    Then I complete account registration
    And I check if all instructions are easy to understand
    And I check if required fields are clearly identified
    And I check if incorrect fields show useful error messages
    And I check if the primary trade selection works correctly
    And I check if the location/suburb search works correctly
    And I check if the page displays correctly on mobile
    And I check if registration completes successfully
    And I check if the user receives the correct activation/verification email
    And I check if the activation email is easy to understand
    And I check if the activation link works
    And I check if after activation, I can log in successfully

Scenario Outline: Validate Account Registration with Invalid Data
    Given I open "https://tradehub.com.au"
    When I click on "Create an Account"
    And I select "Trade Business" as Account Type
    And I enter "John Doe" as Name
    And I enter "TradeBusinessInc" as Business Name
    And I enter "johndoe@example.com" as Email Address
    And I enter "1234567890" as Phone Number
    And I select "Construction" as Primary Trade
    And I enter "Sydney" as Suburb/Location
    And I enter "Password123" as Password
    And I accept the Terms and Conditions
    Then I enter "Invalid" as Value in "Phone Number" field
    And I complete account registration
    And I check if the page displays an error message for "Phone Number" field
    And I check if the primary trade selection works correctly
    And I check if the location/suburb search works correctly
    And I check if the page displays correctly on mobile
    And I check if registration completes successfully
    And I check if the user receives the correct activation/verification email
    And I check if the activation email is easy to understand
    And I check if the activation link works
    And I check if after activation, I can log in successfully

Scenario: Register a New Account with Missing Fields
    Given I open "https://tradehub.com.au"
    When I click on "Create an Account"
    And I select "Trade Business" as Account Type
    And I enter "John Doe" as Name
    And I enter "TradeBusinessInc" as Business Name
    And I enter "johndoe@example.com" as Email Address
    And I enter "1234567890" as Phone Number
    And I select "Construction" as Primary Trade
    And I enter "Sydney" as Suburb/Location
    And I enter "Password123" as Password
    And I accept the Terms and Conditions
    Then I do not enter any value in "Phone Number" field
    And I complete account registration
    And I check if the page displays an error message for "Phone Number" field
    And I check if the primary trade selection works correctly
    And I check if the location/suburb search works correctly
    And I check if the page displays correctly on mobile
    And I check if registration completes successfully
    And I check if the user receives the correct activation/verification email
    And I check if the activation email is easy to understand
    And I check if the activation link works
    And I check if after activation, I can log in successfully
