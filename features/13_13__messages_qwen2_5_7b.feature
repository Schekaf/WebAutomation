Feature: Messages

Scenario: Send a message from Account A to Account B
    Given I open Account A
    When I click on "New Message"
    And I enter "Account B" in "Recipient"
    And I enter "Hello, this is a test message" in "Message Body"
    And I click on "Send"
    Then I see "Message sent successfully" in "Notification"

Scenario: Open Account B
    Given I open Account A
    When I click on "Account B" in "Message List"
    Then I see "Account B" in "Conversation Title"

Scenario: Confirm the message appears
    Given I open Account B
    When I see "Hello, this is a test message" in "Message Body"
    Then I see "Sent by Account A" in "Message Footer"

Scenario: Reply
    Given I open Account A
    When I click on "Reply"
    And I enter "This is a reply" in "Message Body"
    And I click on "Send"
    Then I see "Message sent successfully" in "Notification"

Scenario: Confirm Account A receives the reply
    Given I open Account B
    When I see "This is a reply" in "Message Body"
    Then I see "Sent by Account A" in "Message Footer"

Scenario: Send multiple messages
    Given I open Account A
    When I enter "Hello, this is message 1" in "Message Body"
    And I click on "Send"
    And I enter "Hello, this is message 2" in "Message Body"
    And I click on "Send"
    Then I see "Message sent successfully" in "Notification" (2 times)

Scenario: Test long messages
    Given I open Account A
    When I enter "This is a very long message that exceeds the normal length to test the functionality of the system" in "Message Body"
    And I click on "Send"
    Then I see "Message sent successfully" in "Notification"

Scenario: Test short messages
    Given I open Account A
    When I enter "Short" in "Message Body"
    And I click on "Send"
    Then I see "Message sent successfully" in "Notification"

Scenario: Test messaging from a job
    Given I open Account A
    When I click on "New Message" from "Job"
    And I enter "Account B" in "Recipient"
    And I enter "This is a message from a job" in "Message Body"
    And I click on "Send"
    Then I see "Message sent successfully" in "Notification"

Scenario: Test messaging from a tender if available
    Given I open Account A
    When I click on "New Message" from "Tender"
    And I enter "Account B" in "Recipient"
    And I enter "This is a message from a tender" in "Message Body"
    And I click on "Send"
    Then I see "Message sent successfully" in "Notification"

Scenario: Check unread message counts
    Given I open Account A
    When I see "1" in "Unread Message Count"
    Then I see "1" in "Unread Message Count"

Scenario: Open the conversation
    Given I open Account A
    When I click on "Account B" in "Message List"
    Then I see "Account B" in "Conversation Title"

Scenario: Confirm unread status changes correctly
    Given I open Account A
    When I click on "Account B" in "Message List"
    And I see "1" in "Unread Message Count"
    When I click on "Account B" in "Message List"
    And I see "0" in "Unread Message Count"

Scenario: Test messaging functionality on mobile
    Given I open Account A on mobile
    When I click on "New Message"
    And I enter "Account B" in "Recipient"
    And I enter "Hello, this is a test message" in "Message Body"
    And I click on "Send"
    Then I see "Message sent successfully" in "Notification"
