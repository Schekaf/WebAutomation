Feature: Create a Project Tender

Scenario Outline: Create a Project Tender

Given I am on the TradeHub login page
When I log in with valid credentials
Then I should be on the dashboard page

Scenario: Enter Project Name

Given I am on the Create Project Tender page
When I enter a project name in the "Project Name" field
Then I should see the project name displayed on the page

Scenario: Enter Project Location

Given I am on the Create Project Tender page
When I enter a project location in the "Project Location" field
Then I should see the project location displayed on the page

Scenario: Enter Project Dates

Given I am on the Create Project Tender page
When I enter project dates in the "Project Dates" field
Then I should see the project dates displayed on the page

Scenario: Add Overall Project Description

Given I am on the Create Project Tender page
When I enter an overall project description in the "Project Description" field
Then I should see the project description displayed on the page

Scenario: Upload Plans

Given I am on the Create Project Tender page
When I upload plans to the "Plans" field
Then I should see the uploaded plans displayed on the page

Scenario: Select Multiple Required Trades

Given I am on the Create Project Tender page
When I select multiple required trades from the "Trades" dropdown
Then I should see the selected trades displayed on the page

Scenario: Enter Separate Description for Each Trade

Given I am on the Create Project Tender page
When I enter a separate description for each trade in the "Trade Description" field
Then I should see the trade descriptions displayed on the page

Scenario: Enter Budget for Each Trade

Given I am on the Create Project Tender page
When I enter a budget for each trade in the "Trade Budget" field
Then I should see the trade budgets displayed on the page

Scenario: Upload Trade-Specific Attachments

Given I am on the Create Project Tender page
When I upload trade-specific attachments to the "Attachments" field
Then I should see the uploaded attachments displayed on the page

Scenario: Test Limited Quotes Option

Given I am on the Create Project Tender page
When I select the "Limited Quotes" option
Then I should see a message indicating that limited quotes are enabled

Scenario: Submit Tender

Given I am on the Create Project Tender page
When I submit the tender
Then I should see a confirmation message indicating that the tender has been submitted

Scenario: Confirm Tender Appears in Account

Given I am on the dashboard page
When I search for the tender in my account
Then I should see the tender displayed in my account

Scenario: Check Approval/Status

Given I am on the dashboard page
When I view the tender details
Then I should see the approval status displayed on the page

Scenario: Open Tender

Given I am on the dashboard page
When I click on the tender to open it
Then I should see the tender details displayed on the page

Scenario: Confirm All Information Displays Correctly

Given I am on the tender details page
When I view the tender details
Then I should see all information displayed correctly on the page

Scenario: Edit Tender

Given I am on the dashboard page
When I click on the tender to edit it
Then I should see the tender details displayed on the page

Scenario: Save Changes

Given I am on the tender details page
When I make changes to the tender
Then I should see the updated tender details displayed on the page

Scenario: Refresh and Verify Changes Remain

Given I am on the dashboard page
When I refresh the page
Then I should see the updated tender details displayed on the page
