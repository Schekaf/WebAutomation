Feature: Browse and Quote on Tenders

@SmokeTest
Scenario: Open Available Tenders using a matching trade account
  Given I open "https://tradehub.com.au"
  When I click on "Login"
  And I enter "testuser" in "Username"
  And I enter "password123" in "Password"
  And I click on "Login"
  Then I see "Dashboard" is "visible"

@SmokeTest
Scenario: Find the tender created above
  Given I am on the "Dashboard"
  When I click on "Tenders"
  And I see "Tender Title" in "Tender List"

@SmokeTest
Scenario: Open it
  Given I see "Tender Title" in "Tender List"
  When I click on "Tender Title"
  Then I see "Tender Details" is "visible"

@SmokeTest
Scenario: Confirm the relevant trade information is visible
  Given I see "Tender Details" is "visible"
  When I see "Trade Information" in "Tender Details"
  Then I see "Trade Information" is "visible"

@SmokeTest
Scenario: Submit a quote
  Given I see "Tender Details" is "visible"
  When I click on "Submit Quote"
  Then I see "Quote Form" is "visible"

@SmokeTest
Scenario: Enter a price
  Given I see "Quote Form" is "visible"
  When I enter "1000" in "Price"
  Then I see "Price" is "1000"

@SmokeTest
Scenario: Enter a message/description
  Given I see "Quote Form" is "visible"
  When I enter "Test quote for tender" in "Message"
  Then I see "Message" is "Test quote for tender"

@SmokeTest
Scenario: Upload supporting information if available
  Given I see "Quote Form" is "visible"
  When I click on "Upload File"
  And I select "testfile.pdf" as "File"
  Then I see "testfile.pdf" in "Uploaded Files"

@SmokeTest
Scenario: Submit the quote
  Given I see "Quote Form" is "visible"
  When I click on "Submit"
  Then I see "Quote Submitted" is "visible"

@SmokeTest
Scenario: Confirm submission was successful
  Given I see "Quote Submitted" is "visible"
  When I click on "Dashboard"
  Then I see "Submitted Quotes" is "visible"

@SmokeTest
Scenario: Open the tender using the account that posted it
  Given I am on the "Dashboard"
  When I click on "Tenders"
  And I see "Tender Title" in "Tender List"
  When I click on "Tender Title"
  Then I see "Tender Details" is "visible"

@SmokeTest
Scenario: View received quotes
  Given I see "Tender Details" is "visible"
  When I click on "Quotes"
  Then I see "Received Quotes" is "visible"

@SmokeTest
Scenario: Open the test quote
  Given I see "Received Quotes" is "visible"
  When I click on "Test Quote"
  Then I see "Quote Details" is "visible"

@SmokeTest
Scenario: Check business profile information
  Given I see "Quote Details" is "visible"
  When I see "Business Profile" in "Quote Details"
  Then I see "Business Profile" is "visible"

@SmokeTest
Scenario: Check quoted amount
  Given I see "Quote Details" is "visible"
  When I see "Quoted Amount" in "Quote Details"
  Then I see "Quoted Amount" is "1000"

@SmokeTest
Scenario: Contact/message the quoting business
  Given I see "Quote Details" is "visible"
  When I click on "Contact Business"
  Then I see "Contact Form" is "visible"

@SmokeTest
Scenario: Check that businesses with unrelated trades do not incorrectly see restricted trade information where applicable
  Given I am logged in as a different user
  When I search for "Tender Title"
  Then I do not see "Restricted Trade Information" in "Tender Details"
