Feature: Messages

Scenario: Send a message from Account A to Account B
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "Account A" in "Username"
And I enter "Password A" in "Password"
And I click on "Login"
And I click on "Account B"
And I click on "Send Message"
And I enter "Hello, this is a test message" in "Message"
And I click on "Send"
Then I see "Message sent successfully" is "visible"

Scenario: Open Account B
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "Account A" in "Username"
And I enter "Password A" in "Password"
And I click on "Login"
And I click on "Account B"
Then I see "Account B" is "visible"

Scenario: Confirm the message appears
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "Account A" in "Username"
And I enter "Password A" in "Password"
And I click on "Login"
And I click on "Account B"
And I click on "Send Message"
And I enter "Hello, this is a test message" in "Message"
And I click on "Send"
Then I see "Hello, this is a test message" in "Messages"

Scenario: Reply
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "Account A" in "Username"
And I enter "Password A" in "Password"
And I click on "Login"
And I click on "Account B"
And I click on "Send Message"
And I enter "Hello, this is a test message" in "Message"
And I click on "Send"
And I click on "Reply"
And I enter "This is a reply" in "Reply Message"
And I click on "Send"
Then I see "This is a reply" in "Messages"

Scenario: Confirm Account A receives the reply
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "Account B" in "Username"
And I enter "Password B" in "Password"
And I click on "Login"
And I click on "Account A"
Then I see "This is a reply" in "Messages"

Scenario: Send multiple messages
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "Account A" in "Username"
And I enter "Password A" in "Password"
And I click on "Login"
And I click on "Account B"
And I click on "Send Message"
And I enter "Message 1" in "Message"
And I click on "Send"
And I click on "Send Message"
And I enter "Message 2" in "Message"
And I click on "Send"
Then I see "Message 1" in "Messages"
And I see "Message 2" in "Messages"

Scenario: Test long messages
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "Account A" in "Username"
And I enter "Password A" in "Password"
And I click on "Login"
And I click on "Account B"
And I click on "Send Message"
And I enter "This is a very long message that should be tested to ensure it is handled correctly by the system. It should be at least 1000 characters long to ensure that the system can handle long messages without any issues." in "Message"
And I click on "Send"
Then I see "This is a very long message that should be tested to ensure it is handled correctly by the system. It should be at least 1000 characters long to ensure that the system can handle long messages without any issues." in "Messages"

Scenario: Test short messages
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "Account A" in "Username"
And I enter "Password A" in "Password"
And I click on "Login"
And I click on "Account B"
And I click on "Send Message"
And I enter "Short message" in "Message"
And I click on "Send"
Then I see "Short message" in "Messages"

Scenario: Test messaging from a job
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "Account A" in "Username"
And I enter "Password A" in "Password"
And I click on "Login"
And I click on "Jobs"
And I click on "Job A"
And I click on "Send Message"
And I enter "Message from job" in "Message"
And I click on "Send"
Then I see "Message from job" in "Messages"

Scenario: Test messaging from a tender if available
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "Account A" in "Username"
And I enter "Password A" in "Password"
And I click on "Login"
And I click on "Tenders"
And I click on "Tender A"
And I click on "Send Message"
And I enter "Message from tender" in "Message"
And I click on "Send"
Then I see "Message from tender" in "Messages"

Scenario: Check unread message counts
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "Account A" in "Username"
And I enter "Password A" in "Password"
And I click on "Login"
And I click on "Account B"
And I click on "Send Message"
And I enter "Unread message" in "Message"
And I click on "Send"
Then I see "1 unread message" in "Unread Message Count"

Scenario: Open the conversation
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "Account A" in "Username"
And I enter "Password A" in "Password"
And I click on "Login"
And I click on "Account B"
Then I see "Conversation with Account B" is "visible"

Scenario: Confirm unread status changes correctly
@SmokeTest
Given I open "https://tradehub.com.au"
When I click on "Login"
And I enter "Account A" in "Username"
And I enter "Password A" in "Password"
And I click on "Login"
And I click on "Account B"
And I click on "Send Message"
And I enter "Unread message" in "Message"
And I click on "Send"
And I click on "Account B"
Then I see "0 unread messages" in "Unread Message Count"

Scenario: Test messaging functionality on mobile
@SmokeTest
Given I open "https://tradehub.com.au" on mobile
When I click on "Login"
And I enter "Account A" in "Username"
And I enter "Password A" in "Password"
And I click on "Login"
And I click on "Account B"
And I click on "Send Message"
And I enter "Mobile message" in "Message"
And I click on "Send"
Then I see "Mobile message" in "Messages"
