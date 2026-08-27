Feature: Post a Job

Scenario Outline: Successful Job Posting
Given I am on the post a job page
When I enter a job title
And I select the required trade
And I enter a detailed description
And I enter the job location
And I enter the date
And I enter the expected duration
And I enter the rate/budget if applicable
And I add an emergency/urgent tag if available
And I upload an attachment/photo if available
Then I should see a successful submission message

Scenario Outline: Job Appears in Account
Given I am on the post a job page
When I enter a job title
And I select the required trade
And I enter a detailed description
And I enter the job location
And I enter the date
And I enter the expected duration
And I enter the rate/budget if applicable
And I add an emergency/urgent tag if available
And I upload an attachment/photo if available
And I submit the job
Then I should see the job in my account

Scenario Outline: Job Awaits Admin Approval
Given I am on the post a job page
When I enter a job title
And I select the required trade
And I enter a detailed description
And I enter the job location
And I enter the date
And I enter the expected duration
And I enter the rate/budget if applicable
And I add an emergency/urgent tag if available
And I upload an attachment/photo if available
And I submit the job
Then I should see the job as awaiting admin approval

Scenario Outline: Job Opening
Given I am on the post a job page
When I enter a job title
And I select the required trade
And I enter a detailed description
And I enter the job location
And I enter the date
And I enter the expected duration
And I enter the rate/budget if applicable
And I add an emergency/urgent tag if available
And I upload an attachment/photo if available
And I open the job
Then I should see the job details

Scenario Outline: Job Editing
Given I am on the post a job page
When I enter a job title
And I select the required trade
And I enter a detailed description
And I enter the job location
And I enter the date
And I enter the expected duration
And I enter the rate/budget if applicable
And I add an emergency/urgent tag if available
And I upload an attachment/photo if available
And I submit the job
And I open the job
Then I should see the job details

Scenario Outline: Job Editing - Description
Given I am on the post a job page
When I enter a job title
And I select the required trade
And I enter a detailed description
And I enter the job location
And I enter the date
And I enter the expected duration
And I enter the rate/budget if applicable
And I add an emergency/urgent tag if available
And I upload an attachment/photo if available
And I submit the job
And I open the job
And I edit the description
Then I should see the updated description

Scenario Outline: Job Editing - Date
Given I am on the post a job page
When I enter a job title
And I select the required trade
And I enter a detailed description
And I enter the job location
And I enter the date
And I enter the expected duration
And I enter the rate/budget if applicable
And I add an emergency/urgent tag if available
And I upload an attachment/photo if available
And I submit the job
And I open the job
And I edit the date
Then I should see the updated date

Scenario Outline: Job Editing - Rate/Budget
Given I am on the post a job page
When I enter a job title
And I select the required trade
And I enter a detailed description
And I enter the job location
And I enter the date
And I enter the expected duration
And I enter the rate/budget if applicable
And I add an emergency/urgent tag if available
And I upload an attachment/photo if available
And I submit the job
And I open the job
And I edit the rate/budget
Then I should see the updated rate/budget

Scenario Outline: Job Editing - Cancel/Close
Given I am on the post a job page
When I enter a job title
And I select the required trade
And I enter a detailed description
And I enter the job location
And I enter the date
And I enter the expected duration
And I enter the rate/budget if applicable
And I add an emergency/urgent tag if available
And I upload an attachment/photo if available
And I submit the job
And I open the job
And I edit the job
And I cancel/close the job
Then I should see a cancellation message
