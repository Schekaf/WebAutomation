Feature: Test the Job Lifecycle

Scenario: Business A posts a job
    Given I open "Job Posting Page"
    When I enter "Job Title" in "Job Title Field"
    And I enter "Job Description" in "Job Description Field"
    And I enter "Job Location" in "Job Location Field"
    And I enter "Job Salary" in "Job Salary Field"
    And I select "Job Type" as "Full Time" from "Job Type Dropdown"
    And I click on "Post Job" Button
    Then I see "Job Posted Successfully" Message
    And I see "Job Status" is "Pending" for Business A

Scenario: Business B applies/responds
    Given I open "Job Application Page"
    When I click on "Job Title" from "Job Listing"
    And I enter "Application Name" in "Application Name Field"
    And I enter "Application Email" in "Application Email Field"
    And I enter "Application Message" in "Application Message Field"
    And I click on "Apply" Button
    Then I see "Application Sent Successfully" Message
    And I see "Job Status" is "Pending" for Business B

Scenario: Business A selects Business B
    Given I open "Job Application Page"
    When I click on "Business B" from "Applicants List"
    And I click on "Select" Button
    Then I see "Business B Selected" Message
    And I see "Job Status" is "Pending" for Business A

Scenario: Job changes to Pending
    Given I open "Job Application Page"
    When I see "Job Status" is "Pending" for Business A
    Then I see "Job Status" is "Pending" for Business B

Scenario: Business B accepts
    Given I open "Job Application Page"
    When I click on "Accept" Button
    Then I see "Job Status" is "Pending" for Business B
    And I see "Job Status" is "Pending" for Business A

Scenario: Business A performs the final confirmation
    Given I open "Job Application Page"
    When I click on "Confirm" Button
    Then I see "Job Status" is "Confirmed" for Business A
    And I see "Job Status" is "Confirmed" for Business B

Scenario: Job becomes Confirmed
    Given I open "Job Application Page"
    When I see "Job Status" is "Confirmed" for Business A
    Then I see "Job Status" is "Confirmed" for Business B

Scenario: Job can eventually be marked Completed
    Given I open "Job Application Page"
    When I click on "Complete" Button
    Then I see "Job Status" is "Completed" for Business A
    And I see "Job Status" is "Completed" for Business B

Scenario: Check that both users see the correct status at every stage
    Given I open "Job Application Page"
    When I see "Job Status" is "Pending" for Business A
    And I see "Job Status" is "Pending" for Business B
    And I see "Job Status" is "Pending" for Business A
    And I see "Job Status" is "Pending" for Business B
    And I see "Job Status" is "Pending" for Business A
    And I see "Job Status" is "Pending" for Business B
    And I see "Job Status" is "Confirmed" for Business A
    And I see "Job Status" is "Confirmed" for Business B
    And I see "Job Status" is "Completed" for Business A
    And I see "Job Status" is "Completed" for Business B

Scenario: Check whether notifications are generated when the status changes
    Given I open "Notification Page"
    When I see "Notification" for "Job Status" change for Business A
    And I see "Notification" for "Job Status" change for Business B
