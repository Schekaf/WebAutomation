Feature: Login and Logout

@SmokeTest
Scenario: Log out of TradeHub
  Given I am logged into TradeHub
  When I click on "Logout"
  Then I should see "Login" button is visible

@SmokeTest
Scenario: Log back in using the account you created
  Given I am on the TradeHub login page
  When I enter "{{username}}" in "Username" field
  And I enter "{{password}}" in "Password" field
  And I click on "Login"
  Then I should see "Dashboard" page is displayed

@RegressionTest
Scenario: Close the browser and reopen TradeHub
  Given I am logged into TradeHub
  When I close the browser and reopen TradeHub
  Then I should see "Login" button is visible

@RegressionTest
Scenario: Check whether login/session behaviour seems correct
  Given I am logged into TradeHub
  When I perform various actions on the dashboard
  Then I should see no unexpected logouts
  And I should see no login loops
  And I should see no incorrect redirects

@NegativeTesting
Scenario: Test the "Forgot Password" function
  Given I am on the TradeHub login page
  When I click on "Forgot Password"
  And I enter "{{email}}" in "Email" field
  And I click on "Submit"
  Then I should see "Password reset email sent" message

@NegativeTesting
Scenario: Check whether the password reset email arrives
  Given I have received the password reset email
  When I open the email and click on the reset link
  Then I should see "Reset Password" page is displayed

@NegativeTesting
Scenario: Check whether the password reset link works
  Given I am on the "Reset Password" page
  When I enter "{{new_password}}" in "New Password" field
  And I enter "{{confirm_password}}" in "Confirm Password" field
  And I click on "Reset Password"
  Then I should see "Password reset successful" message

@NegativeTesting
Scenario: Check for unexpected logouts
  Given I am logged into TradeHub
  When I wait for 30 minutes without any activity
  Then I should see "Login" button is visible

@NegativeTesting
Scenario: Check for login loops
  Given I am on the TradeHub login page
  When I enter "{{username}}" in "Username" field
  And I enter "{{password}}" in "Password" field
  And I click on "Login"
  And I click on "Logout"
  And I click on "Login"
  Then I should see "Dashboard" page is displayed

@NegativeTesting
Scenario: Check for incorrect redirects
  Given I am logged into TradeHub
  When I click on "Logout"
  And I click on "Dashboard"
  Then I should see "Login" button is visible

@NegativeTesting
Scenario: Check for password reset issues
  Given I am on the "Reset Password" page
  When I enter "{{new_password}}" in "New Password" field
  And I enter "{{confirm_password}}" in "Confirm Password" field
  And I click on "Reset Password"
  Then I should see "Password reset successful" message

@NegativeTesting
Scenario: Check for pages that remain accessible when logged out but should require an account
  Given I am on the TradeHub login page
  When I click on "Forgot Password"
  Then I should see "Password reset email sent" message
