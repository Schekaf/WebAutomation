Feature: Reviews

@SmokeTest
Scenario: Mark the job Completed
Given I open "https://tradehub.com.au"
When I click on "Job Details"
And I click on "Mark as Completed"
Then I see "Job marked as Completed" is "visible"

@SmokeTest
Scenario: Check whether the review option appears
Given I open "https://tradehub.com.au"
When I click on "Job Details"
Then I see "Review" is "visible"

@SmokeTest
Scenario: Leave a review
Given I open "https://tradehub.com.au"
When I click on "Job Details"
And I click on "Review"
And I enter "Great job!" in "Feedback"
Then I see "Feedback" is "visible"

@SmokeTest
Scenario: Submit a rating
Given I open "https://tradehub.com.au"
When I click on "Job Details"
And I click on "Review"
And I select "5" as "Rating"
Then I see "Rating" is "selected"

@SmokeTest
Scenario: Add written feedback
Given I open "https://tradehub.com.au"
When I click on "Job Details"
And I click on "Review"
And I enter "Great service, thank you!" in "Written Feedback"
Then I see "Written Feedback" is "visible"

@SmokeTest
Scenario: Confirm the review appears on the appropriate business profile
Given I open "https://tradehub.com.au"
When I click on "Job Details"
And I click on "Review"
And I enter "Great job!" in "Feedback"
And I select "5" as "Rating"
And I click on "Submit"
Then I see "Review" is "visible" on the business profile

@SmokeTest
Scenario: Test the ability to respond to a review if available
Given I open "https://tradehub.com.au"
When I click on "Job Details"
And I click on "Review"
And I enter "Great job!" in "Feedback"
And I select "5" as "Rating"
And I click on "Submit"
And I click on "Respond to Review"
And I enter "Thank you for your positive feedback!" in "Response"
Then I see "Response" is "visible" on the review

@SmokeTest
Scenario: Check the Reliability Review process associated with late cancellations if applicable
Given I open "https://tradehub.com.au"
When I click on "Job Details"
And I click on "Cancel Job"
And I select "Late Cancellation" as "Reason"
And I click on "Submit"
Then I see "Reliability Review" is "visible"
