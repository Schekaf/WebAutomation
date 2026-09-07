Feature: Browse and Quote on Tenders

Scenario Outline: Open Available Tenders using a matching trade account

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  When I open available tenders
  Then I should see the tenders list

Scenario Outline: Find the tender created above

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  When I find the tender created above
  Then I should see the tender details

Scenario Outline: Open the tender

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  When I open the tender
  Then I should see the tender details

Scenario Outline: Confirm the relevant trade information is visible

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  When I open the tender
  Then I should see the relevant trade information

Scenario Outline: Submit a quote

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  And I open the tender
  When I submit a quote
  Then I should see the quote submitted

Scenario Outline: Enter a price

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  And I open the tender
  When I submit a quote
  And I enter a price
  Then I should see the price entered

Scenario Outline: Enter a message/description

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  And I open the tender
  When I submit a quote
  And I enter a message/description
  Then I should see the message/description entered

Scenario Outline: Upload supporting information if available

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  And I open the tender
  When I submit a quote
  And I upload supporting information if available
  Then I should see the supporting information uploaded

Scenario Outline: Submit the quote

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  And I open the tender
  And I enter a price
  And I enter a message/description
  And I upload supporting information if available
  When I submit the quote
  Then I should see the quote submitted

Scenario Outline: Confirm submission was successful

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  And I open the tender
  And I enter a price
  And I enter a message/description
  And I upload supporting information if available
  When I submit the quote
  Then I should see the submission successful

Scenario Outline: Open the tender using the account that posted it

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  And I open the tender
  When I open the tender using the account that posted it
  Then I should see the tender details

Scenario Outline: View received quotes

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  And I open the tender
  When I open the tender using the account that posted it
  Then I should see the received quotes

Scenario Outline: Open the test quote

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  And I open the tender
  And I open the tender using the account that posted it
  When I open the test quote
  Then I should see the test quote

Scenario Outline: Check business profile information

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  And I open the tender
  And I open the tender using the account that posted it
  When I open the test quote
  Then I should see the business profile information

Scenario Outline: Check quoted amount

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  And I open the tender
  And I open the tender using the account that posted it
  When I open the test quote
  Then I should see the quoted amount

Scenario Outline: Contact/message the quoting business

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  And I open the tender
  And I open the tender using the account that posted it
  When I open the test quote
  Then I should see the contact/message option

Scenario Outline: Check that businesses with unrelated trades do not incorrectly see restricted trade information where applicable

@SmokeTest
Feature: Browse and Quote on Tenders
  Given I am logged in with a matching trade account
  And I open available tenders
  And I find the tender created above
  And I open the tender
  And I open the tender using the account that posted it
  When I open the test quote
  Then I should not see the restricted trade information
