Feature: Login and Logout

@SmokeTest
Scenario: Log out of TradeHub
    Given I open "https://tradehub.com.au"
    When I enter "username" in "Username Field"
    And I enter "password" in "Password Field"
    And I click on "Login Button"
    When I click on "Logout Button"
    Then I do not see "Username Field"
    And I see "Login Button" is "Visible"

@SmokeTest
Scenario: Log back in using the account you created
    Given I open "https://tradehub.com.au"
    When I click on "Login Button"
    And I enter "username" in "Username Field"
    And I enter "password" in "Password Field"
    And I click on "Login Button"
    Then I see "Dashboard" is "Visible"

@SmokeTest
Scenario: Close the browser and reopen TradeHub
    Given I open "https://tradehub.com.au"
    When I enter "username" in "Username Field"
    And I enter "password" in "Password Field"
    And I click on "Login Button"
    When I close the browser
    And I open "https://tradehub.com.au"
    Then I see "Login" is "Visible"

@SmokeTest
Scenario: Check whether login/session behaviour seems correct
    Given I open "https://tradehub.com.au"
    When I enter "username" in "Username Field"
    And I enter "password" in "Password Field"
    And I click on "Login Button"
    When I click on "Logout Button"
    And I click on "Login Button"
    Then I see "Dashboard" is "Visible"

@SmokeTest
Scenario: Test the "Forgot Password" function
    Given I open "https://tradehub.com.au"
    When I click on "Forgot Password Link"
    Then I see "Password Reset" is "Visible"

@SmokeTest
Scenario: Check whether the password reset email arrives
    Given I open "https://tradehub.com.au"
    When I click on "Forgot Password Link"
    And I enter "username" in "Username Field"
    And I click on "Submit Button"
    Then I see "Password Reset Email Sent" is "Visible"

@SmokeTest
Scenario: Check whether the password reset link works
    Given I open "https://tradehub.com.au"
    When I click on "Forgot Password Link"
    And I enter "username" in "Username Field"
    And I click on "Submit Button"
    When I click on the password reset link in the email
    Then I see "Reset Password" is "Visible"

@SmokeTest
Scenario: Check for unexpected logouts
    Given I open "https://tradehub.com.au"
    When I enter "username" in "Username Field"
    And I enter "password" in "Password Field"
    And I click on "Login Button"
    When I close the browser
    And I open "https://tradehub.com.au"
    Then I see "Login" is "Visible"

@SmokeTest
Scenario: Check for login loops
    Given I open "https://tradehub.com.au"
    When I enter "username" in "Username Field"
    And I enter "password" in "Password Field"
    And I click on "Login Button"
    When I click on "Logout Button"
    And I click on "Login Button"
    Then I see "Dashboard" is "Visible"

@SmokeTest
Scenario: Check for incorrect redirects
    Given I open "https://tradehub.com.au"
    When I enter "username" in "Username Field"
    And I enter "password" in "Password Field"
    And I click on "Login Button"
    When I click on "Logout Button"
    And I click on "Login Button"
    Then I see "Dashboard" is "Visible"

@SmokeTest
Scenario: Check for password reset issues
    Given I open "https://tradehub.com.au"
    When I click on "Forgot Password Link"
    And I enter "nonexistentusername" in "Username Field"
    And I click on "Submit Button"
    Then I see "Password Reset Email Not Sent" is "Visible"

@SmokeTest
Scenario: Check for pages that remain accessible when logged out but should require an account
    Given I open "https://tradehub.com.au"
    When I click on "Logout Button"
    And I click on "Account Settings Link"
    Then I see "Login" is "Visible"
