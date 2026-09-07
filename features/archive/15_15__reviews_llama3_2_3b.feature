Feature: Reviews

Scenario Outline: Review Section
Given I am on the TradeHub website
When I click on the Reviews tab
Then I see the review option appears

Scenario Outline: Leave a Review
Given I am on the TradeHub website
When I click on the Reviews tab
And I click on the Leave a Review button
Then I see the leave a review form appears

Scenario Outline: Submit a Rating
Given I am on the TradeHub website
When I click on the Reviews tab
And I click on the Submit a Rating button
Then I see the rating options appear

Scenario Outline: Add Written Feedback
Given I am on the TradeHub website
When I click on the Reviews tab
And I click on the Add Written Feedback button
Then I see the written feedback field appears

Scenario Outline: Confirm Review Appears
Given I am on the TradeHub website
When I click on the Reviews tab
And I click on the Leave a Review button
And I enter some written feedback
And I click on the Submit button
Then I see the review appears on the appropriate business profile

Scenario Outline: Respond to a Review
Given I am on the TradeHub website
When I click on the Reviews tab
And I click on the Leave a Review button
And I enter some written feedback
And I click on the Submit button
And I click on the Respond to Review button
Then I see the response field appears

Scenario Outline: Reliability Review Process for Late Cancellations
Given I am on the TradeHub website
When I click on the Reviews tab
And I click on the Leave a Review button
And I select the late cancellation reason
And I click on the Submit button
Then I see the reliability review process appears
