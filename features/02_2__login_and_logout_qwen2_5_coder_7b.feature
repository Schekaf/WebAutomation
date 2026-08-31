Feature: Login and Logout

@SmokeTest
Scenario: Log out of TradeHub
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "username" in "Username"
  And I enter "password" in "Password"
  And I click on "Login"
  Then I see "Dashboard" is "visible"

  When I click on "User Menu"
  And I click on "Logout"
  Then I see "Login" is "visible"

@SmokeTest
Scenario: Log back in using the account you created
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "username" in "Username"
  And I enter "password" in "Password"
  And I click on "Login"
  Then I see "Dashboard" is "visible"

  When I click on "User Menu"
  And I click on "Logout"
  Then I see "Login" is "visible"

  When I click on "Login"
  And I enter "username" in "Username"
  And I enter "password" in "Password"
  And I click on "Login"
  Then I see "Dashboard" is "visible"

@SmokeTest
Scenario: Close the browser and reopen TradeHub
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "username" in "Username"
  And I enter "password" in "Password"
  And I click on "Login"
  Then I see "Dashboard" is "visible"

  When I close the browser
  And I reopen "https://tradehub.com.au"
  When I click on "Login"
  And I enter "username" in "Username"
  And I enter "password" in "Password"
  And I click on "Login"
  Then I see "Dashboard" is "visible"

@SmokeTest
Scenario: Check whether login/session behaviour seems correct
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "username" in "Username"
  And I enter "password" in "Password"
  And I click on "Login"
  Then I see "Dashboard" is "visible"

  When I click on "User Menu"
  And I click on "Logout"
  Then I see "Login" is "visible"

@SmokeTest
Scenario: Test the "Forgot Password" function
  Given I open "https://tradehub.com.au"
  When I click on "Forgot Password"
  And I enter "username" in "Username"
  And I click on "Submit"
  Then I see "Password Reset Email Sent" is "visible"

@SmokeTest
Scenario: Check whether the password reset email arrives
  Given I open "https://tradehub.com.au"
  When I click on "Forgot Password"
  And I enter "username" in "Username"
  And I click on "Submit"
  Then I see "Password Reset Email Sent" is "visible"

@SmokeTest
Scenario: Check whether the password reset link works
  Given I open "https://tradehub.com.au"
  When I click on "Forgot Password"
  And I enter "username" in "Username"
  And I click on "Submit"
  Then I see "Password Reset Email Sent" is "visible"

  When I click on "Password Reset Link"
  Then I see "Password Reset Form" is "visible"

@SmokeTest
Scenario: Check for unexpected logouts
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "username" in "Username"
  And I enter "password" in "Password"
  And I click on "Login"
  Then I see "Dashboard" is "visible"

  When I click on "User Menu"
  And I click on "Logout"
  Then I see "Login" is "visible"

@SmokeTest
Scenario: Check for login loops
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "username" in "Username"
  And I enter "password" in "Password"
  And I click on "Login"
  Then I see "Dashboard" is "visible"

  When I click on "User Menu"
  And I click on "Logout"
  Then I see "Login" is "visible"

@SmokeTest
Scenario: Check for incorrect redirects
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "username" in "Username"
  And I enter "password" in "Password"
  And I click on "Login"
  Then I see "Dashboard" is "visible"

  When I click on "User Menu"
  And I click on "Logout"
  Then I see "Login" is "visible"

@SmokeTest
Scenario: Check for password reset issues
  Given I open "https://tradehub.com.au"
  When I click on "Forgot Password"
  And I enter "username" in "Username"
  And I click on "Submit"
  Then I see "Password Reset Email Sent" is "visible"

  When I click on "Password Reset Link"
  Then I see "Password Reset Form" is "visible"

@SmokeTest
Scenario: Check for pages that remain accessible when logged out but should require an account
  Given I open "https://tradehub.com.au"
  When I click on "Dashboard"
  Then I see "Dashboard" is "visible"

  When I click on "User Menu"
  And I click on "Logout"
  Then I see "Login" is "visible"

  When I click on "Dashboard"
  Then I see "Login" is "visible"
