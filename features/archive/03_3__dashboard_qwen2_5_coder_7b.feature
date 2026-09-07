Feature: Dashboard

  @SmokeTest
  Scenario: Verify Name/Business Information Displays Correctly
    Given I open "https://tradehub.com.au"
    Then I see "Name/Business Information" is "Displayed Correctly"

  @SmokeTest
  Scenario: Verify Date/Day Display
    Given I open "https://tradehub.com.au"
    Then I see "Date/Day" is "Correct"

  @SmokeTest
  Scenario: Verify Profile Information/Card
    Given I open "https://tradehub.com.au"
    Then I see "Profile Information/Card" is "Displayed"

  @SmokeTest
  Scenario: Verify Profile Public/Private Controls
    Given I open "https://tradehub.com.au"
    Then I see "Profile Public/Private Controls" is "Functional"

  @SmokeTest
  Scenario: Verify ABN Verification Status Area
    Given I open "https://tradehub.com.au"
    Then I see "ABN Verification Status Area" is "Displayed"

  @SmokeTest
  Scenario: Verify Profile Views Statistic
    Given I open "https://tradehub.com.au"
    Then I see "Profile Views Statistic" is "Correct"

  @SmokeTest
  Scenario: Verify Open Jobs in Your Area
    Given I open "https://tradehub.com.au"
    Then I see "Open Jobs in Your Area" is "Displayed"

  @SmokeTest
  Scenario: Verify Unread Message Count
    Given I open "https://tradehub.com.au"
    Then I see "Unread Message Count" is "Correct"

  @SmokeTest
  Scenario: Verify Recent Listings
    Given I open "https://tradehub.com.au"
    Then I see "Recent Listings" is "Displayed"

  @SmokeTest
  Scenario: Click Each Dashboard Link
    Given I open "https://tradehub.com.au"
    When I click on "Dashboard Link"
    Then I see "Correct Page" is "Displayed"

  @SmokeTest
  Scenario: Confirm Each Link Takes You to the Correct Page
    Given I open "https://tradehub.com.au"
    When I click on "Dashboard Link"
    Then I see "Correct Page" is "Displayed"

  @SmokeTest
  Scenario: Verify for Missing Information
    Given I open "https://tradehub.com.au"
    Then I do not see "Missing Information"

  @SmokeTest
  Scenario: Verify for Incorrect Counts
    Given I open "https://tradehub.com.au"
    Then I see "Correct Counts"

  @SmokeTest
  Scenario: Verify for Overlapping Text
    Given I open "https://tradehub.com.au"
    Then I do not see "Overlapping Text"

  @SmokeTest
  Scenario: Verify for Empty Areas
    Given I open "https://tradehub.com.au"
    Then I do not see "Empty Areas"

  @SmokeTest
  Scenario: Verify for Buttons that Cannot be Clicked
    Given I open "https://tradehub.com.au"
    Then I see "All Buttons" are "Clickable"

  @SmokeTest
  Scenario: Verify for Incorrect Mobile Layouts
    Given I open "https://tradehub.com.au"
    Then I see "Mobile Layout" is "Correct"

  @SmokeTest
  Scenario: Verify for Information that Does Not Update After Actions are Completed
    Given I open "https://tradehub.com.au"
    When I perform "Action"
    Then I see "Information" is "Updated"
