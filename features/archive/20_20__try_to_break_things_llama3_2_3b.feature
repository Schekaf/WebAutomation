Feature: Try to Break Things

Scenario Outline: Submit an empty form
Given I am on the login page
When I submit the form
Then I should see an error message

Scenario Outline: Enter very long descriptions
Given I am on the form page
When I enter a very long description in the text field
Then I should see an error message

Scenario Outline: Enter unusual characters
Given I am on the form page
When I enter unusual characters in the text field
Then I should see an error message

Scenario Outline: Double-click Submit
Given I am on the form page
When I double-click the submit button
Then I should see an error message

Scenario Outline: Refresh during a form
Given I am on the form page
When I refresh the page while the form is being submitted
Then I should see an error message

Scenario Outline: Click Back after submitting
Given I am on the form page
When I submit the form and click the back button
Then I should be taken back to the previous page

Scenario Outline: Upload a large attachment
Given I am on the form page
When I upload a large attachment
Then I should see an error message

Scenario Outline: Upload an unsupported file type
Given I am on the form page
When I upload an unsupported file type
Then I should see an error message

Scenario Outline: Select a date in the past
Given I am on the form page
When I select a date in the past
Then I should see an error message

Scenario Outline: Enter an incorrect ABN
Given I am on the form page
When I enter an incorrect ABN
Then I should see an error message

Scenario Outline: Open the same account on two browser tabs
Given I am on the login page
When I open a new browser tab and log in to the same account
Then I should see the same account information

Scenario Outline: Rapidly switch between pages
Given I am on the form page
When I rapidly switch between pages
Then I should see an error message

Scenario Outline: Try accessing a page through its URL while logged out
Given I am on the login page
When I try to access a page through its URL while logged out
Then I should see an error message

Scenario Outline: Try performing Premium actions with a Free account
Given I am on the login page
When I log in with a free account
Then I should not be able to perform premium actions
