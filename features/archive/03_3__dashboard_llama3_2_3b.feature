Feature: Dashboard

  Scenario Outline: Dashboard Display
    Given I am on the dashboard page
    When I see my name/business information
    Then I see it is displayed correctly

  Scenario Outline: Date/Day Display
    Given I am on the dashboard page
    When I see the date/day
    Then I see it is displayed correctly

  Scenario Outline: Profile Information/Card
    Given I am on the dashboard page
    When I see my profile information
    Then I see it is displayed correctly

  Scenario Outline: Profile Public/Private Controls
    Given I am on the dashboard page
    When I see the profile public/private controls
    Then I see them are displayed correctly

  Scenario Outline: ABN Verification Status Area
    Given I am on the dashboard page
    When I see the ABN verification status area
    Then I see it is displayed correctly

  Scenario Outline: Profile Views Statistic
    Given I am on the dashboard page
    When I see the profile views statistic
    Then I see it is displayed correctly

  Scenario Outline: Open Jobs in My Area
    Given I am on the dashboard page
    When I see the open jobs in my area
    Then I see them are displayed correctly

  Scenario Outline: Unread Message Count
    Given I am on the dashboard page
    When I see the unread message count
    Then I see it is displayed correctly

  Scenario Outline: Recent Listings
    Given I am on the dashboard page
    When I see the recent listings
    Then I see them are displayed correctly

  Scenario Outline: Clicking on Dashboard Links
    Given I am on the dashboard page
    When I click on a dashboard link
    Then I am taken to the correct page

  Scenario Outline: Confirming Link Clicks
    Given I am on the dashboard page
    When I click on a dashboard link
    Then I see the correct page title

  Scenario Outline: Checking for Missing Information
    Given I am on the dashboard page
    When I do not see missing information
    Then I do not see it

  Scenario Outline: Checking for Incorrect Counts
    Given I am on the dashboard page
    When I see incorrect counts
    Then I see the correct counts

  Scenario Outline: Checking for Overlapping Text
    Given I am on the dashboard page
    When I see overlapping text
    Then I see it is displayed correctly

  Scenario Outline: Checking for Empty Areas
    Given I am on the dashboard page
    When I see empty areas
    Then I see them are displayed correctly

  Scenario Outline: Checking for Buttons that Cannot be Clicked
    Given I am on the dashboard page
    When I see buttons that cannot be clicked
    Then I see the correct error message

  Scenario Outline: Checking for Incorrect Mobile Layouts
    Given I am on the dashboard page
    When I see incorrect mobile layouts
    Then I see the correct mobile layout

  Scenario Outline: Checking for Information that Does Not Update
    Given I am on the dashboard page
    When I perform an action
    Then the information updates correctly
