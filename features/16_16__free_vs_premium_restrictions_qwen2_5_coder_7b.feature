Feature: Free vs Premium Restrictions

  @SmokeTest
  Scenario: Check Free account 15 km radius restriction
    Given I open "https://tradehub.com.au"
    When I click on "Free Account"
    Then I see "15 km radius restriction" is "enabled"

  @SmokeTest
  Scenario: Check Free account tender browsing
    Given I open "https://tradehub.com.au"
    When I click on "Free Account"
    Then I see "tender browsing" is "enabled"

  @SmokeTest
  Scenario: Check Free account free tender posting allowance
    Given I open "https://tradehub.com.au"
    When I click on "Free Account"
    Then I see "free tender posting allowance" is "enabled"

  @SmokeTest
  Scenario: Check Free account tender quote allowance
    Given I open "https://tradehub.com.au"
    When I click on "Free Account"
    Then I see "tender quote allowance" is "enabled"

  @SmokeTest
  Scenario: Check Free account quote limits
    Given I open "https://tradehub.com.au"
    When I click on "Free Account"
    Then I see "quote limits" is "enabled"

  @SmokeTest
  Scenario: Check Free account in-app notifications
    Given I open "https://tradehub.com.au"
    When I click on "Free Account"
    Then I see "in-app notifications" is "enabled"

  @SmokeTest
  Scenario: Check Free account jobs access
    Given I open "https://tradehub.com.au"
    When I click on "Free Account"
    Then I see "jobs access" is "enabled"

  @SmokeTest
  Scenario: Check Free account directory access
    Given I open "https://tradehub.com.au"
    When I click on "Free Account"
    Then I see "directory access" is "enabled"

  @SmokeTest
  Scenario: Check Premium account unlimited radius
    Given I open "https://tradehub.com.au"
    When I click on "Premium Account"
    Then I see "unlimited radius" is "enabled"

  @SmokeTest
  Scenario: Check Premium account unlimited jobs
    Given I open "https://tradehub.com.au"
    When I click on "Premium Account"
    Then I see "unlimited jobs" is "enabled"

  @SmokeTest
  Scenario: Check Premium account unlimited tender access
    Given I open "https://tradehub.com.au"
    When I click on "Premium Account"
    Then I see "unlimited tender access" is "enabled"

  @SmokeTest
  Scenario: Check Premium account unlimited tender quotes
    Given I open "https://tradehub.com.au"
    When I click on "Premium Account"
    Then I see "unlimited tender quotes" is "enabled"

  @SmokeTest
  Scenario: Check Premium account unlimited tender posting
    Given I open "https://tradehub.com.au"
    When I click on "Premium Account"
    Then I see "unlimited tender posting" is "enabled"

  @SmokeTest
  Scenario: Check Premium account availability broadcasts
    Given I open "https://tradehub.com.au"
    When I click on "Premium Account"
    Then I see "availability broadcasts" is "enabled"

  @SmokeTest
  Scenario: Check Premium account SMS/email alerts where applicable
    Given I open "https://tradehub.com.au"
    When I click on "Premium Account"
    Then I see "SMS/email alerts" is "enabled"

  @SmokeTest
  Scenario: Check Premium account premium/verified badge functionality
    Given I open "https://tradehub.com.au"
    When I click on "Premium Account"
    Then I see "premium/verified badge functionality" is "enabled"

  @SmokeTest
  Scenario: Check Premium account market rate information where available
    Given I open "https://tradehub.com.au"
    When I click on "Premium Account"
    Then I see "market rate information" is "enabled"

  @SmokeTest
  Scenario: Confirm Premium users are not accidentally shown Free restrictions
    Given I open "https://tradehub.com.au"
    When I click on "Premium Account"
    Then I do not see "Free restrictions" is "enabled"
