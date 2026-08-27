Feature: ABN / Business Verification

Scenario: Browse jobs without an ABN
Given I am on the TradeHub homepage
When I click on "Jobs" in the navigation menu
Then I see "Please enter your ABN to continue" message

Scenario: Browse tenders without an ABN
Given I am on the TradeHub homepage
When I click on "Tenders" in the navigation menu
Then I see "Please enter your ABN to continue" message

Scenario: Browse the Directory without an ABN
Given I am on the TradeHub homepage
When I click on "Directory" in the navigation menu
Then I see "Please enter your ABN to continue" message

Scenario: Post a job without an ABN and verify system requests ABN
Given I am on the TradeHub homepage
When I click on "Post a Job" in the navigation menu
Then I see "Please enter your ABN to continue" message

Scenario: Apply/quote for a job where applicable without an ABN and verify system requests ABN
Given I am on the TradeHub homepage
When I click on "Jobs" in the navigation menu
And I select a job
Then I see "Please enter your ABN to continue" message

Scenario: Post a tender without an ABN and verify system requests ABN
Given I am on the TradeHub homepage
When I click on "Post a Tender" in the navigation menu
Then I see "Please enter your ABN to continue" message

Scenario: Quote on a tender without an ABN and verify system requests ABN
Given I am on the TradeHub homepage
When I click on "Tenders" in the navigation menu
And I select a tender
Then I see "Please enter your ABN to continue" message

Scenario: List subcontracting availability without an ABN and verify system requests ABN
Given I am on the TradeHub homepage
When I click on "Subcontracting" in the navigation menu
Then I see "Please enter your ABN to continue" message

Scenario: Enter an ABN
Given I am on the TradeHub homepage
When I enter "1234567890" in "ABN" field
Then I see "ABN entered successfully" message

Scenario: Save it
Given I have entered an ABN
When I click on "Save" button
Then I see "ABN saved successfully" message

Scenario: Confirm the ABN is attached to the account
Given I have saved an ABN
When I log out and log back in
Then I see the saved ABN in my account details

Scenario: Repeat an action that was previously restricted
Given I have saved an ABN
When I click on "Jobs" in the navigation menu
Then I do not see "Please enter your ABN to continue" message

Scenario: Confirm you can now continue
Given I have saved an ABN
When I click on "Jobs" in the navigation menu
Then I see the job listing page
