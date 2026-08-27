Feature: Directory / Search Trades

Scenario: Open Directory
  Given I open "TradeHub" URL
  When I click on "Directory" in the navigation menu
  Then I see "Directory" page is loaded

Scenario: Search for a trade
  Given I open "TradeHub" URL
  When I click on "Directory" in the navigation menu
  And I enter "Plumber" in the search field
  Then I see search results for "Plumber"

Scenario: Search by suburb/location
  Given I open "TradeHub" URL
  When I click on "Directory" in the navigation menu
  And I enter "Sydney" in the location field
  Then I see search results for "Sydney"

Scenario: Change distance/radius
  Given I open "TradeHub" URL
  When I click on "Directory" in the navigation menu
  And I enter "Sydney" in the location field
  And I select "10" as "Radius"
  Then I see search results within 10km of "Sydney"

Scenario: Test available-date filtering
  Given I open "TradeHub" URL
  When I click on "Directory" in the navigation menu
  And I enter "Plumber" in the search field
  And I select "Next 7 days" as "Available Dates"
  Then I see only trades available within the next 7 days

Scenario: Open several profiles
  Given I open "TradeHub" URL
  When I click on "Directory" in the navigation menu
  And I enter "Plumber" in the search field
  And I click on "Profile 1"
  And I click on "Profile 2"
  Then I see "Profile 1" and "Profile 2" are open

Scenario: Check rates
  Given I open "TradeHub" URL
  When I click on "Directory" in the navigation menu
  And I enter "Plumber" in the search field
  And I click on "Profile 1"
  Then I see "Profile 1" rates are displayed

Scenario: Check reviews
  Given I open "TradeHub" URL
  When I click on "Directory" in the navigation menu
  And I enter "Plumber" in the search field
  And I click on "Profile 1"
  Then I see "Profile 1" reviews are displayed

Scenario: Check available dates
  Given I open "TradeHub" URL
  When I click on "Directory" in the navigation menu
  And I enter "Plumber" in the search field
  And I click on "Profile 1"
  Then I see "Profile 1" available dates are displayed

Scenario: Check profile descriptions
  Given I open "TradeHub" URL
  When I click on "Directory" in the navigation menu
  And I enter "Plumber" in the search field
  And I click on "Profile 1"
  Then I see "Profile 1" description is displayed

Scenario: Contact/message a business
  Given I open "TradeHub" URL
  When I click on "Directory" in the navigation menu
  And I enter "Plumber" in the search field
  And I click on "Profile 1"
  And I enter "Test Message" in the message field
  And I enter "Test Name" in the name field
  And I enter "test@example.com" in the email field
  And I click on "Send Message"
  Then I see "Message Sent" confirmation

Scenario: Confirm that the results make sense based on the filters selected
  Given I open "TradeHub" URL
  When I click on "Directory" in the navigation menu
  And I enter "Plumber" in the search field
  And I select "Sydney" as "Location"
  And I select "Next 7 days" as "Available Dates"
  Then I see search results for "Plumber" in "Sydney" and available within the next 7 days

Scenario: Check the Free account radius restrictions if applicable
  Given I open "TradeHub" URL
  When I click on "Directory" in the navigation menu
  And I enter "Plumber" in the search field
  And I select "25" as "Radius"
  Then I see only trades within the free account radius are displayed
