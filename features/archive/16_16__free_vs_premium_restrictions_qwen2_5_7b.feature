Feature: Free vs Premium Restrictions

@SmokeTest
Scenario: Check Free account 15 km radius restriction
    Given I am logged in as a Free account
    When I browse for tenders
    Then I see "15 km" is selected as Radius

@SmokeTest
Scenario: Check Free account tender browsing
    Given I am logged in as a Free account
    When I browse for tenders
    Then I see a list of tenders within 15 km

@SmokeTest
Scenario: Check Free account free tender posting allowance
    Given I am logged in as a Free account
    When I attempt to post a tender
    Then I see a message "Free users are limited to 10 free tenders per month"

@SmokeTest
Scenario: Check Free account tender quote allowance
    Given I am logged in as a Free account
    When I attempt to quote on a tender
    Then I see a message "Free users are limited to 5 free quotes per month"

@SmokeTest
Scenario: Check Free account quote limits
    Given I am logged in as a Free account
    When I attempt to send more than 5 quotes
    Then I see a message "You have reached your free quote limit for this month"

@SmokeTest
Scenario: Check Free account in-app notifications
    Given I am logged in as a Free account
    When I receive a notification
    Then I see a message "You have reached your free notification limit for this month"

@SmokeTest
Scenario: Check Free account jobs access
    Given I am logged in as a Free account
    When I browse for jobs
    Then I see a list of jobs within 15 km

@SmokeTest
Scenario: Check Free account directory access
    Given I am logged in as a Free account
    When I browse the directory
    Then I see a list of companies within 15 km

@SmokeTest
Scenario: Check Premium account unlimited radius
    Given I am logged in as a Premium account
    When I browse for tenders
    Then I see a message "Unlimited radius"

@SmokeTest
Scenario: Check Premium account unlimited jobs
    Given I am logged in as a Premium account
    When I browse for jobs
    Then I see a message "Unlimited jobs"

@SmokeTest
Scenario: Check Premium account unlimited tender access
    Given I am logged in as a Premium account
    When I browse for tenders
    Then I see a list of all tenders

@SmokeTest
Scenario: Check Premium account unlimited tender quotes
    Given I am logged in as a Premium account
    When I attempt to quote on a tender
    Then I see a message "Unlimited quotes"

@SmokeTest
Scenario: Check Premium account unlimited tender posting
    Given I am logged in as a Premium account
    When I attempt to post a tender
    Then I see a message "Unlimited tenders"

@SmokeTest
Scenario: Check Premium account availability broadcasts
    Given I am logged in as a Premium account
    When I browse for tenders
    Then I see a message "Unlimited availability broadcasts"

@SmokeTest
Scenario: Check Premium account SMS/email alerts where applicable
    Given I am logged in as a Premium account
    When I receive an SMS or email alert
    Then I see the alert message

@SmokeTest
Scenario: Check Premium account premium/verified badge functionality
    Given I am logged in as a Premium account
    When I view my profile
    Then I see a "Premium" badge

@SmokeTest
Scenario: Check Premium account market rate information where available
    Given I am logged in as a Premium account
    When I browse for tenders
    Then I see market rate information for tenders

@SmokeTest
Scenario: Confirm Premium users are not accidentally shown Free restrictions
    Given I am logged in as a Premium account
    When I browse for tenders
    Then I do not see "15 km" is selected as Radius
