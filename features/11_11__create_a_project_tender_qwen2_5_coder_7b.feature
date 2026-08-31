Feature: Create a Project Tender

@SmokeTest
Scenario: Create a Project Tender with Required Fields
  Given I open "https://tradehub.com.au"
  When I click on "Create Tender"
  And I enter "Project A" in "Project Name"
  And I enter "Location X" in "Project Location"
  And I enter "2023-10-01" in "Project Start Date"
  And I enter "2023-10-31" in "Project End Date"
  And I enter "Overall project description" in "Project Description"
  And I upload "plans.pdf" as "Plans"
  And I select "Trade 1" as "Required Trades"
  And I enter "Description for Trade 1" in "Trade 1 Description"
  And I enter "10000" in "Trade 1 Budget"
  And I upload "trade1_attachment.pdf" as "Trade 1 Attachment"
  And I select "Limited Quotes"
  And I submit the tender
  Then I see "Tender Created Successfully" is displayed
  And I see "Project A" in "My Tenders"
  And I open "Project A"
  And I see "Project A" is "Pending Approval"

@NegativeTesting
Scenario: Create a Project Tender without Required Fields
  Given I open "https://tradehub.com.au"
  When I click on "Create Tender"
  And I enter "Project A" in "Project Name"
  And I enter "Location X" in "Project Location"
  And I enter "2023-10-01" in "Project Start Date"
  And I enter "2023-10-31" in "Project End Date"
  And I enter "Overall project description" in "Project Description"
  And I upload "plans.pdf" as "Plans"
  And I select "Trade 1" as "Required Trades"
  And I enter "Description for Trade 1" in "Trade 1 Description"
  And I enter "10000" in "Trade 1 Budget"
  And I submit the tender
  Then I see "Error: Required fields are missing" is displayed

@SmokeTest
Scenario: Edit and Save a Project Tender
  Given I open "https://tradehub.com.au"
  When I click on "Create Tender"
  And I enter "Project A" in "Project Name"
  And I enter "Location X" in "Project Location"
  And I enter "2023-10-01" in "Project Start Date"
  And I enter "2023-10-31" in "Project End Date"
  And I enter "Overall project description" in "Project Description"
  And I upload "plans.pdf" as "Plans"
  And I select "Trade 1" as "Required Trades"
  And I enter "Description for Trade 1" in "Trade 1 Description"
  And I enter "10000" in "Trade 1 Budget"
  And I upload "trade1_attachment.pdf" as "Trade 1 Attachment"
  And I select "Limited Quotes"
  And I submit the tender
  And I open "Project A"
  And I click on "Edit Tender"
  And I enter "Updated Description for Trade 1" in "Trade 1 Description"
  And I enter "15000" in "Trade 1 Budget"
  And I upload "trade1_attachment_updated.pdf" as "Trade 1 Attachment"
  And I save the changes
  Then I see "Tender Updated Successfully" is displayed
  And I open "Project A"
  And I see "Updated Description for Trade 1" in "Trade 1 Description"
  And I see "15000" in "Trade 1 Budget"
  And I see "trade1_attachment_updated.pdf" in "Trade 1 Attachments"

@SmokeTest
Scenario: Check Tender Approval/Status
  Given I open "https://tradehub.com.au"
  When I click on "Create Tender"
  And I enter "Project A" in "Project Name"
  And I enter "Location X" in "Project Location"
  And I enter "2023-10-01" in "Project Start Date"
  And I enter "2023-10-31" in "Project End Date"
  And I enter "Overall project description" in "Project Description"
  And I upload "plans.pdf" as "Plans"
  And I select "Trade 1" as "Required Trades"
  And I enter "Description for Trade 1" in "Trade 1 Description"
  And I enter "10000" in "Trade 1 Budget"
  And I upload "trade1_attachment.pdf" as "Trade 1 Attachment"
  And I select "Limited Quotes"
  And I submit the tender
  And I open "Project A"
  And I see "Project A" is "Pending Approval"
  And I click on "Approve Tender"
  And I confirm the approval
  Then I see "Tender Approved Successfully" is displayed
  And I open "Project A"
  And I see "Project A" is "Approved"
