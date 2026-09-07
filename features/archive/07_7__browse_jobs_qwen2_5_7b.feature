Feature: Browse Jobs

@SmokeTest
Scenario: Open Find Jobs / Jobs
    Given I open "https://tradehub.com.au/jobs"
    When I click on "Find Jobs / Jobs"
    Then I see "Find Jobs / Jobs" page is displayed

@SmokeTest
Scenario: Browse available jobs
    Given I am on "Find Jobs / Jobs" page
    When I browse available jobs
    Then I see multiple job listings are displayed

@SmokeTest
Scenario: Search for jobs
    Given I am on "Find Jobs / Jobs" page
    When I enter "Software Engineer" in "Job Title" field
    Then I see search results for "Software Engineer" are displayed

@SmokeTest
Scenario: Filter by trade
    Given I am on "Find Jobs / Jobs" page
    When I select "Software" as "Trade"
    Then I see filtered job listings for "Software" trade are displayed

@SmokeTest
Scenario: Filter by location/distance if available
    Given I am on "Find Jobs / Jobs" page
    When I enter "Sydney" in "Location" field
    Then I see filtered job listings for "Sydney" are displayed

@SmokeTest
Scenario: Open several job listings
    Given I am on "Find Jobs / Jobs" page
    When I click on "Software Engineer" job listing
    And I click on "Data Analyst" job listing
    Then I see details of "Software Engineer" and "Data Analyst" job listings are displayed

@SmokeTest
Scenario: Return to the job search results
    Given I am on "Software Engineer" job details page
    When I click the Go Back Button
    Then I see "Find Jobs / Jobs" page with search results for "Software Engineer" are displayed

@SmokeTest
Scenario: Check whether your search/filter settings behave correctly
    Given I am on "Find Jobs / Jobs" page
    When I enter "Software Engineer" in "Job Title" field
    And I select "Sydney" as "Location"
    And I select "Software" as "Trade"
    Then I see filtered job listings for "Software Engineer" in "Sydney" and "Software" trade are displayed

@SmokeTest
Scenario: Test the experience on mobile
    Given I open "https://tradehub.com.au/jobs" on mobile device
    When I browse available jobs
    Then I see multiple job listings are displayed

@SmokeTest
Scenario: Open a job to test applying
    Given I am on "Find Jobs / Jobs" page
    When I click on "Software Engineer" job listing
    Then I see "Apply Now" button is displayed

@SmokeTest
Scenario: Apply/respond to the job
    Given I am on "Software Engineer" job details page
    When I enter "John Doe" in "Full Name" field
    And I enter "johndoe@example.com" in "Email" field
    And I enter "1234567890" in "Phone" field
    And I enter "Cover Letter" in "Cover Letter" field
    And I click on "Apply Now" button
    Then I see "Your application has been submitted" message is displayed

@SmokeTest
Scenario: Go backwards without becoming stuck
    Given I am on "Software Engineer" job details page
    When I click the Go Back Button
    Then I see "Find Jobs / Jobs" page is displayed

@SmokeTest
Scenario: Return to the jobs list
    Given I am on "Software Engineer" job details page
    When I click the Go Back Button
    Then I see "Find Jobs / Jobs" page with search results for "Software Engineer" are displayed

@SmokeTest
Scenario: See that your application has been submitted
    Given I am on "Find Jobs / Jobs" page
    When I click on "Software Engineer" job listing
    And I enter "John Doe" in "Full Name" field
    And I enter "johndoe@example.com" in "Email" field
    And I enter "1234567890" in "Phone" field
    And I enter "Cover Letter" in "Cover Letter" field
    And I click on "Apply Now" button
    Then I see "Your application has been submitted" message is displayed
