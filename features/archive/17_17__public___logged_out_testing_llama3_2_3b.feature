Feature: Public / Logged-Out Testing

Scenario Outline: Visit the homepage while logged out

Given I am on the homepage
When I click on the login button
Then I should be redirected to the login page

Scenario Outline: Open the public Tenders page while logged out

Given I am on the homepage
When I click on the public tenders link
Then I should be redirected to the public tenders page

Scenario Outline: Open an individual public tender while logged out

Given I am on the public tenders page
When I click on a public tender link
Then I should be redirected to the individual public tender page

Scenario Outline: Check blurred/restricted information while logged out

Given I am on the individual public tender page
When I click on a restricted link
Then I should see a message indicating that I need to log in

Scenario Outline: Try clicking actions requiring an account while logged out

Given I am on the individual public tender page
When I click on an action requiring an account
Then I should see a message asking me to log in

Scenario Outline: Confirm TradeHub asks you to sign up/login when clicking restricted actions

Given I am on the individual public tender page
When I click on a restricted link
Then I should see a message asking me to sign up or log in

Scenario Outline: Visit public SEO tender pages where available while logged out

Given I am on the homepage
When I click on the public SEO tenders link
Then I should be redirected to the public SEO tenders page

Scenario Outline: Test navigation throughout the public website while logged out

Given I am on the homepage
When I navigate to different pages
Then I should be able to navigate to the desired page

Scenario Outline: Check for any private information that is accidentally visible while logged out

Given I am on the homepage
When I click on a link to a private page
Then I should not see any private information
