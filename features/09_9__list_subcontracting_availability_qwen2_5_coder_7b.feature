Feature: List Subcontracting Availability

@SmokeTest
Scenario: List Subcontracting Dates / Availability
    Given I open "https://tradehub.com.au"
    When I click on "List Subcontracting Dates / Availability"
    Then I see "Select future dates" is "enabled"

@PositiveTesting
Scenario: Add and Save Subcontracting Availability
    Given I click on "List Subcontracting Dates / Availability"
    When I select future dates
    And I enter "Description for availability"
    And I enter "10" in "Number of workers available"
    And I enter "100" in "Rate per day"
    And I click on "Save the availability"
    Then I see "Availability saved successfully"

@PositiveTesting
Scenario: Confirm Dates Appear on Account
    Given I click on "List Subcontracting Dates / Availability"
    When I refresh the page
    Then I see the selected dates appear on my account

@PositiveTesting
Scenario: Edit and Remove Subcontracting Availability
    Given I click on "List Subcontracting Dates / Availability"
    When I edit the description
    And I remove one available date
    And I add another available date
    And I click on "Save the availability"
    Then I see the updated availability listing

@NegativeTesting
Scenario: Delete/Cancel Availability Listing
    Given I click on "List Subcontracting Dates / Availability"
    When I click on "Delete/cancel an availability listing"
    Then I see "Availability listing deleted successfully"

@PositiveTesting
Scenario: Search Directory Using Another Account
    Given I open "https://tradehub.com.au"
    When I click on "Search Directory"
    And I enter another account credentials
    And I click on "Login"
    Then I see the test business appears

@PositiveTesting
Scenario: Enable "Show only profiles with upcoming available dates"
    Given I click on "List Subcontracting Dates / Availability"
    When I click on "Enable 'Show only profiles with upcoming available dates'"
    Then I see the test business with available dates appears

@PositiveTesting
Scenario: Confirm Available Dates are Correct
    Given I click on "List Subcontracting Dates / Availability"
    When I click on "Show only profiles with upcoming available dates"
    Then I see the available dates are correct
