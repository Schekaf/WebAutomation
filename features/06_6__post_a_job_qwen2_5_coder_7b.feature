Feature: Post a Job

@SmokeTest
Scenario: Successfully post a job
Given I open "https://tradehub.com.au"
When I click on "Post a Job"
And I enter "Software Engineer" in "Job Title"
And I select "IT" as "Required Trade"
And I enter "Develop a new web application" in "Detailed Description"
And I enter "Sydney, Australia" in "Job Location"
And I enter "2023-12-31" in "Date"
And I enter "6 months" in "Expected Duration"
And I enter "1000" in "Rate/Budget"
And I select "Urgent" as "Emergency/urgent tag"
And I upload an attachment/photo
And I submit the job
Then I see "Job submitted successfully" is displayed
And I see "Software Engineer" in "Job Title" Values
And I see "IT" is selected as "Required Trade"
And I see "Develop a new web application" in "Detailed Description" Values
And I see "Sydney, Australia" in "Job Location" Values
And I see "2023-12-31" in "Date" Values
And I see "6 months" in "Expected Duration" Values
And I see "1000" in "Rate/Budget" Values
And I see "Urgent" is selected as "Emergency/urgent tag"
And I see the uploaded attachment/photo in "Attachments" Values

@SmokeTest
Scenario: Job appears in account
Given I am logged in to my account
When I open "My Jobs"
Then I see "Software Engineer" in "Job Title" Values

@SmokeTest
Scenario: Job shows as awaiting admin approval
Given I am logged in to my account
When I open "My Jobs"
And I see "Software Engineer" in "Job Title" Values
Then I see "Awaiting Admin Approval" is displayed as "Status"

@SmokeTest
Scenario: Open job
Given I am logged in to my account
When I open "My Jobs"
And I click on "Software Engineer"
Then I see "Software Engineer" in "Job Title" Values
And I see "IT" is selected as "Required Trade"
And I see "Develop a new web application" in "Detailed Description" Values
And I see "Sydney, Australia" in "Job Location" Values
And I see "2023-12-31" in "Date" Values
And I see "6 months" in "Expected Duration" Values
And I see "1000" in "Rate/Budget" Values
And I see "Urgent" is selected as "Emergency/urgent tag"
And I see the uploaded attachment/photo in "Attachments" Values

@SmokeTest
Scenario: Edit job
Given I am logged in to my account
When I open "My Jobs"
And I click on "Software Engineer"
And I click on "Edit Job"
And I change the "Description" to "Develop a new web application with advanced features"
And I save the changes
And I refresh the page
Then I see "Develop a new web application with advanced features" in "Detailed Description" Values

@SmokeTest
Scenario: Cancel job
Given I am logged in to my account
When I open "My Jobs"
And I click on "Software Engineer"
And I click on "Cancel Job"
And I confirm the cancellation
Then I see "Job cancelled successfully" is displayed
And I do not see "Software Engineer" in "Job Title" Values
