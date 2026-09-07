Feature: Create a Project Tender

Scenario: Create a Project Tender - Positive Flow
@SmokeTest @PositiveTesting
Given I open "Project Tender" page
When I enter "TradeHub Development" as project name
And I enter "Sydney, NSW" as project location
And I enter "01/01/2023 - 31/12/2023" as project dates
And I add "Overall project description" as "This is a development project for TradeHub"
And I upload "Project Plan.pdf" as plans
And I select "Trade 1" and "Trade 2" as required trades
And I enter "Description for Trade 1" as separate description for "Trade 1"
And I enter "10000" as budget for "Trade 1"
And I enter "Description for Trade 2" as separate description for "Trade 2"
And I enter "20000" as budget for "Trade 2"
And I upload "Trade 1 Attachment.pdf" as trade-specific attachment for "Trade 1"
And I upload "Trade 2 Attachment.pdf" as trade-specific attachment for "Trade 2"
And I test "Limited Quotes" option
And I click on "Submit Tender" button
Then I see "Tender created successfully" message
And I see "Tender" in my account
And I see "Pending" as approval/status
And I open "Tender"
And I see "TradeHub Development" as project name
And I see "Sydney, NSW" as project location
And I see "01/01/2023 - 31/12/2023" as project dates
And I see "Overall project description" as "This is a development project for TradeHub"
And I see "Project Plan.pdf" as plans
And I see "Trade 1" and "Trade 2" as required trades
And I see "Description for Trade 1" as separate description for "Trade 1"
And I see "10000" as budget for "Trade 1"
And I see "Description for Trade 2" as separate description for "Trade 2"
And I see "20000" as budget for "Trade 2"
And I see "Trade 1 Attachment.pdf" as trade-specific attachment for "Trade 1"
And I see "Trade 2 Attachment.pdf" as trade-specific attachment for "Trade 2"
And I see "Limited Quotes" option is selected
And I see "Tender" in my account
And I see "Pending" as approval/status
And I edit "Tender"
And I enter "Updated Project Description" as overall project description
And I enter "15000" as budget for "Trade 1"
And I enter "Updated Trade 1 Attachment.pdf" as trade-specific attachment for "Trade 1"
And I save changes
And I refresh "Tender"
Then I see "Updated Project Description" as overall project description
And I see "15000" as budget for "Trade 1"
And I see "Updated Trade 1 Attachment.pdf" as trade-specific attachment for "Trade 1"

Scenario: Create a Project Tender - Negative Flow
@NegativeTesting
Given I open "Project Tender" page
When I enter "Short" as project name
Then I do not see "Tender created successfully" message
And I do not see "Tender" in my account
