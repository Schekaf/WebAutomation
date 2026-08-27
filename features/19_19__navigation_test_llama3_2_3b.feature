Feature: Navigation Test

Scenario Outline: Test link for Dashboard
Given I am on the TradeHub homepage
When I click on the Dashboard link
Then I should see the Dashboard page

Scenario Outline: Test link for Jobs
Given I am on the TradeHub homepage
When I click on the Jobs link
Then I should see the Jobs page

Scenario Outline: Test link for Find Jobs
Given I am on the TradeHub homepage
When I click on the Find Jobs link
Then I should see the Find Jobs page

Scenario Outline: Test link for Post a Job
Given I am on the TradeHub homepage
When I click on the Post a Job link
Then I should see the Post a Job page

Scenario Outline: Test link for Tenders
Given I am on the TradeHub homepage
When I click on the Tenders link
Then I should see the Tenders page

Scenario Outline: Test link for Post Project Tender
Given I am on the TradeHub homepage
When I click on the Post Project Tender link
Then I should see the Post Project Tender page

Scenario Outline: Test link for Directory
Given I am on the TradeHub homepage
When I click on the Directory link
Then I should see the Directory page

Scenario Outline: Test link for Profile
Given I am on the TradeHub homepage
When I click on the Profile link
Then I should see the Profile page

Scenario Outline: Test link for Messages
Given I am on the TradeHub homepage
When I click on the Messages link
Then I should see the Messages page

Scenario Outline: Test link for Notifications
Given I am on the TradeHub homepage
When I click on the Notifications link
Then I should see the Notifications page

Scenario Outline: Test link for Availability
Given I am on the TradeHub homepage
When I click on the Availability link
Then I should see the Availability page

Scenario Outline: Test link for Upgrade/Premium
Given I am on the TradeHub homepage
When I click on the Upgrade/Premium link
Then I should see the Upgrade/Premium page

Scenario Outline: Test link for Logout
Given I am on the TradeHub homepage
When I click on the Logout link
Then I should be logged out
