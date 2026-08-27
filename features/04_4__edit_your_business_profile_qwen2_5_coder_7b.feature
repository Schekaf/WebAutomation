Feature: Edit Your Business Profile

@SmokeTest
Scenario: View your profile
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  Then I see "Profile Information" is displayed

@SmokeTest
Scenario: Click Edit Profile
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  Then I see "Edit Profile" form is displayed

@SmokeTest
Scenario: Add or edit your business description
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "Updated business description" in "Business Description"
  And I click on "Save Profile"
  Then I see "Profile saved successfully" message

@SmokeTest
Scenario: Add your business phone number
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "1234567890" in "Business Phone Number"
  And I click on "Save Profile"
  Then I see "Profile saved successfully" message

@SmokeTest
Scenario: Add your website if available
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "https://example.com" in "Business Website"
  And I click on "Save Profile"
  Then I see "Profile saved successfully" message

@SmokeTest
Scenario: Add your service/location information
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "Location information" in "Service/Location Information"
  And I click on "Save Profile"
  Then I see "Profile saved successfully" message

@SmokeTest
Scenario: Add your hourly or day rate if available
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "100" in "Hourly Rate"
  And I click on "Save Profile"
  Then I see "Profile saved successfully" message

@SmokeTest
Scenario: Upload/change your profile image or logo
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I drag "profile_image.jpg" to "Profile Image" and drop
  And I click on "Save Profile"
  Then I see "Profile saved successfully" message

@SmokeTest
Scenario: Edit any other available business information
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "Updated information" in "Other Business Information"
  And I click on "Save Profile"
  Then I see "Profile saved successfully" message

@SmokeTest
Scenario: Save the profile
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "Updated information" in "Other Business Information"
  And I click on "Save Profile"
  Then I see "Profile saved successfully" message

@SmokeTest
Scenario: Refresh the page
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "Updated information" in "Other Business Information"
  And I click on "Save Profile"
  And I click the Go Back Button
  And I click on "My Profile"
  Then I see "Updated information" in "Other Business Information"

@SmokeTest
Scenario: Confirm all changes remain saved
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "Updated information" in "Other Business Information"
  And I click on "Save Profile"
  And I click the Go Back Button
  And I click on "My Profile"
  Then I see "Updated information" in "Other Business Information"

@SmokeTest
Scenario: View the public version of the profile
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "Updated information" in "Other Business Information"
  And I click on "Save Profile"
  And I click the Go Back Button
  And I click on "Public Profile"
  Then I see "Updated information" in "Other Business Information"

@SmokeTest
Scenario: Check that the public profile displays the correct information
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "Updated information" in "Other Business Information"
  And I click on "Save Profile"
  And I click the Go Back Button
  And I click on "Public Profile"
  Then I see "Updated information" in "Other Business Information"

@SmokeTest
Scenario: Change the profile between Public and Private
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "Updated information" in "Other Business Information"
  And I click on "Save Profile"
  And I click the Go Back Button
  And I click on "Public Profile"
  And I click on "Change Visibility"
  And I select "Private" as "Visibility"
  And I click on "Save Profile"
  Then I see "Profile saved successfully" message

@SmokeTest
Scenario: Confirm the visibility setting behaves correctly
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "Updated information" in "Other Business Information"
  And I click on "Save Profile"
  And I click the Go Back Button
  And I click on "Public Profile"
  And I click on "Change Visibility"
  And I select "Private" as "Visibility"
  And I click on "Save Profile"
  And I click the Go Back Button
  And I click on "My Profile"
  Then I do not see "Updated information" in "Other Business Information"

@SmokeTest
Scenario: Edit the profile a second time to make sure information can be changed after initial setup
  Given I open "https://tradehub.com.au"
  When I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "Updated information" in "Other Business Information"
  And I click on "Save Profile"
  And I click the Go Back Button
  And I click on "My Profile"
  And I click on "Edit Profile"
  And I enter "Updated information again" in "Other Business Information"
  And I click on "Save Profile"
  Then I see "Profile saved successfully" message
