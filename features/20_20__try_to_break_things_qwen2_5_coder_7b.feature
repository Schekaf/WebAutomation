Feature: Try to Break Things

Scenario: Submit an empty form
@NegativeTesting
Given I open "https://tradehub.com.au"
When I click on "Submit"
Then I see "Please fill out all required fields" is displayed

Scenario: Enter very long descriptions
@NegativeTesting
Given I open "https://tradehub.com.au"
When I enter "a" * 1000 in "Description"
And I click on "Submit"
Then I see "Description is too long" is displayed

Scenario: Enter unusual characters
@NegativeTesting
Given I open "https://tradehub.com.au"
When I enter "£$%^&*()_+{}|:<>?`~" in "Description"
And I click on "Submit"
Then I see "Invalid characters in Description" is displayed

Scenario: Double-click Submit
@NegativeTesting
Given I open "https://tradehub.com.au"
When I double-click on "Submit"
Then I see "Please fill out all required fields" is displayed

Scenario: Refresh during a form
@NegativeTesting
Given I open "https://tradehub.com.au"
When I enter "test" in "Username"
And I press on "F5" Key
Then I see "Username" is empty

Scenario: Click Back after submitting
@NegativeTesting
Given I open "https://tradehub.com.au"
When I enter "test" in "Username"
And I click on "Submit"
And I click the Go Back Button
Then I see "Username" is "test"

Scenario: Upload a large attachment
@NegativeTesting
Given I open "https://tradehub.com.au"
When I click on "Upload File"
And I select a file larger than 10MB
Then I see "File size exceeds limit" is displayed

Scenario: Upload an unsupported file type
@NegativeTesting
Given I open "https://tradehub.com.au"
When I click on "Upload File"
And I select a file with an unsupported extension
Then I see "Unsupported file type" is displayed

Scenario: Select a date in the past
@NegativeTesting
Given I open "https://tradehub.com.au"
When I select a date in the past in "Date Picker"
And I click on "Submit"
Then I see "Date must be in the future" is displayed

Scenario: Enter an incorrect ABN
@NegativeTesting
Given I open "https://tradehub.com.au"
When I enter "1234567890" in "ABN"
And I click on "Submit"
Then I see "Invalid ABN" is displayed

Scenario: Open the same account on two browser tabs
@NegativeTesting
Given I open "https://tradehub.com.au"
And I open the same account on another browser tab
Then I see "Account already in use" is displayed

Scenario: Rapidly switch between pages
@NegativeTesting
Given I open "https://tradehub.com.au"
When I rapidly switch between "Dashboard" and "Settings" pages
Then I see "Dashboard" and "Settings" pages are loaded correctly

Scenario: Try accessing a page through its URL while logged out
@NegativeTesting
Given I open "https://tradehub.com.au"
And I click the Go Back Button
And I open "https://tradehub.com.au/settings"
Then I see "Please log in to access this page" is displayed

Scenario: Try performing Premium actions with a Free account
@NegativeTesting
Given I open "https://tradehub.com.au"
And I click on "Premium Feature"
Then I see "Premium features are not available for Free accounts" is displayed
