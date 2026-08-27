Feature: Reviews

@SmokeTest
Scenario: Mark the job Completed
    Given I open "https://tradehub.com.au"
    When I click on "Job Details"
    And I click on "Mark as Completed"
    Then I see "Job marked as Completed" is displayed

@SmokeTest
Scenario: Check whether the review option appears
    Given I open "https://tradehub.com.au"
    When I click on "Job Details"
    Then I see "Review" option is displayed

@PositiveTesting
Scenario: Leave a review
    Given I open "https://tradehub.com.au"
    When I click on "Job Details"
    And I click on "Review"
    And I enter "5" in "Rating"
    And I enter "Great job!" in "Feedback"
    And I click on "Submit Review"
    Then I see "Review submitted successfully" is displayed

@PositiveTesting
Scenario: Submit a rating
    Given I open "https://tradehub.com.au"
    When I click on "Job Details"
    And I click on "Review"
    And I enter "5" in "Rating"
    And I click on "Submit Review"
    Then I see "Rating submitted successfully" is displayed

@PositiveTesting
Scenario: Add written feedback
    Given I open "https://tradehub.com.au"
    When I click on "Job Details"
    And I click on "Review"
    And I enter "Great job!" in "Feedback"
    And I click on "Submit Review"
    Then I see "Feedback submitted successfully" is displayed

@PositiveTesting
Scenario: Confirm the review appears on the appropriate business profile
    Given I open "https://tradehub.com.au"
    When I click on "Job Details"
    And I click on "Review"
    And I enter "5" in "Rating"
    And I enter "Great job!" in "Feedback"
    And I click on "Submit Review"
    Then I see "Review" is displayed on the business profile

@PositiveTesting
Scenario: Test the ability to respond to a review if available
    Given I open "https://tradehub.com.au"
    When I click on "Job Details"
    And I click on "Review"
    And I enter "5" in "Rating"
    And I enter "Great job!" in "Feedback"
    And I click on "Submit Review"
    And I click on "Respond to Review"
    And I enter "Thank you for the review!" in "Response"
    And I click on "Submit Response"
    Then I see "Response submitted successfully" is displayed

@NegativeTesting
Scenario: Check the Reliability Review process associated with late cancellations if applicable
    Given I open "https://tradehub.com.au"
    When I click on "Job Details"
    And I click on "Cancel Job"
    And I enter "I need to cancel this job" in "Reason"
    And I click on "Submit Cancellation"
    Then I see "Reliability Review process initiated" is displayed
