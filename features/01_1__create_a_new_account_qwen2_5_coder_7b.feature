Feature: Create a New Account

@SmokeTest
Scenario: Verify account creation process
  Given I open "https://tradehub.com.au"
  When I click on "Register"
  And I select "Trade Business" as "Account Type"
  And I enter "John Doe" in "Name"
  And I enter "MyBusiness" in "Business Name"
  And I enter "john.doe@example.com" in "Email"
  And I enter "1234567890" in "Phone Number"
  And I select "Agriculture" as "Primary Trade"
  And I enter "Sydney" in "Suburb/Location"
  And I enter "password123" in "Password"
  And I accept "Terms and Conditions"
  And I click on "Register"
  Then I see "Account created successfully" is "visible"
  And I see "Activation email sent" is "visible"

@NegativeTesting
Scenario: Verify error messages for invalid inputs
  Given I open "https://tradehub.com.au"
  When I click on "Register"
  And I select "Trade Business" as "Account Type"
  And I enter "" in "Name"
  And I enter "MyBusiness" in "Business Name"
  And I enter "john.doe@example.com" in "Email"
  And I enter "" in "Phone Number"
  And I select "Agriculture" as "Primary Trade"
  And I enter "Sydney" in "Suburb/Location"
  And I enter "password123" in "Password"
  And I accept "Terms and Conditions"
  And I click on "Register"
  Then I see "Name is required" is "visible"
  And I see "Phone Number is required" is "visible"

@MobileTesting
Scenario: Verify mobile responsiveness
  Given I open "https://tradehub.com.au" on mobile
  When I click on "Register"
  And I select "Trade Business" as "Account Type"
  And I enter "John Doe" in "Name"
  And I enter "MyBusiness" in "Business Name"
  And I enter "john.doe@example.com" in "Email"
  And I enter "1234567890" in "Phone Number"
  And I select "Agriculture" as "Primary Trade"
  And I enter "Sydney" in "Suburb/Location"
  And I enter "password123" in "Password"
  And I accept "Terms and Conditions"
  And I click on "Register"
  Then I see "Account created successfully" is "visible"
  And I see "Activation email sent" is "visible"
