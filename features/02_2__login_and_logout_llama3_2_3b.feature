Feature: Login and Logout

Scenario Outline: Login and Logout
Given I am on the TradeHub login page
When I enter a valid username and password
Then I should see the dashboard page

Scenario Outline: Log out of TradeHub
Given I am on the TradeHub login page
When I click on the Logout button
Then I should see the login page

Scenario Outline: Log back in using the account you created
Given I am on the TradeHub login page
When I click on the Forgot Password link
And I enter a valid email address
And I click on the Reset Password button
And I enter a new password
And I click on the Submit button
Then I should see the dashboard page

Scenario Outline: Close the browser and reopen TradeHub
Given I am on the TradeHub login page
When I close the browser
And I reopen TradeHub
Then I should see the login page

Scenario Outline: Check whether login/session behaviour seems correct
Given I am on the TradeHub login page
When I enter a valid username and password
And I click on the Logout button
Then I should see the login page

Scenario Outline: Test the "Forgot Password" function
Given I am on the TradeHub login page
When I click on the Forgot Password link
And I enter a valid email address
And I click on the Reset Password button
Then I should see the password reset email

Scenario Outline: Check whether the password reset email arrives
Given I am on the TradeHub login page
When I click on the Forgot Password link
And I enter a valid email address
And I click on the Reset Password button
Then I should receive a password reset email

Scenario Outline: Check whether the password reset link works
Given I am on the TradeHub login page
When I receive a password reset email
And I click on the password reset link
Then I should see the password reset form

Scenario Outline: Check for unexpected logouts
Given I am on the TradeHub login page
When I click on the Logout button
And I click on the Login button
Then I should see the login page

Scenario Outline: Check for login loops
Given I am on the TradeHub login page
When I enter a valid username and password
And I click on the Logout button
And I click on the Login button
Then I should see the login page

Scenario Outline: Check for incorrect redirects
Given I am on the TradeHub login page
When I enter a valid username and password
And I click on the Logout button
And I click on the Login button
Then I should see the login page

Scenario Outline: Check for password reset issues
Given I am on the TradeHub login page
When I click on the Forgot Password link
And I enter a valid email address
And I click on the Reset Password button
Then I should see the password reset form

Scenario Outline: Check for pages that remain accessible when logged out but should require an account
Given I am on the TradeHub login page
When I click on the Logout button
Then I should not see the dashboard page
