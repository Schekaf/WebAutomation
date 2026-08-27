Feature: List Subcontracting Availability

Scenario: Go to List Subcontracting Dates / Availability
  Given I am logged into the TradeHub account
  When I click on "List Subcontracting Dates / Availability"
  Then I see "List Subcontracting Dates / Availability" page

Scenario: Select future dates
  Given I am on the "List Subcontracting Dates / Availability" page
  When I click on "Select future dates"
  Then I see a calendar picker

Scenario: Add a description
  Given I am on the "List Subcontracting Dates / Availability" page
  When I enter "Available from next month" in "Description" field
  Then I see "Available from next month" in the "Description" field

Scenario: Enter the number/type of workers available if applicable
  Given I am on the "List Subcontracting Dates / Availability" page
  When I enter "5" in "Number of Workers" field
  Then I see "5" in the "Number of Workers" field

Scenario: Enter your rate if applicable
  Given I am on the "List Subcontracting Dates / Availability" page
  When I enter "50" in "Rate" field
  Then I see "50" in the "Rate" field

Scenario: Save the availability
  Given I am on the "List Subcontracting Dates / Availability" page
  When I click on "Save" button
  Then I see a confirmation message "Availability saved successfully"

Scenario: Confirm the dates appear on your account
  Given I am on the "List Subcontracting Dates / Availability" page
  When I refresh the page
  Then I see the saved availability dates

Scenario: Edit the dates
  Given I am on the "List Subcontracting Dates / Availability" page
  When I click on "Edit" button
  Then I see the "Edit" form

Scenario: Edit the description
  Given I am on the "List Subcontracting Dates / Availability" page
  When I click on "Edit" button
  Then I see the "Description" field with "Available from next month"

Scenario: Remove one available date
  Given I am on the "List Subcontracting Dates / Availability" page
  When I click on "Remove" button for one date
  Then I do not see the removed date

Scenario: Add another available date
  Given I am on the "List Subcontracting Dates / Availability" page
  When I click on "Add Date" button
  Then I see a new date field

Scenario: Delete/cancel an availability listing if possible
  Given I am on the "List Subcontracting Dates / Availability" page
  When I click on "Delete" button
  Then I see a confirmation message "Are you sure you want to delete this availability?"

Scenario: Search the Directory using another account
  Given I am on the "List Subcontracting Dates / Availability" page
  When I click on "Search Directory" button
  Then I see the search results page

Scenario: Enable "Show only profiles with upcoming available dates"
  Given I am on the "List Subcontracting Dates / Availability" page
  When I select "Show only profiles with upcoming available dates" checkbox
  Then I see the "Available Soon" indicator

Scenario: Confirm the test business appears
  Given I am on the "List Subcontracting Dates / Availability" page
  When I enable "Show only profiles with upcoming available dates"
  Then I see the test business in the search results

Scenario: Confirm the "Available Soon" indicator appears correctly
  Given I am on the "List Subcontracting Dates / Availability" page
  When I enable "Show only profiles with upcoming available dates"
  Then I see the "Available Soon" indicator for the test business

Scenario: Confirm the available dates are correct
  Given I am on the "List Subcontracting Dates / Availability" page
  When I enable "Show only profiles with upcoming available dates"
  Then I see the correct available dates for the test business
