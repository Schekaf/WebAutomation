Feature: Mobile Testing

Scenario: Test account registration on mobile
    Given I open "https://tradehub.com.au/register"
    When I enter "validEmail@example.com" in "Email"
    And I enter "Password123" in "Password"
    And I enter "Password123" in "Confirm Password"
    And I click on "Register"
    Then I see "Registration Successful" in "Notification"

Scenario: Test login on mobile
    Given I open "https://tradehub.com.au/login"
    When I enter "validEmail@example.com" in "Email"
    And I enter "Password123" in "Password"
    And I click on "Login"
    Then I see "Welcome, validEmail@example.com" in "Dashboard Header"

Scenario: Test Dashboard on mobile
    Given I am logged in as "validEmail@example.com"
    When I open "Dashboard"
    Then I see "My Profile" in "Navigation Menu"

Scenario: Test Edit Profile on mobile
    Given I am logged in as "validEmail@example.com"
    When I open "Edit Profile"
    And I enter "New Name" in "Name"
    And I click on "Save"
    Then I see "Profile Updated" in "Notification"

Scenario: Test Directory on mobile
    Given I open "Directory"
    When I search for "Job Title"
    Then I see "Search Results" in "Search Results Section"

Scenario: Test Find Jobs on mobile
    Given I open "Find Jobs"
    When I enter "Job Title" in "Search Bar"
    Then I see "Job Listings" in "Job Listings Section"

Scenario: Test Open Job on mobile
    Given I am on "Job Listing"
    When I click on "Open Job"
    Then I see "Job Details" in "Job Details Section"

Scenario: Test Apply for Job on mobile
    Given I am on "Job Details"
    When I click on "Apply for Job"
    And I enter "Cover Letter" in "Cover Letter"
    And I enter "Resume" in "Resume"
    And I click on "Submit"
    Then I see "Application Sent" in "Notification"

Scenario: Test Return from Apply for Job on mobile
    Given I am on "Job Details"
    When I click on "Apply for Job"
    And I enter "Cover Letter" in "Cover Letter"
    And I enter "Resume" in "Resume"
    And I click on "Submit"
    And I click on "Back"
    Then I see "Job Details" in "Job Details Section"

Scenario: Test Post Job on mobile
    Given I am logged in as "validEmail@example.com"
    When I open "Post Job"
    And I enter "Job Title" in "Job Title"
    And I enter "Job Description" in "Job Description"
    And I click on "Post"
    Then I see "Job Posted" in "Notification"

Scenario: Test View Tender on mobile
    Given I am on "Tender Listing"
    When I click on "View Tender"
    Then I see "Tender Details" in "Tender Details Section"

Scenario: Test Submit Tender Quote on mobile
    Given I am on "Tender Details"
    When I enter "Quote" in "Quote"
    And I click on "Submit Quote"
    Then I see "Quote Submitted" in "Notification"

Scenario: Test Messages on mobile
    Given I am logged in as "validEmail@example.com"
    When I open "Messages"
    Then I see "Inbox" in "Inbox Section"

Scenario: Test Notifications on mobile
    Given I am logged in as "validEmail@example.com"
    When I open "Notifications"
    Then I see "Notifications" in "Notifications Section"

Scenario: Test List Availability on mobile
    Given I am logged in as "validEmail@example.com"
    When I open "List Availability"
    And I enter "Availability Details" in "Availability Details"
    And I click on "Save"
    Then I see "Availability Updated" in "Notification"

Scenario: Check for text overlapping on mobile
    Given I am on "Dashboard"
    When I scroll down
    Then I do not see "Text Overlapping" in "Dashboard"

Scenario: Check for buttons outside the screen on mobile
    Given I am on "Dashboard"
    When I scroll down
    Then I do not see "Buttons Outside Screen" in "Dashboard"

Scenario: Check for buttons covered by menus on mobile
    Given I am on "Dashboard"
    When I open "Menu"
    Then I do not see "Buttons Covered by Menu" in "Dashboard"

Scenario: Check for tiny buttons on mobile
    Given I am on "Dashboard"
    When I zoom in
    Then I see "Tiny Buttons" in "Dashboard"

Scenario: Check for menus that will not close on mobile
    Given I am on "Dashboard"
    When I open "Menu"
    And I click on "Close"
    Then I see "Menu Closed" in "Notification"

Scenario: Check for keyboard covering input fields on mobile
    Given I am on "Dashboard"
    When I enter "Text" in "Input Field"
    Then I see "Keyboard Not Covering Input Field" in "Notification"

Scenario: Check for pages that cannot scroll on mobile
    Given I am on "Dashboard"
    When I scroll down
    Then I see "Scrollable Page" in "Dashboard"

Scenario: Check for pop-ups/drawers that cannot be closed on mobile
    Given I am on "Dashboard"
    When I open "Popup"
    And I click on "Close"
    Then I see "Popup Closed" in "Notification"

Scenario: Check for back buttons that do not work on mobile
    Given I am on "Dashboard"
    When I click on "Back"
    Then I see "Back Button Works" in "Notification"

Scenario: Check for forms losing information on mobile
    Given I am on "Dashboard"
    When I enter "Text" in "Input Field"
    And I click on "Back"
    And I come back to "Dashboard"
    Then I see "Text" in "Input Field"

Scenario: Check for layouts that look significantly different from desktop on mobile
    Given I am on "Dashboard"
    When I compare with "Desktop Layout"
    Then I see "Layout Matches Desktop" in "Notification"
