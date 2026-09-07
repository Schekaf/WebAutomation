Feature: Public / Logged-Out Testing

@SmokeTest
Scenario: Visit the homepage while logged out
    Given I open "https://tradehub.com.au"
    Then I see "Login" is "visible"

@SmokeTest
Scenario: Open the public Tenders page while logged out
    Given I open "https://tradehub.com.au/tenders"
    Then I see "Public Tenders" is "visible"

@SmokeTest
Scenario: Open an individual public tender while logged out
    Given I open "https://tradehub.com.au/tenders/12345"
    Then I see "Tender Details" is "visible"

@SmokeTest
Scenario: Check blurred/restricted information while logged out
    Given I open "https://tradehub.com.au/tenders/12345"
    Then I do not see "Confidential Information"

@NegativeTesting
Scenario: Try clicking actions requiring an account while logged out
    Given I open "https://tradehub.com.au/tenders/12345"
    When I click on "Apply Now"
    Then I see "Sign Up/Login" is "visible"

@SmokeTest
Scenario: Confirm TradeHub asks you to sign up/login when clicking restricted actions
    Given I open "https://tradehub.com.au/tenders/12345"
    When I click on "Apply Now"
    Then I see "Sign Up/Login" is "visible"

@SmokeTest
Scenario: Visit public SEO tender pages where available while logged out
    Given I open "https://tradehub.com.au/tenders/12345"
    Then I see "SEO Meta Tags" is "visible"

@SmokeTest
Scenario: Test navigation throughout the public website while logged out
    Given I open "https://tradehub.com.au"
    When I click on "About Us"
    Then I see "About Us" is "visible"
    When I click on "Contact Us"
    Then I see "Contact Us" is "visible"

@SmokeTest
Scenario: Check for any private information that is accidentally visible while logged out
    Given I open "https://tradehub.com.au"
    Then I do not see "Private Information"
