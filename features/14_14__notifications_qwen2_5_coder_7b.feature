Feature: Notifications

@SmokeTest
Scenario: Generate activities between two accounts
Given I am logged in as "Account A"
And I navigate to "Job Applications"
When I apply for a job
And I navigate to "Account B"
And I select "Account A" as "Applicant"
And I accept the job application
And I navigate to "Tender Quotes"
And I submit a tender quote
And I navigate to "Messages"
And I send a message to "Account A"
And I navigate to "Availability"
And I mark myself as available
Then I see "Job Application" notification is generated
And I see "Selection" notification is generated
And I see "Acceptance" notification is generated
And I see "Tender Quote" notification is generated
And I see "Message" notification is generated
And I see "Availability Activity" notification is generated

@SmokeTest
Scenario: Check that notifications appear
Given I am logged in as "Account A"
And I navigate to "Notifications"
Then I see "Notifications" section is displayed

@SmokeTest
Scenario: Check if notification wording makes sense
Given I am logged in as "Account A"
And I navigate to "Notifications"
And I see "Job Application" notification
Then I see "Job Application" notification wording makes sense

@SmokeTest
Scenario: Check if clicking the notification takes you to the correct item
Given I am logged in as "Account A"
And I navigate to "Notifications"
And I click on "Job Application" notification
Then I see "Job Application" details page is displayed

@SmokeTest
Scenario: Check if read/unread behaviour works
Given I am logged in as "Account A"
And I navigate to "Notifications"
And I click on "Job Application" notification
And I mark "Job Application" notification as read
Then I see "Job Application" notification is marked as read

@SmokeTest
Scenario: Check if notification counts update
Given I am logged in as "Account A"
And I navigate to "Notifications"
And I see "Job Application" notification
And I navigate to "Job Applications"
And I apply for a job
Then I see "Job Application" notification count is updated

@SmokeTest
Scenario: Check if old notifications remain accessible
Given I am logged in as "Account A"
And I navigate to "Notifications"
And I see "Job Application" notification
And I navigate to "Job Applications"
And I apply for a job
And I navigate to "Notifications"
Then I see "Job Application" notification is still accessible
