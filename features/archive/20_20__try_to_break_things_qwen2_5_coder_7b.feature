Feature: Try to Break Things

Scenario: Submit an empty form
@NegativeTesting
Given I open "https://tradehub.com.au"
When I click on "Submit"
Then I see "Error" is "Please fill in all required fields"

Scenario: Enter very long descriptions
@NegativeTesting
Given I open "https://tradehub.com.au"
When I enter "a" * 1000 in "Description"
And I click on "Submit"
Then I see "Error" is "Description is too long"

Scenario: Enter unusual characters
@NegativeTesting
Given I open "https://tradehub.com.au"
When I enter "£$%^&*()_+{}|:<>?`~" in "Description"
And I click on "Submit"
Then I see "Error" is "Invalid characters in Description"

Scenario: Double-click Submit
@NegativeTesting
Given I open "https://tradehub.com.au"
When I double-click on "Submit"
Then I see "Error" is "Please fill in all required fields"

Scenario: Refresh during a form
@NegativeTesting
Given I open "https://tradehub.com.au"
When I enter "Test" in "Name"
And I press on "F5" Key
Then I see "Name" is "Test"

Scenario: Click Back after submitting
@NegativeTesting
Given I open "https://tradehub.com.au"
When I click on "Submit"
And I click the Go Back Button
Then I see "Form" is displayed

Scenario: Upload a large attachment
@NegativeTesting
Given I open "https://tradehub.com.au"
When I upload a file larger than 10MB
And I click on "Submit"
Then I see "Error" is "File size exceeds limit"

Scenario: Upload an unsupported file type
@NegativeTesting
Given I open "https://tradehub.com.au"
When I upload a file with an unsupported extension
And I click on "Submit"
Then I see "Error" is "Unsupported file type"

Scenario: Select a date in the past
@NegativeTesting
Given I open "https://tradehub.com.au"
When I select a date in the past in "Date"
And I click on "Submit"
Then I see "Error" is "Date must be in the future"

Scenario: Enter an incorrect ABN
@NegativeTesting
Given I open "https://tradehub.com.au"
When I enter "1234567890" in "ABN"
And I click on "Submit"
Then I see "Error" is "Invalid ABN"

Scenario: Open the same account on two browser tabs
@NegativeTesting
Given I open "https://tradehub.com.au"
And I open the same account on another browser tab
Then I see "Error" is "Account already in use"

Scenario: Rapidly switch between pages
@NegativeTesting
Given I open "https://tradehub.com.au"
When I rapidly switch between "Home" and "About" pages
Then I see "Home" and "About" pages are displayed

Scenario: Try accessing a page through its URL while logged out
@NegativeTesting
Given I open "https://tradehub.com.au/protected-page"
Then I see "Error" is "You must be logged in to access this page"

Scenario: Try performing Premium actions with a Free account
@NegativeTesting
Given I open "https://tradehub.com.au/premium-action"
And I click on "Perform Action"
Then I see "Error" is "Premium account required"
