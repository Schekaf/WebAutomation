Feature: Browse Jobs

@SmokeTest
Scenario: Open Find Jobs / Jobs
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  Then I see "Jobs" is "visible"

@SmokeTest
Scenario: Browse available jobs
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  Then I see "Available Jobs" is "visible"

@SmokeTest
Scenario: Search for jobs
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I enter "Software Engineer" in "Search Box"
  And I click on "Search"
  Then I see "Search Results" is "visible"

@SmokeTest
Scenario: Filter by trade
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I select "IT" as "Trade Filter"
  Then I see "IT Jobs" is "visible"

@SmokeTest
Scenario: Filter by location/distance if available
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I select "Sydney" as "Location Filter"
  And I select "10km" as "Distance Filter"
  Then I see "Sydney Jobs within 10km" is "visible"

@SmokeTest
Scenario: Open several job listings
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I click on "Job 1"
  And I click on "Job 2"
  And I click on "Job 3"
  Then I see "Job Details" is "visible"

@SmokeTest
Scenario: Return to the job search results
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I click on "Job 1"
  And I click on "Back"
  Then I see "Job Search Results" is "visible"

@SmokeTest
Scenario: Check whether your search/filter settings behave correctly
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I enter "Software Engineer" in "Search Box"
  And I select "IT" as "Trade Filter"
  And I select "Sydney" as "Location Filter"
  And I select "10km" as "Distance Filter"
  And I click on "Search"
  Then I see "Search Results" is "visible"
  And I see "IT Jobs" is "visible"
  And I see "Sydney Jobs within 10km" is "visible"

@SmokeTest
Scenario: Test the experience on mobile
  Given I open "https://tradehub.com.au" on mobile
  When I click on "Find Jobs"
  And I enter "Software Engineer" in "Search Box"
  And I select "IT" as "Trade Filter"
  And I select "Sydney" as "Location Filter"
  And I select "10km" as "Distance Filter"
  And I click on "Search"
  Then I see "Search Results" is "visible"
  And I see "IT Jobs" is "visible"
  And I see "Sydney Jobs within 10km" is "visible"

@SmokeTest
Scenario: Open a job to test applying
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I click on "Job 1"
  Then I see "Job Details" is "visible"

@SmokeTest
Scenario: Apply/respond to the job
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I click on "Job 1"
  And I click on "Apply"
  And I enter "John Doe" in "Name"
  And I enter "john.doe@example.com" in "Email"
  And I enter "1234567890" in "Phone"
  And I enter "Cover Letter" in "Cover Letter"
  And I click on "Submit"
  Then I see "Application Submitted" is "visible"

@SmokeTest
Scenario: Go backwards without becoming stuck
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I click on "Job 1"
  And I click on "Back"
  And I click on "Back"
  Then I see "Job Search Results" is "visible"

@SmokeTest
Scenario: Return to the jobs list
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I click on "Job 1"
  And I click on "Back"
  Then I see "Job Search Results" is "visible"

@SmokeTest
Scenario: See that your application has been submitted
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I click on "Job 1"
  And I click on "Apply"
  And I enter "John Doe" in "Name"
  And I enter "john.doe@example.com" in "Email"
  And I enter "1234567890" in "Phone"
  And I enter "Cover Letter" in "Cover Letter"
  And I click on "Submit"
  Then I see "Application Submitted" is "visible"
