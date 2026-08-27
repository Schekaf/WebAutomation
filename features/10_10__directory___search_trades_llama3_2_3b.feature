Feature: Directory / Search Trades

Scenario Outline: Open Directory
Given I am on the TradeHub homepage
When I click on the Directory tab
Then I see the Directory page

Scenario Outline: Search for a trade
Given I am on the Directory page
When I search for a trade using the search bar
Then I see the search results

Scenario Outline: Search by suburb/location
Given I am on the Directory page
When I search for a trade by suburb/location using the search bar
Then I see the search results

Scenario Outline: Change distance/radius
Given I am on the Directory page
When I change the distance/radius using the dropdown menu
Then I see the updated search results

Scenario Outline: Test available-date filtering
Given I am on the Directory page
When I select a date range using the available-date filter
Then I see the search results filtered by the selected dates

Scenario Outline: Open several profiles
Given I am on the Directory page
When I click on the profile of a business
Then I am taken to the business profile page

Scenario Outline: Check rates
Given I am on the business profile page
When I click on the rates tab
Then I see the rates information

Scenario Outline: Check reviews
Given I am on the business profile page
When I click on the reviews tab
Then I see the reviews information

Scenario Outline: Check available dates
Given I am on the business profile page
When I click on the available dates tab
Then I see the available dates information

Scenario Outline: Check profile descriptions
Given I am on the business profile page
When I click on the profile description tab
Then I see the profile description

Scenario Outline: Contact/message a business
Given I am on the business profile page
When I click on the contact/message button
Then I am taken to the contact form

Scenario Outline: Confirm that the results make sense based on the filters selected
Given I am on the Directory page
When I apply multiple filters (e.g. suburb, distance, date range)
Then I see the search results that match the filters

Scenario Outline: Check the Free account radius restrictions if applicable
Given I am on the Directory page
When I am logged in as a free user
Then I see the radius restrictions for free users
