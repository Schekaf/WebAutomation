Feature: Create a Project Tender

@SmokeTest
Scenario: Create a Project Tender with Basic Information
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "user@example.com" in "Email"
  And I enter "password" in "Password"
  And I click on "Login Button"
  And I click on "Create Project Tender"
  And I enter "Project Name" in "Project Name"
  And I enter "Project Location" in "Project Location"
  And I enter "Start Date" in "Project Dates"
  And I enter "End Date" in "Project Dates"
  And I add the overall project description in "Project Description"
  And I upload plans in "Upload Plans"
  And I select "Trade 1" as "Required Trades"
  And I enter "Trade 1 Description" in "Trade 1 Description"
  And I enter "Trade 1 Budget" in "Trade 1 Budget"
  And I upload trade-specific attachments in "Trade 1 Attachments"
  And I test the Limited Quotes option
  And I submit the tender
  Then I see "Tender Created Successfully" is "visible"

@SmokeTest
Scenario: Confirm Tender Appears in Account
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "user@example.com" in "Email"
  And I enter "password" in "Password"
  And I click on "Login Button"
  And I click on "My Tenders"
  Then I see "Project Name" is "visible"

@SmokeTest
Scenario: Check Tender Approval/Status
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "user@example.com" in "Email"
  And I enter "password" in "Password"
  And I click on "Login Button"
  And I click on "My Tenders"
  And I click on "Project Name"
  Then I see "Tender Status" is "approved"

@SmokeTest
Scenario: Open and Confirm Tender Information
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "user@example.com" in "Email"
  And I enter "password" in "Password"
  And I click on "Login Button"
  And I click on "My Tenders"
  And I click on "Project Name"
  Then I see "Project Name" is "visible"
  And I see "Project Location" is "visible"
  And I see "Project Dates" is "visible"
  And I see "Project Description" is "visible"
  And I see "Trade 1 Description" is "visible"
  And I see "Trade 1 Budget" is "visible"

@SmokeTest
Scenario: Edit and Save Tender Changes
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "user@example.com" in "Email"
  And I enter "password" in "Password"
  And I click on "Login Button"
  And I click on "My Tenders"
  And I click on "Project Name"
  And I click on "Edit Tender"
  And I enter "Updated Project Name" in "Project Name"
  And I click on "Save Changes"
  Then I see "Tender Updated Successfully" is "visible"

@SmokeTest
Scenario: Refresh and Verify Changes Remain
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "user@example.com" in "Email"
  And I enter "password" in "Password"
  And I click on "Login Button"
  And I click on "My Tenders"
  And I click on "Project Name"
  And I click on "Edit Tender"
  And I enter "Updated Project Name" in "Project Name"
  And I click on "Save Changes"
  And I click on "Refresh"
  Then I see "Updated Project Name" is "visible"
