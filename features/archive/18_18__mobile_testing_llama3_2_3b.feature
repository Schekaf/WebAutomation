Feature: Mobile Testing

Scenario Outline: Test Account Registration on Mobile

Given I am on the login page
When I tap the Register button
Then I should see the registration form
And I should see the "Create Account" title
And I should see the "Email" field
And I should see the "Password" field
And I should see the "Confirm Password" field
And I should see the "Submit" button

Scenario Outline: Test Login on Mobile

Given I am on the login page
When I enter my email and password
And I tap the Login button
Then I should see the dashboard
And I should see the "Welcome, [username]" message
And I should see the "Logout" button

Scenario Outline: Test Dashboard on Mobile

Given I am on the dashboard page
When I tap the "View Profile" button
Then I should see my profile information
And I should see the "Edit Profile" button
And I should see the "Directory" button
And I should see the "Find Jobs" button

Scenario Outline: Test Edit Profile on Mobile

Given I am on the dashboard page
When I tap the "Edit Profile" button
Then I should see the edit profile form
And I should see the "Email" field
And I should see the "Password" field
And I should see the "Confirm Password" field
And I should see the "Submit" button

Scenario Outline: Test Directory on Mobile

Given I am on the dashboard page
When I tap the "Directory" button
Then I should see the directory list
And I should see the "Search" bar
And I should see the "Sort" options

Scenario Outline: Test Find Jobs on Mobile

Given I am on the dashboard page
When I tap the "Find Jobs" button
Then I should see the job list
And I should see the "Search" bar
And I should see the "Sort" options

Scenario Outline: Test Open Job on Mobile

Given I am on the job list page
When I tap a job title
Then I should see the job details
And I should see the "Apply" button

Scenario Outline: Test Apply for Job on Mobile

Given I am on the job details page
When I tap the "Apply" button
Then I should see the application form
And I should see the "Submit" button

Scenario Outline: Test Return from Apply for Job on Mobile

Given I am on the job details page
When I tap the "Back" button
Then I should see the job list
And I should see the "Search" bar
And I should see the "Sort" options

Scenario Outline: Test Post Job on Mobile

Given I am on the dashboard page
When I tap the "Post Job" button
Then I should see the post job form
And I should see the "Submit" button

Scenario Outline: Test View Tender on Mobile

Given I am on the job list page
When I tap a job title
Then I should see the tender details
And I should see the "Submit Quote" button

Scenario Outline: Test Submit Tender Quote on Mobile

Given I am on the tender details page
When I tap the "Submit Quote" button
Then I should see a confirmation message
And I should see the "Back" button

Scenario Outline: Test Messages on Mobile

Given I am on the dashboard page
When I tap the "Messages" button
Then I should see the message list
And I should see the "Read" button

Scenario Outline: Test Notifications on Mobile

Given I am on the dashboard page
When I tap the "Notifications" button
Then I should see the notification list
And I should see the "Mark as Read" button

Scenario Outline: Test List Availability on Mobile

Given I am on the dashboard page
When I tap the "List Availability" button
Then I should see the availability list
And I should see the "Sort" options

Scenario Outline: Check for text overlapping on mobile

Given I am on the dashboard page
When I tap the "View Profile" button
Then I should not see any overlapping text

Scenario Outline: Check for buttons outside the screen on mobile

Given I am on the dashboard page
When I tap the "Edit Profile" button
Then I should not see any buttons outside the screen

Scenario Outline: Check for buttons covered by menus on mobile

Given I am on the dashboard page
When I tap the "Directory" button
Then I should not see any buttons covered by menus

Scenario Outline: Check for tiny buttons on mobile

Given I am on the dashboard page
When I tap the "Find Jobs" button
Then I should not see any tiny buttons

Scenario Outline: Check for menus that will not close on mobile

Given I am on the dashboard page
When I tap the "Directory" button
Then I should see the menu close

Scenario Outline: Check for keyboard covering input fields on mobile

Given I am on the dashboard page
When I tap the "Email" field
Then I should not see the keyboard covering the field

Scenario Outline: Check for pages that cannot scroll on mobile

Given I am on the dashboard page
When I tap the "View Profile" button
Then I should be able to scroll the page

Scenario Outline: Check for pop-ups/drawers that cannot be closed on mobile

Given I am on the dashboard page
When I tap the "Directory" button
Then I should be able to close the pop-up/drawer

Scenario Outline: Check for back buttons that do not work on mobile

Given I am on the dashboard page
When I tap the "Back" button
Then I should be able to go back to the previous page

Scenario Outline: Check for forms losing information on mobile

Given I am on the dashboard page
When I tap the "Edit Profile" button
Then I should not lose any information in the form

Scenario Outline: Check for layouts that look significantly different from desktop

Given I am on the dashboard page
When I tap the "View Profile" button
Then I should see a layout that looks significantly different from desktop
