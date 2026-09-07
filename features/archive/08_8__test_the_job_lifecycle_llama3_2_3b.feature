Feature: Test the Job Lifecycle

Scenario Outline: Job Creation and Status Update

Given the system is in a logged-in state
And the user is in the "Jobs" page
When the user posts a job
Then the job status should be "Pending"

Scenario Outline: Job Application and Selection

Given the system is in a logged-in state
And the user is in the "Jobs" page
When the user applies to a job
And the job status is "Pending"
Then the job status should be "Selected"

Scenario Outline: Job Status Update

Given the system is in a logged-in state
And the user is in the "Jobs" page
When the job status is updated to "Pending"
Then the job status should be "Pending"

Scenario Outline: Job Acceptance

Given the system is in a logged-in state
And the user is in the "Jobs" page
When the job status is updated to "Pending"
And the user accepts the job
Then the job status should be "Confirmed"

Scenario Outline: Final Confirmation

Given the system is in a logged-in state
And the user is in the "Jobs" page
When the job status is updated to "Confirmed"
And the user confirms the job
Then the job status should be "Confirmed"

Scenario Outline: Job Completion

Given the system is in a logged-in state
And the user is in the "Jobs" page
When the job status is updated to "Confirmed"
And the user marks the job as completed
Then the job status should be "Completed"

Scenario Outline: Notification Generation

Given the system is in a logged-in state
And the user is in the "Jobs" page
When the job status is updated
Then a notification is generated for the user

Scenario Outline: Status Update for Both Users

Given the system is in a logged-in state
And the user is in the "Jobs" page
When the job status is updated
Then both users should see the correct job status

Scenario Outline: Notification Generation for Both Users

Given the system is in a logged-in state
And the user is in the "Jobs" page
When the job status is updated
Then both users should receive a notification
