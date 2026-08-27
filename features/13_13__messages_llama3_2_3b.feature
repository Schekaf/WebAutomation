Feature: Messages

Scenario Outline: Send a message from Account A to Account B
  Given I am logged in as Account A
  When I send a message to Account B
  Then I should see the message appears

Scenario Outline: Reply to a message
  Given I am logged in as Account A
  And I have sent a message to Account B
  When I reply to the message
  Then I should see the reply appears

Scenario Outline: Send multiple messages
  Given I am logged in as Account A
  When I send multiple messages to Account B
  Then I should see all the messages appear

Scenario Outline: Test long messages
  Given I am logged in as Account A
  When I send a long message to Account B
  Then I should see the long message appears

Scenario Outline: Test short messages
  Given I am logged in as Account A
  When I send a short message to Account B
  Then I should see the short message appears

Scenario Outline: Test messaging from a job
  Given I am logged in as Account A
  And I have a job
  When I send a message from the job
  Then I should see the message appears

Scenario Outline: Test messaging from a tender if available
  Given I am logged in as Account A
  And I have a tender
  When I send a message from the tender
  Then I should see the message appears

Scenario Outline: Check unread message counts
  Given I am logged in as Account A
  And I have sent a message to Account B
  When I check the unread message count
  Then I should see the correct count

Scenario Outline: Open the conversation
  Given I am logged in as Account A
  And I have sent a message to Account B
  When I open the conversation
  Then I should see the conversation appears

Scenario Outline: Confirm unread status changes correctly
  Given I am logged in as Account A
  And I have sent a message to Account B
  When I update the unread status
  Then I should see the unread status changes correctly

Scenario Outline: Test messaging functionality on mobile
  Given I am logged in as Account A
  And I have a mobile device
  When I send a message on the mobile device
  Then I should see the message appears
