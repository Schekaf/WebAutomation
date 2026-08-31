Feature: Messages

@SmokeTest
Scenario: Send a message from Account A to Account B
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Account B"
And I enter "Hello, this is a test message" in "Message"
And I click on "Send"
Then I see "Message sent successfully" is "visible"

@SmokeTest
Scenario: Open Account B
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Account B"
Then I see "Account B" is "visible"

@SmokeTest
Scenario: Confirm the message appears
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Account B"
And I enter "Hello, this is a test message" in "Message"
And I click on "Send"
Then I see "Hello, this is a test message" in "Messages"

@SmokeTest
Scenario: Reply
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Account B"
And I enter "Hello, this is a test message" in "Message"
And I click on "Send"
And I click on "Reply"
And I enter "This is a reply" in "Reply Message"
And I click on "Send"
Then I see "This is a reply" in "Messages"

@SmokeTest
Scenario: Confirm Account A receives the reply
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Account B"
And I enter "Hello, this is a test message" in "Message"
And I click on "Send"
And I click on "Reply"
And I enter "This is a reply" in "Reply Message"
And I click on "Send"
And I click on "Account A"
Then I see "This is a reply" in "Messages"

@SmokeTest
Scenario: Send multiple messages
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Account B"
And I enter "Message 1" in "Message"
And I click on "Send"
And I enter "Message 2" in "Message"
And I click on "Send"
And I enter "Message 3" in "Message"
And I click on "Send"
Then I see "Message 1" in "Messages"
And I see "Message 2" in "Messages"
And I see "Message 3" in "Messages"

@SmokeTest
Scenario: Test long messages
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Account B"
And I enter "This is a very long message that should be tested to ensure it is handled correctly by the system. It should be long enough to test the system's ability to handle long messages." in "Message"
And I click on "Send"
Then I see "This is a very long message that should be tested to ensure it is handled correctly by the system. It should be long enough to test the system's ability to handle long messages." in "Messages"

@SmokeTest
Scenario: Test short messages
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Account B"
And I enter "Short message" in "Message"
And I click on "Send"
Then I see "Short message" in "Messages"

@SmokeTest
Scenario: Test messaging from a job
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Job"
And I click on "Send Message"
And I enter "This is a message from a job" in "Message"
And I click on "Send"
Then I see "This is a message from a job" in "Messages"

@SmokeTest
Scenario: Test messaging from a tender if available
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Tender"
And I click on "Send Message"
And I enter "This is a message from a tender" in "Message"
And I click on "Send"
Then I see "This is a message from a tender" in "Messages"

@SmokeTest
Scenario: Check unread message counts
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Account B"
And I enter "Hello, this is a test message" in "Message"
And I click on "Send"
And I click on "Account A"
Then I see "1 unread message" in "Unread Messages"

@SmokeTest
Scenario: Open the conversation
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Account B"
And I enter "Hello, this is a test message" in "Message"
And I click on "Send"
And I click on "Account A"
And I click on "Open Conversation"
Then I see "Hello, this is a test message" in "Messages"

@SmokeTest
Scenario: Confirm unread status changes correctly
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Account B"
And I enter "Hello, this is a test message" in "Message"
And I click on "Send"
And I click on "Account A"
And I click on "Open Conversation"
And I click on "Reply"
And I enter "This is a reply" in "Reply Message"
And I click on "Send"
Then I see "0 unread messages" in "Unread Messages"

@SmokeTest
Scenario: Test messaging functionality on mobile
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "AccountA" in "Username"
And I enter "PasswordA" in "Password"
And I click on "Login"
And I click on "Account B"
And I enter "Hello, this is a test message" in "Message"
And I click on "Send"
And I click on "Account A"
And I click on "Open Conversation"
And I click on "Reply"
And I enter "This is a reply" in "Reply Message"
And I click on "Send"
Then I see "This is a reply" in "Messages"
