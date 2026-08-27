Feature: Try to Break Things

@SmokeTest
Scenario: Submit an empty form
    Given I open "https://tradehub.com.au/register"
    When I click on "Submit"
    Then I see "All fields are required" in "Error Messages"

@NegativeTesting
Scenario: Enter very long descriptions
    Given I open "https://tradehub.com.au/register"
    When I enter "a" in "First Name" 101 times
    And I click on "Submit"
    Then I see "Validation Error" in "Error Messages"

@NegativeTesting
Scenario: Enter unusual characters
    Given I open "https://tradehub.com.au/register"
    When I enter "!@#$%^&*()" in "First Name"
    And I click on "Submit"
    Then I see "Validation Error" in "Error Messages"

@NegativeTesting
Scenario: Double-click Submit
    Given I open "https://tradehub.com.au/register"
    When I click on "Submit" and double-click on "Submit"
    Then I see "Submit" button is not double-activated

@NegativeTesting
Scenario: Refresh during a form
    Given I open "https://tradehub.com.au/register"
    When I enter "John" in "First Name"
    And I press on "F5" Key
    Then I see "John" is still in "First Name"

@NegativeTesting
Scenario: Click Back after submitting
    Given I open "https://tradehub.com.au/register"
    When I enter "John" in "First Name"
    And I click on "Submit"
    And I click the Go Back Button
    Then I see "First Name" is empty

@NegativeTesting
Scenario: Upload a large attachment
    Given I open "https://tradehub.com.au/upload"
    When I enter "C:\path\to\largefile.txt" in "File Upload"
    And I click on "Upload"
    Then I see "File size exceeds limit" in "Error Messages"

@NegativeTesting
Scenario: Upload an unsupported file type
    Given I open "https://tradehub.com.au/upload"
    When I enter "C:\path\to\image.jpg" in "File Upload"
    And I click on "Upload"
    Then I see "Unsupported file type" in "Error Messages"

@NegativeTesting
Scenario: Select a date in the past
    Given I open "https://tradehub.com.au/trade"
    When I enter "01/01/2000" in "Date"
    And I click on "Submit"
    Then I see "Invalid date" in "Error Messages"

@NegativeTesting
Scenario: Enter an incorrect ABN
    Given I open "https://tradehub.com.au/register"
    When I enter "ABN123456789" in "ABN"
    And I click on "Submit"
    Then I see "Invalid ABN" in "Error Messages"

@NegativeTesting
Scenario: Open the same account on two browser tabs
    Given I open "https://tradehub.com.au/account"
    And I open "https://tradehub.com.au/account" in a new tab
    When I change "Balance" in one tab
    Then I see the change in the other tab

@NegativeTesting
Scenario: Rapidly switch between pages
    Given I open "https://tradehub.com.au/register"
    When I click on "Submit" and immediately click on "Cancel"
    Then I see "Register" page is still active

@NegativeTesting
Scenario: Try accessing a page through its URL while logged out
    Given I open "https://tradehub.com.au/premium"
    Then I see "You need to be logged in to access this page" in "Error Messages"

@NegativeTesting
Scenario: Try performing Premium actions with a Free account
    Given I open "https://tradehub.com.au/premium"
    When I click on "Subscribe"
    Then I see "You need a Premium account to access this feature" in "Error Messages"
