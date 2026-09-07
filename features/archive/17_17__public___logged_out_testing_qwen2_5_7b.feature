Feature: Public / Logged-Out Testing

Scenario: Visit the homepage while logged out
    Given I open "https://tradehub.com.au"
    When I see "TradeHub" in the page title
    Then I do not see any private information

Scenario: Open the public Tenders page while logged out
    Given I open "https://tradehub.com.au/tenders"
    When I see "Tenders" in the page title
    Then I do not see any private information

Scenario: Open an individual public tender while logged out
    Given I open "https://tradehub.com.au/tenders/individual-tender-id"
    When I see "Individual Tender Title" in the page title
    Then I do not see any private information

Scenario: Check blurred/restricted information while logged out
    Given I open "https://tradehub.com.au/tenders/individual-tender-id"
    When I see "Blurred Information" is blurred
    Then I do not see any private information

Scenario: Try clicking actions requiring an account while logged out
    Given I open "https://tradehub.com.au/tenders/individual-tender-id"
    When I click on "Apply Now" button
    Then I see "Please sign up or login to apply" message

Scenario: Confirm TradeHub asks you to sign up/login when clicking restricted actions
    Given I open "https://tradehub.com.au/tenders/individual-tender-id"
    When I click on "Apply Now" button
    Then I see "Please sign up or login to apply" message

Scenario: Visit public SEO tender pages where available while logged out
    Given I open "https://tradehub.com.au/tenders/seo-tender-id"
    When I see "SEO Tender Title" in the page title
    Then I do not see any private information

Scenario: Test navigation throughout the public website while logged out
    Given I open "https://tradehub.com.au"
    When I click on "Tenders" menu
    Then I see "Tenders" page

Scenario: Check for any private information that is accidentally visible while logged out
    Given I open "https://tradehub.com.au/tenders/individual-tender-id"
    When I do not see any private information
    Then I see "TradeHub" in the page title
