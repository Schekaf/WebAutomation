Feature: Post a Job

@SmokeTest
Scenario: Submit a job successfully
  Given I open "https://tradehub.com.au"
  When I click on "Post a Job"
  And I enter "Software Engineer" in "Job Title"
  And I select "IT" as "Required Trade"
  And I enter "Developing scalable web applications" in "Detailed Description"
  And I enter "Sydney, Australia" in "Job Location"
  And I enter "2023-10-01" in "Date"
  And I enter "6 months" in "Expected Duration"
  And I enter "1000" in "Rate/Budget"
  And I select "Urgent" as "Emergency/urgent tag"
  And I upload "attachment.jpg" as "Attachment/Photo"
  And I click on "Submit Job"
  Then I see "Job submitted successfully" is displayed
  And I see "Job awaiting admin approval" in "Job Status"

@SmokeTest
Scenario: Verify job appears in account
  Given I open "https://tradehub.com.au"
  When I click on "My Account"
  And I click on "Jobs"
  Then I see "Software Engineer" in "Job Title"
  And I see "IT" in "Required Trade"
  And I see "Developing scalable web applications" in "Detailed Description"
  And I see "Sydney, Australia" in "Job Location"
  And I see "2023-10-01" in "Date"
  And I see "6 months" in "Expected Duration"
  And I see "1000" in "Rate/Budget"
  And I see "Urgent" in "Emergency/urgent tag"

@SmokeTest
Scenario: Edit and save job changes
  Given I open "https://tradehub.com.au"
  When I click on "My Account"
  And I click on "Jobs"
  And I click on "Edit" for "Software Engineer" job
  And I change "Detailed Description" to "Developing scalable web applications with microservices"
  And I click on "Save Changes"
  Then I see "Job updated successfully" is displayed
  And I see "Developing scalable web applications with microservices" in "Detailed Description"

@SmokeTest
Scenario: Cancel job if available
  Given I open "https://tradehub.com.au"
  When I click on "My Account"
  And I click on "Jobs"
  And I click on "Cancel" for "Software Engineer" job
  Then I see "Job cancelled successfully" is displayed
  And I do not see "Software Engineer" in "Job Title"
