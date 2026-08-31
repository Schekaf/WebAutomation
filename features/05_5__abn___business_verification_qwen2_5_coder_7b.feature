Feature: ABN / Business Verification

@SmokeTest
Scenario: Browse jobs without an ABN
  Given I open "https://tradehub.com.au"
  When I click on "Jobs"
  Then I see "Jobs" is "visible"

@SmokeTest
Scenario: Browse tenders without an ABN
  Given I open "https://tradehub.com.au"
  When I click on "Tenders"
  Then I see "Tenders" is "visible"

@SmokeTest
Scenario: Browse the Directory without an ABN
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  Then I see "Directory" is "visible"

@NegativeTesting
Scenario: Post a job without an ABN and verify system requests ABN
  Given I open "https://tradehub.com.au"
  When I click on "Post a Job"
  And I enter "Job Title" in "Job Title Field"
  And I enter "Job Description" in "Job Description Field"
  And I click on "Submit Job"
  Then I see "ABN is required" is "visible"

@NegativeTesting
Scenario: Apply/quote for a job where applicable without an ABN and verify system requests ABN
  Given I open "https://tradehub.com.au"
  When I click on "Apply for Job"
  And I enter "Application Details" in "Application Details Field"
  And I click on "Submit Application"
  Then I see "ABN is required" is "visible"

@NegativeTesting
Scenario: Post a tender without an ABN and verify system requests ABN
  Given I open "https://tradehub.com.au"
  When I click on "Post a Tender"
  And I enter "Tender Title" in "Tender Title Field"
  And I enter "Tender Description" in "Tender Description Field"
  And I click on "Submit Tender"
  Then I see "ABN is required" is "visible"

@NegativeTesting
Scenario: Quote on a tender without an ABN and verify system requests ABN
  Given I open "https://tradehub.com.au"
  When I click on "Quote on Tender"
  And I enter "Quote Details" in "Quote Details Field"
  And I click on "Submit Quote"
  Then I see "ABN is required" is "visible"

@NegativeTesting
Scenario: List subcontracting availability without an ABN and verify system requests ABN
  Given I open "https://tradehub.com.au"
  When I click on "Subcontracting Availability"
  And I enter "Availability Details" in "Availability Details Field"
  And I click on "Submit Availability"
  Then I see "ABN is required" is "visible"

@SmokeTest
Scenario: Enter an ABN
  Given I open "https://tradehub.com.au"
  When I click on "My Account"
  And I enter "ABN" in "ABN Field"
  Then I see "ABN is required" is "visible"

@SmokeTest
Scenario: Save it
  Given I open "https://tradehub.com.au"
  When I click on "My Account"
  And I enter "ABN" in "ABN Field"
  And I click on "Save ABN"
  Then I see "ABN saved successfully" is "visible"

@SmokeTest
Scenario: Confirm the ABN is attached to the account
  Given I open "https://tradehub.com.au"
  When I click on "My Account"
  Then I see "ABN" is "visible"

@SmokeTest
Scenario: Repeat an action that was previously restricted
  Given I open "https://tradehub.com.au"
  When I click on "Post a Job"
  And I enter "Job Title" in "Job Title Field"
  And I enter "Job Description" in "Job Description Field"
  And I click on "Submit Job"
  Then I see "Job posted successfully" is "visible"

@SmokeTest
Scenario: Confirm you can now continue
  Given I open "https://tradehub.com.au"
  When I click on "Post a Job"
  And I enter "Job Title" in "Job Title Field"
  And I enter "Job Description" in "Job Description Field"
  And I click on "Submit Job"
  Then I see "Job posted successfully" is "visible"
