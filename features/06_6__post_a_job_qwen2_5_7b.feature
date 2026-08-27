Feature: Post a Job

Scenario: Post a Job with All Required Information
Given I open "https://tradehub.com.au/post-job"
When I enter "QA Engineer" as the job title
And I select "Software Development" as the required trade
And I enter "Responsible for developing and maintaining software applications" as the detailed description
And I enter "Sydney, NSW" as the job location
And I enter "2023-10-01" as the date
And I enter "3 months" as the expected duration
And I enter "A$50 per hour" as the rate/budget
And I select "Emergency" as the emergency/urgent tag
And I upload a photo as the attachment
And I click on "Submit Job"
Then I see "Job submitted successfully" is displayed
And I see the job appears in my account
And I see the job correctly shows as awaiting admin approval

Scenario: Post a Job with Minimal Information
Given I open "https://tradehub.com.au/post-job"
When I enter "Developer" as the job title
And I select "Software Development" as the required trade
And I enter "Develop and maintain software applications" as the detailed description
And I enter "Sydney, NSW" as the job location
And I enter "2023-10-01" as the date
And I enter "3 months" as the expected duration
And I click on "Submit Job"
Then I see "Job submitted successfully" is displayed
And I see the job appears in my account
And I see the job correctly shows as awaiting admin approval

Scenario: Edit a Posted Job
Given I open "https://tradehub.com.au/my-jobs"
When I open the job "QA Engineer"
And I change the description to "Responsible for developing and maintaining software applications with a focus on automation"
And I change the date to "2023-10-15"
And I change the price/rate to "A$60 per hour"
And I save the changes
And I refresh the page
Then I see the changes remain
And I click on "Cancel Job"
Then I see the job is cancelled successfully
