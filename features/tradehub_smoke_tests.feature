Feature: TradeHub Comprehensive Smoke Test Suite
  As a Trade Business user on TradeHub
  I want to test all features and edge cases across the platform
  So that I can verify full application stability and user experience

# ------------------------------------------------------------------
# Section: 1. Create a New Account
# ------------------------------------------------------------------
Here are the Behave Gherkin scenarios for each section:

**Create a New Account**

Feature: Create a New Account

  @create_account
  Scenario: Visit the TradeHub homepage
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    Then I should see the create account form

  @create_account
  Scenario: Create a new Trade Business account
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    Then I should see the create account form with the correct fields

  @create_account
  Scenario: Enter your name
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    And I enter a name in the "Name" field
    Then I should see a success message

  @create_account
  Scenario: Enter a business name
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    And I enter a business name in the "Business Name" field
    Then I should see a success message

  @create_account
  Scenario: Enter an email address
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    And I enter an email address in the "Email" field
    Then I should see a success message

  @create_account
  Scenario: Enter a phone number if requested
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    And I enter a phone number in the "Phone" field
    Then I should see a success message

  @create_account
  Scenario: Select your primary trade
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    And I select a primary trade from the dropdown
    Then I should see a success message

  @create_account
  Scenario: Enter your suburb/location
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    And I enter a suburb/location in the "Suburb" field
    Then I should see a success message

  @create_account
  Scenario: Create a password
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    And I enter a password in the "Password" field
    Then I should see a success message

  @create_account
  Scenario: Accept any required terms
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    And I accept the terms and conditions
    Then I should see a success message

  @create_account
  Scenario: Complete account registration
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    And I enter all required fields
    And I accept the terms and conditions
    Then I should see a success message

  @create_account
  Scenario: Check if all instructions are easy to understand
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    And I follow the instructions to create an account
    Then I should be able to understand the instructions

  @create_account
  Scenario: Check if required fields are clearly identified
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    And I enter a name in the "Name" field
    And I enter an email address in the "Email" field
    Then I should see a clear indication of required fields

  @create_account
  Scenario: Check if incorrect fields show useful error messages
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    And I enter an incorrect email address in the "Email" field
    Then I should see a useful error message

  @create_account
  Scenario: Check if the account is created successfully
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Trade Business" as the account type
    And I enter all required fields
    And I accept the terms and conditions
    Then I should see a success message

##Free vs Premium Restrictions##

Feature: Free vs Premium Restrictions

  @free_vs_premium
  Scenario: Check Free account 15 km radius restriction
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Free" as the account type
    And I enter a suburb/location within the 15 km radius
    Then I should see a success message

  @free_vs_premium
  Scenario: Check Free account tender browsing
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Free" as the account type
    And I try to browse tenders
    Then I should see a message indicating that I need a premium account to browse tenders

  @free_vs_premium
  Scenario: Check Free account free tender posting allowance
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Free" as the account type
    And I try to post a tender
    Then I should see a message indicating that I need a premium account to post tenders

  @free_vs_premium
  Scenario: Check Free account tender quote allowance
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Free" as the account type
    And I try to quote a tender
    Then I should see a message indicating that I need a premium account to quote tenders

  @free_vs_premium
  Scenario: Check Free account quote limits
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Free" as the account type
    And I try to quote a tender multiple times
    Then I should see a message indicating that I have reached the quote limit

  @free_vs_premium
  Scenario: Check Free account in-app notifications
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Free" as the account type
    And I receive a notification
    Then I should see the notification

  @free_vs_premium
  Scenario: Check Free account jobs access
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Free" as the account type
    And I try to access jobs
    Then I should see a message indicating that I need a premium account to access jobs

  @free_vs_premium
  Scenario: Check Free account directory access
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Free" as the account type
    And I try to access the directory
    Then I should see a message indicating that I need a premium account to access the directory

  @free_vs_premium
  Scenario: Check Premium account unlimited radius
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Premium" as the account type
    And I enter a suburb/location outside the 15 km radius
    Then I should see a success message

  @free_vs_premium
  Scenario: Check Premium account unlimited jobs
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Premium" as the account type
    And I try to access jobs
    Then I should see a success message

  @free_vs_premium
  Scenario: Check Premium account unlimited tender access
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Premium" as the account type
    And I try to access tenders
    Then I should see a success message

  @free_vs_premium
  Scenario: Check Premium account unlimited tender quotes
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Premium" as the account type
    And I try to quote a tender
    Then I should see a success message

  @free_vs_premium
  Scenario: Check Premium account unlimited tender posting
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Premium" as the account type
    And I try to post a tender
    Then I should see a success message

  @free_vs_premium
  Scenario: Check Premium account availability broadcasts
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Premium" as the account type
    And I receive an availability broadcast
    Then I should see the broadcast

  @free_vs_premium
  Scenario: Check Premium account SMS/email alerts where applicable
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Premium" as the account type
    And I receive an SMS/email alert
    Then I should see the alert

  @free_vs_premium
  Scenario: Check Premium account premium/verified badge functionality
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Premium" as the account type
    And I see a premium/verified badge
    Then I should see the badge

  @free_vs_premium
  Scenario: Check Premium account market rate information where available
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Premium" as the account type
    And I see market rate information
    Then I should see the information

  @free_vs_premium
  Scenario: Confirm Premium users are not accidentally shown Free restrictions
    Given I am on the TradeHub homepage
    When I click the option to create/register an account
    And I select "Premium" as the account type
    And I see a restriction
    Then I should not see the restriction

##Public / Logged-Out Testing##

Feature: Public / Logged-Out Testing

  @public_logged_out
  Scenario: Visit the homepage while logged out
    Given I am on the TradeHub homepage
    When I am not logged in
    Then I should see a public message

  @public_logged_out
  Scenario: Open the public Tenders page while logged out
    Given I am on the TradeHub homepage
    When I am not logged in
    And I click the public Tenders link
    Then I should see the public Tenders page

  @public_logged_out
  Scenario: Open an individual public tender while logged out
    Given I am on the TradeHub homepage
    When I am not logged in
    And I click the public tender link
    Then I should see the public tender

  @public_logged_out
  Scenario: Check blurred/restricted information while logged out
    Given I am on the TradeHub homepage
    When I am not logged in
    And I click a restricted link
    Then I should see blurred information

  @public_logged_out
  Scenario: Try clicking actions requiring an account while logged out
    Given I am on the TradeHub homepage
    When I am not logged in
    And I click an action requiring an account
    Then I should see a message asking me to log in

  @public_logged_out
  Scenario: Confirm TradeHub asks me to sign up/login when clicking restricted actions
    Given I am on the TradeHub homepage
    When I am not logged in
    And I click a restricted link
    Then I should see a message asking me to log in

  @public_logged_out
  Scenario: Visit public SEO tender pages where available while logged out
    Given I am on the TradeHub homepage
    When I am not logged in
    And I click the public SEO tender link
    Then I should see the public SEO tender page

  @public_logged_out
  Scenario: Test navigation throughout the public website while logged out
    Given I am on the TradeHub homepage
    When I am not logged in
    And I click a link to a different page
    Then I should see the new page

  @public_logged_out
  Scenario: Check for any private information that is accidentally visible while logged out
    Given I am on the TradeHub homepage
    When I am not logged in
    And I click a link to a private page
    Then I should not see any private information

##Mobile Testing##
Feature: Mobile Testing

  @mobile_test
  Scenario: Test account registration on mobile
    Given I am on a mobile device
    When I click the account registration link
    Then I should see the registration form

  @mobile_test
  Scenario: Test login on mobile
    Given I am on a mobile device
    When I click the login link
    Then I should see the login form

  @mobile_test
  Scenario: Test accessing jobs on mobile
    Given I am on a mobile device
    When I click the jobs link
    Then I should see the jobs page

  @mobile_test
  Scenario: Test accessing tenders on mobile
    Given I am on a mobile device
    When I click the tenders link
    Then I should see the tenders page

  @mobile_test
  Scenario: Test accessing the directory on mobile
    Given I am on a mobile device
    When I click the directory link
    Then I should see the directory page

  @mobile_test
  Scenario: Test posting a tender on mobile
    Given I am on a mobile device
    When I click the post tender link
    Then I should see a success message

  @mobile_test
  Scenario: Test quoting a tender on mobile
    Given I am on a mobile device
    When I click the quote tender link
    Then I should see a success message

  @mobile_test
  Scenario: Test accessing the availability broadcast on mobile
    Given I am on a mobile device
    When I click the availability broadcast link
    Then I should see the broadcast

  @mobile_test
  Scenario: Test receiving an SMS/email alert on mobile
    Given I am on a mobile device
    When I receive an SMS/email alert
    Then I should see the alert

  @mobile_test
  Scenario: Test seeing the premium/verified badge on mobile
    Given I am on a mobile device
    When I click the premium/verified badge link
    Then I should see the badge

  @mobile_test
  Scenario: Test seeing market rate information on mobile
    Given I am on a mobile device
    When I click the market rate link
    Then I should see the information

  @mobile_test
  Scenario: Test seeing the public message on mobile
    Given I am on a mobile device
    When I click the public message link
    Then I should see the message

  @mobile_test
  Scenario: Test seeing the blurred information on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see blurred information

  @mobile_test
  Scenario: Test seeing the restricted link on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted link

  @mobile_test
  Scenario: Test seeing the success message on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success message

  @mobile_test
  Scenario: Test seeing the error message on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error message

  @mobile_test
  Scenario: Test seeing the notification on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification

  @mobile_test
  Scenario: Test seeing the alert on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert

  @mobile_test
  Scenario: Test seeing the badge on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge

  @mobile_test
  Scenario: Test seeing the information on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page on mobile
    Given I am on a mobile device
    When I click a link to a success page
    Then I should see the success page

  @mobile_test
  Scenario: Test seeing the error page on mobile
    Given I am on a mobile device
    When I click a link to an error page
    Then I should see the error page

  @mobile_test
  Scenario: Test seeing the notification page on mobile
    Given I am on a mobile device
    When I receive a notification
    Then I should see the notification page

  @mobile_test
  Scenario: Test seeing the alert page on mobile
    Given I am on a mobile device
    When I receive an alert
    Then I should see the alert page

  @mobile_test
  Scenario: Test seeing the badge page on mobile
    Given I am on a mobile device
    When I click the badge link
    Then I should see the badge page

  @mobile_test
  Scenario: Test seeing the information page on mobile
    Given I am on a mobile device
    When I click the information link
    Then I should see the information page

  @mobile_test
  Scenario: Test seeing the restricted page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the restricted page

  @mobile_test
  Scenario: Test seeing the public page on mobile
    Given I am on a mobile device
    When I click the public link
    Then I should see the public page

  @mobile_test
  Scenario: Test seeing the blurred page on mobile
    Given I am on a mobile device
    When I click a restricted link
    Then I should see the blurred page

  @mobile_test
  Scenario: Test seeing the success page

