Feature: Free vs Premium Restrictions

Scenario: Check Free account 15 km radius restriction
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "freeuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Job Search" is "disabled"

Scenario: Check Free account tender browsing
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "freeuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Tender Browsing" is "enabled"

Scenario: Check Free account free tender posting allowance
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "freeuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Free Tender Posting Allowance" is "10"

Scenario: Check Free account tender quote allowance
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "freeuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Free Tender Quote Allowance" is "5"

Scenario: Check Free account quote limits
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "freeuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Quote Limits" is "1000"

Scenario: Check Free account in-app notifications
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "freeuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "In-app Notifications" is "enabled"

Scenario: Check Free account jobs access
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "freeuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Jobs Access" is "limited"

Scenario: Check Free account directory access
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "freeuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Directory Access" is "limited"

Scenario: Check Premium account unlimited radius
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "premiumuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Job Search" is "enabled"

Scenario: Check Premium account unlimited jobs
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "premiumuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Unlimited Jobs" is "enabled"

Scenario: Check Premium account unlimited tender access
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "premiumuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Unlimited Tender Access" is "enabled"

Scenario: Check Premium account unlimited tender quotes
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "premiumuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Unlimited Tender Quotes" is "enabled"

Scenario: Check Premium account unlimited tender posting
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "premiumuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Unlimited Tender Posting" is "enabled"

Scenario: Check Premium account availability broadcasts
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "premiumuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Availability Broadcasts" is "enabled"

Scenario: Check Premium account SMS/email alerts where applicable
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "premiumuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "SMS/Email Alerts" is "enabled"

Scenario: Check Premium account premium/verified badge functionality
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "premiumuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Premium/Verified Badge" is "enabled"

Scenario: Check Premium account market rate information where available
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "premiumuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I see "Market Rate Information" is "enabled"

Scenario: Confirm Premium users are not accidentally shown Free restrictions
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "premiumuser@example.com" in "Email"
And I enter "password" in "Password"
And I click on "Login"
Then I do not see "Free Account Restrictions"
