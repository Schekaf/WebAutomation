Feature: Job Lifecycle

Scenario: Business A posts a job
  Given I open "https://tradehub.com.au"
  When I click on "Post Job"
  And I enter "Software Engineer" in "Job Title"
  And I enter "Sydney" in "Location"
  And I enter "5000" in "Salary"
  And I click on "Submit Job"
  Then I see "Job posted successfully" is "visible"

Scenario: Business B applies/responds
  Given I open "https://tradehub.com.au"
  When I click on "Apply for Job"
  And I enter "John Doe" in "Name"
  And I enter "john.doe@example.com" in "Email"
  And I enter "5 years of experience" in "Cover Letter"
  And I click on "Submit Application"
  Then I see "Application submitted successfully" is "visible"

Scenario: Business A selects Business B
  Given I open "https://tradehub.com.au"
  When I click on "Select Business"
  And I select "John Doe" as "Business B"
  Then I see "Business B selected" is "visible"

Scenario: Job changes to Pending
  Given I open "https://tradehub.com.au"
  When I click on "Job Status"
  Then I see "Job status is Pending" is "visible"

Scenario: Business B accepts
  Given I open "https://tradehub.com.au"
  When I click on "Accept Job"
  Then I see "Job accepted" is "visible"

Scenario: Business A performs the final confirmation
  Given I open "https://tradehub.com.au"
  When I click on "Confirm Job"
  Then I see "Job confirmed" is "visible"

Scenario: Job becomes Confirmed
  Given I open "https://tradehub.com.au"
  When I click on "Job Status"
  Then I see "Job status is Confirmed" is "visible"

Scenario: Job can eventually be marked Completed
  Given I open "https://tradehub.com.au"
  When I click on "Mark Job as Completed"
  Then I see "Job marked as Completed" is "visible"

Scenario: Check that both users see the correct status at every stage
  Given I open "https://tradehub.com.au"
  When I click on "Job Status"
  Then I see "Job status is Pending" is "visible"
  And I open "https://tradehub.com.au"
  When I click on "Job Status"
  Then I see "Job status is Pending" is "visible"

Scenario: Check whether notifications are generated when the status changes
  Given I open "https://tradehub.com.au"
  When I click on "Post Job"
  And I enter "Software Engineer" in "Job Title"
  And I enter "Sydney" in "Location"
  And I enter "5000" in "Salary"
  And I click on "Submit Job"
  Then I see "Job posted successfully" is "visible"
  And I see "Notification: Job posted" is "visible"
  And I open "https://tradehub.com.au"
  When I click on "Apply for Job"
  And I enter "John Doe" in "Name"
  And I enter "john.doe@example.com" in "Email"
  And I enter "5 years of experience" in "Cover Letter"
  And I click on "Submit Application"
  Then I see "Application submitted successfully" is "visible"
  And I see "Notification: Application submitted" is "visible"
  And I open "https://tradehub.com.au"
  When I click on "Select Business"
  And I select "John Doe" as "Business B"
  Then I see "Business B selected" is "visible"
  And I see "Notification: Business B selected" is "visible"
  And I open "https://tradehub.com.au"
  When I click on "Accept Job"
  Then I see "Job accepted" is "visible"
  And I see "Notification: Job accepted" is "visible"
  And I open "https://tradehub.com.au"
  When I click on "Confirm Job"
  Then I see "Job confirmed" is "visible"
  And I see "Notification: Job confirmed" is "visible"
  And I open "https://tradehub.com.au"
  When I click on "Mark Job as Completed"
  Then I see "Job marked as Completed" is "visible"
  And I see "Notification: Job marked as Completed" is "visible"
