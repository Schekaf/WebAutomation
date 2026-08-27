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
  And I enter "Electrician" in "Search Jobs"
  And I click on "Search"
  Then I see "Electrician" in "Search Results"

@SmokeTest
Scenario: Filter by trade
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I select "Electrician" as "Trade"
  Then I see "Electrician" in "Filter Results"

@SmokeTest
Scenario: Filter by location/distance if available
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I enter "Sydney" in "Location"
  And I click on "Search"
  Then I see "Sydney" in "Filter Results"

@SmokeTest
Scenario: Open several job listings
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I click on "Job 1"
  And I click on "Job 2"
  And I click on "Job 3"
  Then I see "Job 1" is "visible"
  And I see "Job 2" is "visible"
  And I see "Job 3" is "visible"

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
  And I enter "Electrician" in "Search Jobs"
  And I select "Sydney" as "Location"
  And I click on "Search"
  Then I see "Electrician" in "Search Results"
  And I see "Sydney" in "Filter Results"

@SmokeTest
Scenario: Test the experience on mobile
  Given I open "https://tradehub.com.au" on mobile
  When I click on "Find Jobs"
  And I enter "Electrician" in "Search Jobs"
  And I click on "Search"
  Then I see "Electrician" in "Search Results"

@SmokeTest
Scenario: Open a job to test applying
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I click on "Job 1"
  Then I see "Apply Now" is "visible"

@SmokeTest
Scenario: Apply/respond to the job
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I click on "Job 1"
  And I click on "Apply Now"
  And I enter "John Doe" in "Name"
  And I enter "john.doe@example.com" in "Email"
  And I enter "1234567890" in "Phone"
  And I enter "Curriculum Vitae" in "CV"
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
  Then I see "Jobs" is "visible"

@SmokeTest
Scenario: See that your application has been submitted
  Given I open "https://tradehub.com.au"
  When I click on "Find Jobs"
  And I click on "Job 1"
  And I click on "Apply Now"
  And I enter "John Doe" in "Name"
  And I enter "john.doe@example.com" in "Email"
  And I enter "1234567890" in "Phone"
  And I enter "Curriculum Vitae" in "CV"
  And I click on "Submit"
  Then I see "Application Submitted" is "visible"
