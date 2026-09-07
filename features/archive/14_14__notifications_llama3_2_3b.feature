Feature: Notifications

Scenario Outline: Generate activities between two accounts

@SmokeTest
Given I am logged in to TradeHub
When I generate a job application activity between two accounts
Then I should see a notification with the correct wording
And the notification should take me to the correct item

@SmokeTest
Given I am logged in to TradeHub
When I generate a selection activity between two accounts
Then I should see a notification with the correct wording
And the notification should take me to the correct item

@SmokeTest
Given I am logged in to TradeHub
When I generate an acceptance activity between two accounts
Then I should see a notification with the correct wording
And the notification should take me to the correct item

@SmokeTest
Given I am logged in to TradeHub
When I generate a tender quote activity between two accounts
Then I should see a notification with the correct wording
And the notification should take me to the correct item

@SmokeTest
Given I am logged in to TradeHub
When I generate a message activity between two accounts
Then I should see a notification with the correct wording
And the notification should take me to the correct item

@SmokeTest
Given I am logged in to TradeHub
When I generate an availability activity between two accounts
Then I should see a notification with the correct wording
And the notification should take me to the correct item

Scenario Outline: Check notifications appear

@SmokeTest
Given I am logged in to TradeHub
When I generate a notification
Then I should see a notification

@SmokeTest
Given I am logged in to TradeHub
When I generate multiple notifications
Then I should see multiple notifications

Scenario Outline: Check if notification wording makes sense

@SmokeTest
Given I am logged in to TradeHub
When I generate a notification with correct wording
Then I should see the correct wording in the notification

@SmokeTest
Given I am logged in to TradeHub
When I generate a notification with incorrect wording
Then I should not see the correct wording in the notification

Scenario Outline: Check if clicking the notification takes you to the correct item

@SmokeTest
Given I am logged in to TradeHub
When I click on a notification
Then I should be taken to the correct item

@SmokeTest
Given I am logged in to TradeHub
When I click on multiple notifications
Then I should be taken to the correct item for each notification

Scenario Outline: Check if read/unread behaviour works

@SmokeTest
Given I am logged in to TradeHub
When I generate a notification
Then I should see the correct read/unread status

@SmokeTest
Given I am logged in to TradeHub
When I mark a notification as read
Then I should see the correct read/unread status

Scenario Outline: Check if notification counts update

@SmokeTest
Given I am logged in to TradeHub
When I generate multiple notifications
Then I should see the correct notification count

@SmokeTest
Given I am logged in to TradeHub
When I generate a new notification
Then I should see the updated notification count

Scenario Outline: Check if old notifications remain accessible

@SmokeTest
Given I am logged in to TradeHub
When I generate an old notification
Then I should be able to view the old notification
