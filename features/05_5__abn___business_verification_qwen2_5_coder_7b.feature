Feature: ABN / Business Verification

@SmokeTest
Scenario: Browse jobs without an ABN
  Given I open "https://tradehub.com.au"
  When I click on "Jobs"
  Then I see "ABN is required" is displayed

@SmokeTest
Scenario: Browse tenders without an ABN
  Given I open "https://tradehub.com.au"
  When I click on "Tenders"
  Then I see "ABN is required" is displayed

@SmokeTest
Scenario: Browse the Directory without an ABN
  Given I open "https://tradehub.com.au"
  When I click on "Directory"
  Then I see "ABN is required" is displayed

@NegativeTesting
Scenario: Post a job without an ABN and verify system requests ABN
  Given I open "https://tradehub.com.au"
  When I click on "Post a Job"
  And I enter "Job Title" in "Job Title"
  And I enter "Job Description" in "Job Description"
  And I click on "Submit"
  Then I see "ABN is required" is displayed

@NegativeTesting
Scenario: Apply/quote for a job where applicable without an ABN and verify system requests ABN
  Given I open "https://tradehub.com.au"
  When I click on "Jobs"
  And I click on "Apply/Quote" for a job
  And I enter "Quote" in "Quote"
  And I click on "Submit"
  Then I see "ABN is required" is displayed

@NegativeTesting
Scenario: Post a tender without an ABN and verify system requests ABN
  Given I open "https://tradehub.com.au"
  When I click on "Post a Tender"
  And I enter "Tender Title" in "Tender Title"
  And I enter "Tender Description" in "Tender Description"
  And I click on "Submit"
  Then I see "ABN is required" is displayed

@NegativeTesting
Scenario: Quote on a tender without an ABN and verify system requests ABN
  Given I open "https://tradehub.com.au"
  When I click on "Tenders"
  And I click on "Quote" for a tender
  And I enter "Quote" in "Quote"
  And I click on "Submit"
  Then I see "ABN is required" is displayed

@NegativeTesting
Scenario: List subcontracting availability without an ABN and verify system requests ABN
  Given I open "https://tradehub.com.au"
  When I click on "Subcontracting"
  And I click on "List Availability"
  Then I see "ABN is required" is displayed

@SmokeTest
Scenario: Enter an ABN
  Given I open "https://tradehub.com.au"
  When I click on "My Account"
  And I click on "Edit Profile"
  And I enter "ABN" in "ABN"
  And I click on "Save"
  Then I see "ABN is successfully updated" is displayed

@SmokeTest
Scenario: Save it
  Given I open "https://tradehub.com.au"
  When I click on "My Account"
  And I click on "Edit Profile"
  And I enter "ABN" in "ABN"
  And I click on "Save"
  Then I see "ABN is successfully updated" is displayed

@SmokeTest
Scenario: Confirm the ABN is attached to the account
  Given I open "https://tradehub.com.au"
  When I click on "My Account"
  And I click on "Profile"
  Then I see "ABN" is displayed

@SmokeTest
Scenario: Repeat an action that was previously restricted
  Given I open "https://tradehub.com.au"
  When I click on "Post a Job"
  And I enter "Job Title" in "Job Title"
  And I enter "Job Description" in "Job Description"
  And I click on "Submit"
  Then I see "Job is successfully posted" is displayed

@SmokeTest
Scenario: Confirm you can now continue
  Given I open "https://tradehub.com.au"
  When I click on "Post a Job"
  And I enter "Job Title" in "Job Title"
  And I enter "Job Description" in "Job Description"
  And I click on "Submit"
  Then I see "Job is successfully posted" is displayed
