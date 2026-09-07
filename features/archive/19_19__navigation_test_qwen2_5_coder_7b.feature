Feature: Navigation Test

@SmokeTest
Scenario: Test link for Dashboard
Given I open "https://tradehub.com.au"
When I click on "Dashboard"
Then I see "Dashboard" is "visible"

@SmokeTest
Scenario: Test link for Jobs
Given I open "https://tradehub.com.au"
When I click on "Jobs"
Then I see "Jobs" is "visible"

@SmokeTest
Scenario: Test link for Find Jobs
Given I open "https://tradehub.com.au"
When I click on "Find Jobs"
Then I see "Find Jobs" is "visible"

@SmokeTest
Scenario: Test link for Post a Job
Given I open "https://tradehub.com.au"
When I click on "Post a Job"
Then I see "Post a Job" is "visible"

@SmokeTest
Scenario: Test link for Tenders
Given I open "https://tradehub.com.au"
When I click on "Tenders"
Then I see "Tenders" is "visible"

@SmokeTest
Scenario: Test link for Post Project Tender
Given I open "https://tradehub.com.au"
When I click on "Post Project Tender"
Then I see "Post Project Tender" is "visible"

@SmokeTest
Scenario: Test link for Directory
Given I open "https://tradehub.com.au"
When I click on "Directory"
Then I see "Directory" is "visible"

@SmokeTest
Scenario: Test link for Profile
Given I open "https://tradehub.com.au"
When I click on "Profile"
Then I see "Profile" is "visible"

@SmokeTest
Scenario: Test link for Messages
Given I open "https://tradehub.com.au"
When I click on "Messages"
Then I see "Messages" is "visible"

@SmokeTest
Scenario: Test link for Notifications
Given I open "https://tradehub.com.au"
When I click on "Notifications"
Then I see "Notifications" is "visible"

@SmokeTest
Scenario: Test link for Availability
Given I open "https://tradehub.com.au"
When I click on "Availability"
Then I see "Availability" is "visible"

@SmokeTest
Scenario: Test link for Upgrade/Premium
Given I open "https://tradehub.com.au"
When I click on "Upgrade/Premium"
Then I see "Upgrade/Premium" is "visible"

@SmokeTest
Scenario: Test link for Logout
Given I open "https://tradehub.com.au"
When I click on "Logout"
Then I see "Login" is "visible"
