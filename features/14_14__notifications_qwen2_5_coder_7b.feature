Feature: Notifications

Scenario: Generate activities between two accounts
    Given I am logged in as "Account A"
    When I apply for a job from "Account B"
    Then I should see a notification for the job application

Scenario: Check that notifications appear
    Given I am logged in as "Account A"
    When I receive a notification
    Then I should see the notification in the notifications list

Scenario: Check if notification wording makes sense
    Given I am logged in as "Account A"
    When I receive a notification
    Then the notification wording should be clear and understandable

Scenario: Check if clicking the notification takes you to the correct item
    Given I am logged in as "Account A"
    When I click on a notification
    Then I should be redirected to the correct item

Scenario: Check if read/unread behaviour works
    Given I am logged in as "Account A"
    When I mark a notification as read
    Then the notification should be marked as read in the list

Scenario: Check if notification counts update
    Given I am logged in as "Account A"
    When I receive a new notification
    Then the notification count should update

Scenario: Check if old notifications remain accessible
    Given I am logged in as "Account A"
    When I receive multiple notifications
    Then I should be able to access all old notifications
