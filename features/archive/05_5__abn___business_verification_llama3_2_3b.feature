Feature: ABN / Business Verification

Scenario Outline: Browse jobs without an ABN
Given I am logged in to the system
When I browse jobs
Then I should see an error message indicating that I need to verify my ABN

Scenario Outline: Browse tenders without an ABN
Given I am logged in to the system
When I browse tenders
Then I should see an error message indicating that I need to verify my ABN

Scenario Outline: Browse the Directory without an ABN
Given I am logged in to the system
When I browse the Directory
Then I should see an error message indicating that I need to verify my ABN

Scenario Outline: Post a job without an ABN and verify system requests ABN
Given I am logged in to the system
When I post a job
Then the system should request my ABN

Scenario Outline: Apply/quote for a job where applicable without an ABN and verify system requests ABN
Given I am logged in to the system
When I apply/quote for a job
Then the system should request my ABN

Scenario Outline: Post a tender without an ABN and verify system requests ABN
Given I am logged in to the system
When I post a tender
Then the system should request my ABN

Scenario Outline: Quote on a tender without an ABN and verify system requests ABN
Given I am logged in to the system
When I quote on a tender
Then the system should request my ABN

Scenario Outline: List subcontracting availability without an ABN and verify system requests ABN
Given I am logged in to the system
When I list subcontracting availability
Then the system should request my ABN

Scenario Outline: Enter an ABN
Given I am logged in to the system
When I enter my ABN
Then I should see a success message indicating that my ABN has been verified

Scenario Outline: Save it
Given I am logged in to the system and have entered my ABN
When I save my ABN
Then I should see a success message indicating that my ABN has been saved

Scenario Outline: Confirm the ABN is attached to the account
Given I am logged in to the system and have saved my ABN
When I confirm my ABN is attached to the account
Then I should see a success message indicating that my ABN is attached to the account

Scenario Outline: Repeat an action that was previously restricted
Given I am logged in to the system and have entered my ABN
When I repeat an action that was previously restricted
Then I should see an error message indicating that I need to re-verify my ABN

Scenario Outline: Confirm you can now continue
Given I am logged in to the system and have re-verified my ABN
When I confirm I can now continue
Then I should see a success message indicating that I can continue
