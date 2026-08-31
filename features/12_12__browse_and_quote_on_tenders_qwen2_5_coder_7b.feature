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
And I see "Available Tenders" is "visible"
Then I see "Test Tender" in "Available Tenders" Values

@SmokeTest
Scenario: Open it
Given I see "Test Tender" in "Available Tenders" Values
When I click on "Test Tender"
Then I see "Tender Details" is "visible"

@SmokeTest
Scenario: Confirm the relevant trade information is visible
Given I see "Tender Details" is "visible"
When I see "Trade Information" is "visible"
Then I see "Test Trade" in "Trade Information" Values

@SmokeTest
Scenario: Submit a quote
Given I see "Tender Details" is "visible"
When I click on "Submit Quote"
Then I see "Quote Form" is "visible"

@SmokeTest
Scenario: Enter a price
Given I see "Quote Form" is "visible"
When I enter "1000" in "Price"
Then I see "1000" in "Price" Values

@SmokeTest
Scenario: Enter a message/description
Given I see "Quote Form" is "visible"
When I enter "Test quote for test tender" in "Message/Description"
Then I see "Test quote for test tender" in "Message/Description" Values

@SmokeTest
Scenario: Upload supporting information if available
Given I see "Quote Form" is "visible"
When I click on "Upload Supporting Information"
And I select "testfile.pdf" as "File"
Then I see "testfile.pdf" in "Uploaded Files" Values

@SmokeTest
Scenario: Submit the quote
Given I see "Quote Form" is "visible"
When I click on "Submit"
Then I see "Quote Submitted Successfully" is "visible"

@SmokeTest
Scenario: Confirm submission was successful
Given I see "Quote Submitted Successfully" is "visible"
When I click on "Dashboard"
Then I see "Dashboard" is "visible"

@SmokeTest
Scenario: Open the tender using the account that posted it
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "postertester" in "Username"
And I enter "password123" in "Password"
And I click on "Login"
Then I see "Dashboard" is "visible"

@SmokeTest
Scenario: View received quotes
Given I am on the "Dashboard"
When I click on "Tenders"
And I see "Received Quotes" is "visible"
Then I see "Test Tender" in "Received Quotes" Values

@SmokeTest
Scenario: Open the test quote
Given I see "Test Tender" in "Received Quotes" Values
When I click on "Test Tender"
Then I see "Quote Details" is "visible"

@SmokeTest
Scenario: Check business profile information
Given I see "Quote Details" is "visible"
When I see "Business Profile" is "visible"
Then I see "Postertester" in "Business Profile" Values

@SmokeTest
Scenario: Check quoted amount
Given I see "Quote Details" is "visible"
When I see "Quoted Amount" is "visible"
Then I see "1000" in "Quoted Amount" Values

@SmokeTest
Scenario: Contact/message the quoting business
Given I see "Quote Details" is "visible"
When I click on "Contact Business"
And I enter "Hello, please check the quote" in "Message"
And I click on "Send"
Then I see "Message Sent Successfully" is "visible"

@SmokeTest
Scenario: Check that businesses with unrelated trades do not incorrectly see restricted trade information where applicable
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "unrelateduser" in "Username"
And I enter "password123" in "Password"
And I click on "Login"
Then I see "Dashboard" is "visible"
And I see "Test Tender" is "not visible"
