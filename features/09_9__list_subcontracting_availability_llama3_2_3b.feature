Feature: List Subcontracting Availability

Scenario Outline: List Subcontracting Dates / Availability
Given I am on the List Subcontracting Dates / Availability page
When I select future dates
Then I should see a list of available dates

Scenario Outline: Add Availability
Given I am on the List Subcontracting Dates / Availability page
When I add a description
Then I should see a description field

Scenario Outline: Enter Number/Type of Workers Available
Given I am on the List Subcontracting Dates / Availability page
When I enter the number/type of workers available
Then I should see the number/type of workers available

Scenario Outline: Enter Rate
Given I am on the List Subcontracting Dates / Availability page
When I enter my rate
Then I should see my rate

Scenario Outline: Save Availability
Given I am on the List Subcontracting Dates / Availability page
When I save the availability
Then I should see the saved availability

Scenario Outline: Confirm Dates
Given I am on the List Subcontracting Dates / Availability page
When I confirm the dates appear on my account
Then I should see the dates on my account

Scenario Outline: Refresh Page
Given I am on the List Subcontracting Dates / Availability page
When I refresh the page
Then I should see the same dates

Scenario Outline: Confirm Saved Dates
Given I am on the List Subcontracting Dates / Availability page
When I confirm the dates remain saved
Then I should see the same dates

Scenario Outline: Edit Dates
Given I am on the List Subcontracting Dates / Availability page
When I edit the dates
Then I should see the edited dates

Scenario Outline: Edit Description
Given I am on the List Subcontracting Dates / Availability page
When I edit the description
Then I should see the edited description

Scenario Outline: Remove Availability
Given I am on the List Subcontracting Dates / Availability page
When I remove one available date
Then I should see one less available date

Scenario Outline: Add Another Availability
Given I am on the List Subcontracting Dates / Availability page
When I add another available date
Then I should see one more available date

Scenario Outline: Delete/Cancel Availability
Given I am on the List Subcontracting Dates / Availability page
When I delete/cancel an availability listing
Then I should see the availability listing deleted/cancelled

Scenario Outline: Search Directory
Given I am on the List Subcontracting Dates / Availability page
When I search the Directory using another account
Then I should see the search results

Scenario Outline: Enable "Show only profiles with upcoming available dates"
Given I am on the List Subcontracting Dates / Availability page
When I enable "Show only profiles with upcoming available dates"
Then I should see the profiles with upcoming available dates

Scenario Outline: Confirm Test Business
Given I am on the List Subcontracting Dates / Availability page
When I confirm the test business appears
Then I should see the test business

Scenario Outline: Confirm "Available Soon" Indicator
Given I am on the List Subcontracting Dates / Availability page
When I confirm the "Available Soon" indicator appears correctly
Then I should see the "Available Soon" indicator

Scenario Outline: Confirm Available Dates
Given I am on the List Subcontracting Dates / Availability page
When I confirm the available dates are correct
Then I should see the correct available dates
