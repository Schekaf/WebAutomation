Feature: Directory / Search Trades

@SmokeTest
Scenario: Open Directory
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  Then I see "Directory" is "open"

@PositiveTesting
Scenario: Search for a trade
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  And I enter "Electrician" in "Search Box"
  And I click on "Search"
  Then I see "Electrician" in "Search Results"

@PositiveTesting
Scenario: Search by suburb/location
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  And I enter "Sydney" in "Location Search Box"
  And I click on "Search"
  Then I see "Sydney" in "Search Results"

@PositiveTesting
Scenario: Change distance/radius
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  And I select "5 km" as "Distance"
  And I click on "Search"
  Then I see "Distance" is "5 km"

@PositiveTesting
Scenario: Test available-date filtering
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  And I select "Today" as "Available Date"
  And I click on "Search"
  Then I see "Today" in "Available Dates"

@PositiveTesting
Scenario: Open several profiles
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  And I click on "Profile 1"
  And I click on "Profile 2"
  Then I see "Profile 1" is "open"
  And I see "Profile 2" is "open"

@PositiveTesting
Scenario: Check rates
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  And I click on "Profile 1"
  Then I see "Rates" is "available"

@PositiveTesting
Scenario: Check reviews
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  And I click on "Profile 1"
  Then I see "Reviews" is "available"

@PositiveTesting
Scenario: Check available dates
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  And I click on "Profile 1"
  Then I see "Available Dates" is "available"

@PositiveTesting
Scenario: Check profile descriptions
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  And I click on "Profile 1"
  Then I see "Profile Description" is "available"

@PositiveTesting
Scenario: Contact/message a business
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  And I click on "Profile 1"
  And I click on "Contact"
  Then I see "Contact Form" is "open"

@PositiveTesting
Scenario: Confirm that the results make sense based on the filters selected
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  And I select "Electrician" as "Search Box"
  And I select "Sydney" as "Location Search Box"
  And I select "5 km" as "Distance"
  And I select "Today" as "Available Date"
  And I click on "Search"
  Then I see "Electrician" in "Search Results"
  And I see "Sydney" in "Search Results"
  And I see "Distance" is "5 km"
  And I see "Today" in "Available Dates"

@NegativeTesting
Scenario: Check Free account radius restrictions if applicable
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  And I select "100 km" as "Distance"
  And I click on "Search"
  Then I see "Distance" is "5 km"
