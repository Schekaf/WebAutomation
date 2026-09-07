Feature: Free vs Premium Restrictions

Scenario Outline: Check Free account 15 km radius restriction
  Given I am logged in as a free user
  When I try to view a tender within a 15 km radius
  Then I should see a message indicating that I am not allowed to view tenders within this radius

Scenario Outline: Check Free account tender browsing
  Given I am logged in as a free user
  When I try to view a tender
  Then I should see a message indicating that I do not have access to view tenders

Scenario Outline: Check Free account free tender posting allowance
  Given I am logged in as a free user
  When I try to post a tender
  Then I should see a message indicating that I do not have enough allowance to post a tender

Scenario Outline: Check Free account tender quote allowance
  Given I am logged in as a free user
  When I try to quote on a tender
  Then I should see a message indicating that I do not have enough allowance to quote on a tender

Scenario Outline: Check Free account quote limits
  Given I am logged in as a free user
  When I try to quote on multiple tenders
  Then I should see a message indicating that I have reached my quote limit

Scenario Outline: Check Free account in-app notifications
  Given I am logged in as a free user
  When I receive an in-app notification
  Then I should see the notification in the app

Scenario Outline: Check Free account jobs access
  Given I am logged in as a free user
  When I try to view a job
  Then I should see a message indicating that I do not have access to view jobs

Scenario Outline: Check Free account directory access
  Given I am logged in as a free user
  When I try to view a directory entry
  Then I should see a message indicating that I do not have access to view directory entries

Scenario Outline: Check Premium account unlimited radius
  Given I am logged in as a premium user
  When I try to view a tender within a 15 km radius
  Then I should be able to view the tender

Scenario Outline: Check Premium account unlimited jobs
  Given I am logged in as a premium user
  When I try to view a job
  Then I should be able to view the job

Scenario Outline: Check Premium account unlimited tender access
  Given I am logged in as a premium user
  When I try to view a tender
  Then I should be able to view the tender

Scenario Outline: Check Premium account unlimited tender quotes
  Given I am logged in as a premium user
  When I try to quote on a tender
  Then I should be able to quote on the tender

Scenario Outline: Check Premium account unlimited tender posting
  Given I am logged in as a premium user
  When I try to post a tender
  Then I should be able to post the tender

Scenario Outline: Check Premium account availability broadcasts
  Given I am logged in as a premium user
  When I receive an availability broadcast
  Then I should see the broadcast in the app

Scenario Outline: Check Premium account SMS/email alerts where applicable
  Given I am logged in as a premium user
  When I receive an SMS/email alert
  Then I should receive the alert

Scenario Outline: Check Premium account premium/verified badge functionality
  Given I am logged in as a premium user
  When I view my profile
  Then I should see the premium/verified badge

Scenario Outline: Check Premium account market rate information where available
  Given I am logged in as a premium user
  When I view market rate information
  Then I should see the market rate information

Scenario Outline: Confirm Premium users are not accidentally shown Free restrictions
  Given I am logged in as a premium user
  When I try to view a free tender
  Then I should not see the free restrictions
