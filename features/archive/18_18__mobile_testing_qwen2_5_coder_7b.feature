Feature: Mobile Testing

Scenario: Test account registration on mobile
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Register"
And I enter "testuser@example.com" in "Email"
And I enter "password123" in "Password"
And I enter "password123" in "Confirm Password"
And I click on "Register"
Then I see "Registration successful" is displayed

Scenario: Test login on mobile
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "testuser@example.com" in "Email"
And I enter "password123" in "Password"
And I click on "Login"
Then I see "Dashboard" is displayed

Scenario: Test Dashboard on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Dashboard"
Then I see "Dashboard" is displayed
And I see "My Jobs" is displayed
And I see "My Tenders" is displayed

Scenario: Test Edit Profile on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Profile"
And I click on "Edit Profile"
And I enter "New Name" in "Name"
And I click on "Save"
Then I see "Profile updated" is displayed

Scenario: Test Directory on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Directory"
Then I see "Directory" is displayed
And I see "Search" is displayed

Scenario: Test Find Jobs on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Find Jobs"
And I enter "Software Engineer" in "Job Title"
And I click on "Search"
Then I see "Job Results" is displayed

Scenario: Test Open Job on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Find Jobs"
And I enter "Software Engineer" in "Job Title"
And I click on "Search"
And I click on "Open Job"
Then I see "Job Details" is displayed

Scenario: Test Apply for Job on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Find Jobs"
And I enter "Software Engineer" in "Job Title"
And I click on "Search"
And I click on "Open Job"
And I click on "Apply for Job"
And I enter "Cover Letter" in "Cover Letter"
And I click on "Submit"
Then I see "Application submitted" is displayed

Scenario: Test Return from Apply for Job on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Find Jobs"
And I enter "Software Engineer" in "Job Title"
And I click on "Search"
And I click on "Open Job"
And I click on "Apply for Job"
And I enter "Cover Letter" in "Cover Letter"
And I click on "Submit"
And I click on "Back"
Then I see "Job Details" is displayed

Scenario: Test Post Job on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Post Job"
And I enter "Job Title" in "Job Title"
And I enter "Job Description" in "Job Description"
And I click on "Post Job"
Then I see "Job posted" is displayed

Scenario: Test View Tender on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "View Tenders"
And I click on "Open Tender"
Then I see "Tender Details" is displayed

Scenario: Test Submit Tender Quote on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "View Tenders"
And I click on "Open Tender"
And I click on "Submit Quote"
And I enter "Quote" in "Quote"
And I click on "Submit"
Then I see "Quote submitted" is displayed

Scenario: Test Messages on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Messages"
And I click on "New Message"
And I enter "Recipient" in "Recipient"
And I enter "Message" in "Message"
And I click on "Send"
Then I see "Message sent" is displayed

Scenario: Test Notifications on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "Notifications"
Then I see "Notifications" is displayed

Scenario: Test List Availability on mobile
@SmokeTest
Given I am logged in on mobile
When I click on "List Availability"
And I select "Date" as "Date"
And I select "Time" as "Time"
And I click on "Submit"
Then I see "Availability listed" is displayed

Scenario: Check for text overlapping on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
When I scroll through the page
Then I do not see any text overlapping

Scenario: Check for buttons outside the screen on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
When I scroll through the page
Then I do not see any buttons outside the screen

Scenario: Check for buttons covered by menus on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
When I scroll through the page
Then I do not see any buttons covered by menus

Scenario: Check for tiny buttons on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
When I scroll through the page
Then I do not see any tiny buttons

Scenario: Check for menus that will not close on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
When I click on "Menu"
And I click on "Another Menu"
Then I see "Menu" is closed

Scenario: Check for keyboard covering input fields on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
When I click on "Input Field"
And I press on "Key"
Then I do not see the keyboard covering the input field

Scenario: Check for pages that cannot scroll on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
When I scroll through the page
Then I see "Page can scroll"

Scenario: Check for pop-ups/drawers that cannot be closed on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
When I click on "Pop-up"
And I click on "Close"
Then I see "Pop-up" is closed

Scenario: Check for back buttons that do not work on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
When I click on "Back Button"
Then I see "Previous page" is displayed

Scenario: Check for forms losing information on mobile
@RegressionTest
Given I open "https://tradehub.com.au"
When I enter "Information" in "Form"
And I click on "Submit"
Then I see "Information not lost" is displayed

Scenario: Check for layouts that look significantly different from desktop
@RegressionTest
Given I open "https://tradehub.com.au"
When I switch to mobile view
Then I see "Layout is mobile-friendly"
