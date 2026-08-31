Feature: Job Lifecycle

Scenario: Business A posts a job
  Given I open "https://tradehub.com.au"
  When I click on "Post Job"
  And I enter "Software Engineer" in "Job Title"
  And I enter "Sydney" in "Location"
  And I enter "5000" in "Salary"
  And I enter "Full-time" in "Job Type"
  And I enter "Description of the job" in "Job Description"
  And I click on "Post"
  Then I see "Job posted successfully" is "visible"

Scenario: Business B applies/responds
  Given I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Apply"
  And I enter "John Doe" in "Name"
  And I enter "john.doe@example.com" in "Email"
  And I enter "1234567890" in "Phone"
  And I enter "Cover letter" in "Cover Letter"
  And I click on "Submit"
  Then I see "Application submitted successfully" is "visible"

Scenario: Business A selects Business B
  Given I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Select"
  And I select "John Doe" as "Business B"
  Then I see "Business B selected" is "visible"

Scenario: Job changes to Pending
  Given I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Select"
  And I select "John Doe" as "Business B"
  Then I see "Job status is Pending" is "visible"

Scenario: Business B accepts
  Given I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Accept"
  Then I see "Job status is Accepted" is "visible"

Scenario: Business A performs the final confirmation
  Given I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Confirm"
  Then I see "Job status is Confirmed" is "visible"

Scenario: Job becomes Confirmed
  Given I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Confirm"
  Then I see "Job status is Confirmed" is "visible"

Scenario: Job can eventually be marked Completed
  Given I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Complete"
  Then I see "Job status is Completed" is "visible"

Scenario: Check that both users see the correct status at every stage
  Given I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Select"
  And I select "John Doe" as "Business B"
  Then I see "Job status is Pending" is "visible"
  And I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Accept"
  Then I see "Job status is Accepted" is "visible"
  And I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Confirm"
  Then I see "Job status is Confirmed" is "visible"
  And I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Complete"
  Then I see "Job status is Completed" is "visible"

Scenario: Check whether notifications are generated when the status changes
  Given I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Select"
  And I select "John Doe" as "Business B"
  Then I see "Notification: Job status changed to Pending" is "visible"
  And I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Accept"
  Then I see "Notification: Job status changed to Accepted" is "visible"
  And I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Confirm"
  Then I see "Notification: Job status changed to Confirmed" is "visible"
  And I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Job Title" in the job list
  And I click on "Complete"
  Then I see "Notification: Job status changed to Completed" is "visible"
