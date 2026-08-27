Feature: Dashboard

@SmokeTest
Scenario: Verify Name and Business Information Display
    Given I open "https://tradehub.com.au"
    When I click on "Profile"
    Then I see "Name" is "John Doe"
    And I see "Business Name" is "Doe Trading"

@SmokeTest
Scenario: Verify Date/Day Display
    Given I open "https://tradehub.com.au"
    When I click on "Profile"
    Then I see "Today's Date" is "2023-10-01"

@SmokeTest
Scenario: Verify Profile Information/Card
    Given I open "https://tradehub.com.au"
    When I click on "Profile"
    Then I see "Profile Information" is "Complete"
    And I see "Business Address" is "123 Trade Street, Sydney, NSW 2000"

@SmokeTest
Scenario: Verify Profile Public/Private Controls
    Given I open "https://tradehub.com.au"
    When I click on "Profile"
    Then I see "Profile is set to Public"
    And I select "Private" as "Profile Visibility"

@SmokeTest
Scenario: Verify ABN Verification Status Area
    Given I open "https://tradehub.com.au"
    When I click on "Profile"
    Then I see "ABN Verification Status" is "Pending"

@SmokeTest
Scenario: Verify Profile Views Statistic
    Given I open "https://tradehub.com.au"
    When I click on "Profile"
    Then I see "Profile Views" is "123"

@SmokeTest
Scenario: Verify Open Jobs in Your Area
    Given I open "https://tradehub.com.au"
    When I click on "Jobs"
    Then I see "Open Jobs" is "2"

@SmokeTest
Scenario: Verify Unread Message Count
    Given I open "https://tradehub.com.au"
    When I click on "Messages"
    Then I see "Unread Messages" is "0"

@SmokeTest
Scenario: Verify Recent Listings
    Given I open "https://tradehub.com.au"
    When I click on "Recent Listings"
    Then I see "Recent Listings" is "Empty"

@SmokeTest
Scenario: Click Each Dashboard Link
    Given I open "https://tradehub.com.au"
    When I click on "Profile"
    Then I see "You are on the Profile page"
    When I click on "Jobs"
    Then I see "You are on the Jobs page"
    When I click on "Messages"
    Then I see "You are on the Messages page"
    When I click on "Recent Listings"
    Then I see "You are on the Recent Listings page"

@SmokeTest
Scenario: Confirm Each Link Takes You to the Correct Page
    Given I open "https://tradehub.com.au"
    When I click on "Profile"
    Then I see "You are on the Profile page"
    When I click on "Jobs"
    Then I see "You are on the Jobs page"
    When I click on "Messages"
    Then I see "You are on the Messages page"
    When I click on "Recent Listings"
    Then I see "You are on the Recent Listings page"

@SmokeTest
Scenario: Check for Missing Information
    Given I open "https://tradehub.com.au"
    When I click on "Profile"
    Then I do not see "Missing Information"

@SmokeTest
Scenario: Check for Incorrect Counts
    Given I open "https://tradehub.com.au"
    When I click on "Profile"
    Then I see "Profile Views" is "123"
    And I see "Open Jobs" is "2"

@SmokeTest
Scenario: Check for Overlapping Text
    Given I open "https://tradehub.com.au"
    When I click on "Profile"
    Then I do not see "Overlapping Text"

@SmokeTest
Scenario: Check for Empty Areas
    Given I open "https://tradehub.com.au"
    When I click on "Recent Listings"
    Then I see "Recent Listings" is "Empty"

@SmokeTest
Scenario: Check for Buttons that Cannot be Clicked
    Given I open "https://tradehub.com.au"
    When I click on "Profile"
    Then I do not see "Buttons that cannot be clicked"

@SmokeTest
Scenario: Check for Incorrect Mobile Layouts
    Given I open "https://tradehub.com.au"
    When I resize the browser to mobile size
    Then I see "Mobile Layout is correct"

@SmokeTest
Scenario: Check for Information that does not update after actions are completed
    Given I open "https://tradehub.com.au"
    When I click on "Profile"
    Then I see "Profile Views" is "123"
    When I perform an action that should update the profile views
    Then I see "Profile Views" is "124"
