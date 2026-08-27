Feature: Mobile Testing

Scenario: Test account registration on mobile
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Register"
And I enter "testuser@example.com" in "Email"
And I enter "password123" in "Password"
And I enter "password123" in "Confirm Password"
And I click on "Register"
Then I see "Registration successful" is "visible"

Scenario: Test login on mobile
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "testuser@example.com" in "Email"
And I enter "password123" in "Password"
And I click on "Login"
Then I see "Dashboard" is "visible"

Scenario: Test Dashboard on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Dashboard"
Then I see "Dashboard" is "visible"

Scenario: Test Edit Profile on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Profile"
And I click on "Edit Profile"
And I enter "New Name" in "Name"
And I click on "Save"
Then I see "Profile updated" is "visible"

Scenario: Test Directory on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Directory"
Then I see "Directory" is "visible"

Scenario: Test Find Jobs on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Find Jobs"
And I enter "Software Engineer" in "Job Title"
And I click on "Search"
Then I see "Jobs" is "visible"

Scenario: Test Open Job on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Find Jobs"
And I click on "Open Job"
Then I see "Job Details" is "visible"

Scenario: Test Apply for Job on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Find Jobs"
And I click on "Apply for Job"
And I enter "Cover Letter" in "Cover Letter"
And I click on "Submit"
Then I see "Application submitted" is "visible"

Scenario: Test Return from Apply for Job on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Find Jobs"
And I click on "Apply for Job"
And I click on "Back"
Then I see "Find Jobs" is "visible"

Scenario: Test Post Job on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Post Job"
And I enter "Job Title" in "Job Title"
And I enter "Job Description" in "Job Description"
And I click on "Post"
Then I see "Job posted" is "visible"

Scenario: Test View Tender on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Tenders"
And I click on "View Tender"
Then I see "Tender Details" is "visible"

Scenario: Test Submit Tender Quote on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Tenders"
And I click on "Submit Tender Quote"
And I enter "Quote" in "Quote"
And I click on "Submit"
Then I see "Quote submitted" is "visible"

Scenario: Test Messages on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Messages"
Then I see "Messages" is "visible"

Scenario: Test Notifications on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Notifications"
Then I see "Notifications" is "visible"

Scenario: Test List Availability on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Availability"
Then I see "Availability" is "visible"

Scenario: Check for text overlapping on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
Then I do not see "Text overlapping" is "visible"

Scenario: Check for buttons outside the screen on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
Then I do not see "Buttons outside the screen" is "visible"

Scenario: Check for buttons covered by menus on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
Then I do not see "Buttons covered by menus" is "visible"

Scenario: Check for tiny buttons on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
Then I do not see "Tiny buttons" is "visible"

Scenario: Check for menus that will not close on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
Then I do not see "Menus that will not close" is "visible"

Scenario: Check for keyboard covering input fields on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
Then I do not see "Keyboard covering input fields" is "visible"

Scenario: Check for pages that cannot scroll on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
Then I do not see "Pages that cannot scroll" is "visible"

Scenario: Check for pop-ups/drawers that cannot be closed on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
Then I do not see "Pop-ups/drawers that cannot be closed" is "visible"

Scenario: Check for back buttons that do not work on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
Then I do not see "Back buttons that do not work" is "visible"

Scenario: Check for forms losing information on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
Then I do not see "Forms losing information" is "visible"

Scenario: Check for layouts that look significantly different from desktop
@RegressionTest
Given I open "https://tradehub.com.au"
Then I do not see "Layouts that look significantly different from desktop" is "visible"
