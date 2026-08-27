Feature: Browse Jobs

Scenario Outline: Browse Jobs
Given I am on the TradeHub website
When I open Find Jobs / Jobs
Then I should see the job search results page

Scenario Outline: Browse Available Jobs
Given I am on the TradeHub website
When I open Find Jobs / Jobs
And I browse available jobs
Then I should see a list of job listings

Scenario Outline: Search for Jobs
Given I am on the TradeHub website
When I open Find Jobs / Jobs
And I search for jobs
Then I should see a list of job listings matching the search criteria

Scenario Outline: Filter by Trade
Given I am on the TradeHub website
When I open Find Jobs / Jobs
And I filter by trade
Then I should see a list of job listings filtered by trade

Scenario Outline: Filter by Location/Distance
Given I am on the TradeHub website
When I open Find Jobs / Jobs
And I filter by location/distance
Then I should see a list of job listings filtered by location/distance

Scenario Outline: Open Several Job Listings
Given I am on the TradeHub website
When I open Find Jobs / Jobs
And I browse available jobs
And I open several job listings
Then I should see the details of each job listing

Scenario Outline: Return to Job Search Results
Given I am on the TradeHub website
When I open Find Jobs / Jobs
And I browse available jobs
And I open several job listings
And I return to the job search results
Then I should see the job search results page

Scenario Outline: Check Search/Filter Settings
Given I am on the TradeHub website
When I open Find Jobs / Jobs
And I browse available jobs
And I filter by trade
And I filter by location/distance
Then I should see a list of job listings filtered by both trade and location/distance

Scenario Outline: Test on Mobile
Given I am on the TradeHub website
When I open Find Jobs / Jobs
And I browse available jobs
And I open several job listings
And I test the experience on mobile
Then I should be able to navigate the job search results page on mobile

Scenario Outline: Open a Job to Test Applying
Given I am on the TradeHub website
When I open Find Jobs / Jobs
And I browse available jobs
And I open a job to test applying
Then I should see the job details page

Scenario Outline: Apply/Respond to a Job
Given I am on the TradeHub website
When I open Find Jobs / Jobs
And I browse available jobs
And I open a job to test applying
And I apply/respond to the job
Then I should see a confirmation message

Scenario Outline: Go Backwards without Becoming Stuck
Given I am on the TradeHub website
When I open Find Jobs / Jobs
And I browse available jobs
And I open several job listings
And I go backwards without becoming stuck
Then I should be able to navigate the job search results page without issues

Scenario Outline: Return to Jobs List
Given I am on the TradeHub website
When I open Find Jobs / Jobs
And I browse available jobs
And I open several job listings
And I return to the jobs list
Then I should see the job search results page

Scenario Outline: See Application Submission
Given I am on the TradeHub website
When I open Find Jobs / Jobs
And I browse available jobs
And I open a job to test applying
And I apply/respond to the job
And I return to the jobs list
Then I should see a confirmation message indicating my application has been submitted
