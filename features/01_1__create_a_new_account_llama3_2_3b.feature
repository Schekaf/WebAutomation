Feature: Create a New Account

Scenario Outline: Create a New Account
Given I am on the TradeHub homepage
When I click the option to create/register an account
Then I should see the create account form

Scenario Outline: Create a New Account - Fill in Form
Given I am on the TradeHub homepage
When I click the option to create/register an account
Then I should see the create account form
And I should see the field "Name" with a label
And I should see the field "Business Name" with a label
And I should see the field "Email Address" with a label
And I should see the field "Phone Number" with a label
And I should see the field "Primary Trade" with a label
And I should see the field "Suburb/Location" with a label
And I should see the field "Password" with a label
And I should see the field "Terms and Conditions" with a label
When I enter "John Doe" in the "Name" field
And I enter "TradeHub Inc." in the "Business Name" field
And I enter "john.doe@example.com" in the "Email Address" field
And I enter "1234567890" in the "Phone Number" field
And I select "Agriculture" from the "Primary Trade" dropdown
And I enter "Sydney" in the "Suburb/Location" field
And I enter "password123" in the "Password" field
And I select "I accept the terms and conditions" from the "Terms and Conditions" checkbox
Then I should see a "Create Account" button
And I should see an error message if any field is empty

Scenario Outline: Create a New Account - Verify Registration
Given I am on the TradeHub homepage
When I click the option to create/register an account
Then I should see the create account form
And I should see the field "Name" with a label
And I should see the field "Business Name" with a label
And I should see the field "Email Address" with a label
And I should see the field "Phone Number" with a label
And I should see the field "Primary Trade" with a label
And I should see the field "Suburb/Location" with a label
And I should see the field "Password" with a label
And I should see the field "Terms and Conditions" with a label
When I enter "John Doe" in the "Name" field
And I enter "TradeHub Inc." in the "Business Name" field
And I enter "john.doe@example.com" in the "Email Address" field
And I enter "1234567890" in the "Phone Number" field
And I select "Agriculture" from the "Primary Trade" dropdown
And I enter "Sydney" in the "Suburb/Location" field
And I enter "password123" in the "Password" field
And I select "I accept the terms and conditions" from the "Terms and Conditions" checkbox
Then I should see a "Create Account" button
And I should see a success message after clicking the button
And I should receive an email with activation link

Scenario Outline: Create a New Account - Activation Email
Given I am on the TradeHub homepage
When I click the option to create/register an account
Then I should see the create account form
And I should see the field "Name" with a label
And I should see the field "Business Name" with a label
And I should see the field "Email Address" with a label
And I should see the field "Phone Number" with a label
And I should see the field "Primary Trade" with a label
And I should see the field "Suburb/Location" with a label
And I should see the field "Password" with a label
And I should see the field "Terms and Conditions" with a label
When I enter "John Doe" in the "Name" field
And I enter "TradeHub Inc." in the "Business Name" field
And I enter "john.doe@example.com" in the "Email Address" field
And I enter "1234567890" in the "Phone Number" field
And I select "Agriculture" from the "Primary Trade" dropdown
And I enter "Sydney" in the "Suburb/Location" field
And I enter "password123" in the "Password" field
And I select "I accept the terms and conditions" from the "Terms and Conditions" checkbox
Then I should see a "Create Account" button
And I should see a success message after clicking the button
And I should receive an email with activation link
And I should see the activation link in the email body
And I should be able to click the activation link to activate my account

Scenario Outline: Create a New Account - Login
Given I am on the TradeHub homepage
When I click the option to create/register an account
Then I should see the create account form
And I should see the field "Name" with a label
And I should see the field "Business Name" with a label
And I should see the field "Email Address" with a label
And I should see the field "Phone Number" with a label
And I should see the field "Primary Trade" with a label
And I should see the field "Suburb/Location" with a label
And I should see the field "Password" with a label
And I should see the field "Terms and Conditions" with a label
When I enter "John Doe" in the "Name" field
And I enter "TradeHub Inc." in the "Business Name" field
And I enter "john.doe@example.com" in the "Email Address" field
And I enter "1234567890" in the "Phone Number" field
And I select "Agriculture" from the "Primary Trade" dropdown
And I enter "Sydney" in the "Suburb/Location" field
And I enter "password123" in the "Password" field
And I select "I accept the terms and conditions" from the "Terms and Conditions" checkbox
Then I should see a "Create Account" button
And I should see a success message after clicking the button
And I should receive an email with activation link
And I should be able to click the activation link to activate my account
And I should see the login form
And I should be able to enter my email address and password
And I should see a "Login" button
And I should see a success message after clicking the button
And I should be able to access my account dashboard
