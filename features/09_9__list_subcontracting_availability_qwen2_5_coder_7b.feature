Feature: List Subcontracting Availability

@SmokeTest
Scenario: Add and Confirm Subcontracting Availability
  Given I open "https://tradehub.com.au"
  When I click on "List Subcontracting Dates / Availability"
  And I select future dates
  And I enter "Description for availability"
  And I enter "5 workers available"
  And I enter "Rate: $100 per hour"
  And I click on "Save the availability"
  Then I see "Availability saved successfully" is "visible"
  And I refresh the page
  Then I see the saved dates appear on my account

@SmokeTest
Scenario: Edit and Confirm Subcontracting Availability
  Given I open "https://tradehub.com.au"
  When I click on "List Subcontracting Dates / Availability"
  And I select future dates
  And I enter "Description for availability"
  And I enter "5 workers available"
  And I enter "Rate: $100 per hour"
  And I click on "Save the availability"
  And I click on "Edit" for the saved availability
  And I edit the description to "Updated description"
  And I click on "Save the availability"
  Then I see "Availability updated successfully" is "visible"
  And I refresh the page
  Then I see the updated description on my account

@SmokeTest
Scenario: Remove and Confirm Subcontracting Availability
  Given I open "https://tradehub.com.au"
  When I click on "List Subcontracting Dates / Availability"
  And I select future dates
  And I enter "Description for availability"
  And I enter "5 workers available"
  And I enter "Rate: $100 per hour"
  And I click on "Save the availability"
  And I click on "Remove" for the saved availability
  And I confirm the removal
  Then I see "Availability removed successfully" is "visible"
  And I refresh the page
  Then I do not see the removed availability on my account

@SmokeTest
Scenario: Search Directory Using Another Account
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  And I enter another account's credentials
  And I click on "Login"
  Then I see the test business appears
  And I see the "Available Soon" indicator appears correctly
  And I see the available dates are correct
