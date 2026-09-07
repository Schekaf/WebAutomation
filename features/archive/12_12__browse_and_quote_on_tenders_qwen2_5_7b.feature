Feature: Browse and Quote on Tenders

Scenario: Open Available Tenders using a matching trade account
  Given I am logged in with a matching trade account
  When I open "Available Tenders" section
  Then I see "Available Tenders" is selected as "Section"

Scenario: Find the tender created above
  Given I am on the "Available Tenders" page
  When I search for the tender created above
  Then I see the tender in the search results

Scenario: Open the tender
  Given I am on the "Available Tenders" page
  When I click on the tender created above
  Then I see the tender details page

Scenario: Confirm the relevant trade information is visible
  Given I am on the tender details page
  When I review the trade information
  Then I see the relevant trade information is visible

Scenario: Submit a quote
  Given I am on the tender details page
  When I click on "Submit Quote"
  Then I see the quote form

Scenario: Enter a price
  Given I am on the quote form
  When I enter "1000" in "Price" field
  Then I see "1000" in "Price" field

Scenario: Enter a message/description
  Given I am on the quote form
  When I enter "Test Quote" in "Message/Description" field
  Then I see "Test Quote" in "Message/Description" field

Scenario: Upload supporting information if available
  Given I am on the quote form
  When I upload a file named "SupportingInfo.pdf"
  Then I see "SupportingInfo.pdf" in "Supporting Information" field

Scenario: Submit the quote
  Given I am on the quote form
  When I click on "Submit Quote"
  Then I see "Quote submitted successfully" message

Scenario: Confirm submission was successful
  Given I am on the tender details page
  When I refresh the page
  Then I see my quote in the list of received quotes

Scenario: Open the tender using the account that posted it
  Given I am logged in with the account that posted the tender
  When I open the tender
  Then I see the tender details page

Scenario: View received quotes
  Given I am on the tender details page
  When I click on "View Received Quotes"
  Then I see the list of received quotes

Scenario: Open the test quote
  Given I am on the list of received quotes
  When I click on the test quote
  Then I see the quote details page

Scenario: Check business profile information
  Given I am on the quote details page
  When I review the business profile information
  Then I see the correct business profile information

Scenario: Check quoted amount
  Given I am on the quote details page
  When I review the quoted amount
  Then I see the quoted amount is "1000"

Scenario: Contact/message the quoting business
  Given I am on the quote details page
  When I click on "Contact/Message" button
  Then I see the contact/message form

Scenario: Check that businesses with unrelated trades do not incorrectly see restricted trade information where applicable
  Given I am logged in with a business that has unrelated trades
  When I try to access the tender details page
  Then I do not see the tender details page
