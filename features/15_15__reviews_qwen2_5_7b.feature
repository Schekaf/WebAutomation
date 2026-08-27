Feature: Reviews

Scenario: Mark the job as completed
    Given I am on the job details page
    When I click on "Mark as Completed"
    Then I see "Job Completed" status is updated

Scenario: Check whether the review option appears
    Given I am on the job details page
    When I scroll down to the reviews section
    Then I see "Leave a review" option is available

Scenario: Leave a review
    Given I am on the job details page
    When I click on "Leave a review"
    And I enter "5" as "Rating"
    And I enter "Great service!" as "Feedback"
    Then I see "Review submitted" message is displayed

Scenario: Submit a rating
    Given I am on the job details page
    When I click on "Leave a review"
    And I enter "4" as "Rating"
    Then I see "Submit" button is enabled

Scenario: Add written feedback
    Given I am on the job details page
    When I click on "Leave a review"
    And I enter "Excellent work!" as "Feedback"
    Then I see "Review submitted" message is displayed

Scenario: Confirm the review appears on the appropriate business profile
    Given I am on the business profile page
    When I scroll down to the reviews section
    Then I see my review with "5" stars and "Great service!" feedback

Scenario: Test the ability to respond to a review if available
    Given I am on the business profile page
    When I click on "Respond to review"
    And I enter "Thank you for your feedback!" as "Response"
    Then I see "Response submitted" message is displayed

Scenario: Check the Reliability Review process associated with late cancellations if applicable
    Given I am on the job details page
    When I click on "Leave a review" due to late cancellation
    And I enter "Late cancellation" as "Reason"
    And I enter "The job was cancelled late, causing inconvenience." as "Feedback"
    Then I see "Review submitted" message is displayed
