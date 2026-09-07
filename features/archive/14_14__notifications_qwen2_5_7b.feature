Feature: Notifications

Scenario: Generate activities between two accounts
Given I am logged into the TradeHub system as Account A
When I apply for a job listing from Account B
Then I see a notification is generated for Account B
And I see the notification wording makes sense
And clicking the notification takes me to the job listing details
And the notification count updates
And old notifications remain accessible

Scenario: Generate activities between two accounts
Given I am logged into the TradeHub system as Account A
When I select a job listing from Account B for a tender quote
Then I see a notification is generated for Account B
And I see the notification wording makes sense
And clicking the notification takes me to the tender quote details
And the notification count updates
And old notifications remain accessible

Scenario: Generate activities between two accounts
Given I am logged into the TradeHub system as Account A
When I accept a job application from Account B
Then I see a notification is generated for Account B
And I see the notification wording makes sense
And clicking the notification takes me to the job application details
And the notification count updates
And old notifications remain accessible

Scenario: Generate activities between two accounts
Given I am logged into the TradeHub system as Account A
When I accept a job selection from Account B
Then I see a notification is generated for Account B
And I see the notification wording makes sense
And clicking the notification takes me to the job selection details
And the notification count updates
And old notifications remain accessible

Scenario: Generate activities between two accounts
Given I am logged into the TradeHub system as Account A
When I send a message to Account B
Then I see a notification is generated for Account B
And I see the notification wording makes sense
And clicking the notification takes me to the message details
And the notification count updates
And old notifications remain accessible

Scenario: Generate activities between two accounts
Given I am logged into the TradeHub system as Account A
When I mark my availability for a job listing from Account B
Then I see a notification is generated for Account B
And I see the notification wording makes sense
And clicking the notification takes me to the job listing details
And the notification count updates
And old notifications remain accessible
