Feature: Edit Your Business Profile

Scenario: View your profile
    Given I open "https://tradehub.com.au"
    When I click on "My Account"
    Then I see "My Profile" is "Present"

Scenario: Click Edit Profile
    Given I am on the "My Profile" page
    When I click on "Edit Profile"
    Then I see "Edit Profile" is "Present"

Scenario: Add or edit your business description
    Given I am on the "Edit Profile" page
    When I enter "My business description" in "Business Description"
    Then I see "My business description" in "Business Description"

Scenario: Add your business phone number
    Given I am on the "Edit Profile" page
    When I enter "1234567890" in "Business Phone Number"
    Then I see "1234567890" in "Business Phone Number"

Scenario: Add your website if available
    Given I am on the "Edit Profile" page
    When I enter "https://www.mywebsite.com" in "Website"
    Then I see "https://www.mywebsite.com" in "Website"

Scenario: Add your service/location information
    Given I am on the "Edit Profile" page
    When I enter "Service Location" in "Service/Location"
    Then I see "Service Location" in "Service/Location"

Scenario: Add your hourly or day rate if available
    Given I am on the "Edit Profile" page
    When I enter "100" in "Hourly Rate"
    Then I see "100" in "Hourly Rate"

Scenario: Upload/change your profile image or logo
    Given I am on the "Edit Profile" page
    When I click on "Upload Profile Image"
    And I select "image.jpg" as "Profile Image"
    Then I see "image.jpg" in "Profile Image"

Scenario: Edit any other available business information
    Given I am on the "Edit Profile" page
    When I enter "New Business Description" in "Business Description"
    Then I see "New Business Description" in "Business Description"

Scenario: Save the profile
    Given I am on the "Edit Profile" page
    When I click on "Save Profile"
    Then I see "Profile Saved" is "Present"

Scenario: Refresh the page
    Given I am on the "My Profile" page
    When I press on "F5" Key
    Then I see "My Profile" is "Present"

Scenario: Confirm all changes remain saved
    Given I am on the "My Profile" page
    When I click on "Edit Profile"
    And I enter "Updated Business Description" in "Business Description"
    And I click on "Save Profile"
    And I refresh the page
    Then I see "Updated Business Description" in "Business Description"

Scenario: View the public version of the profile
    Given I am on the "My Profile" page
    When I click on "Public Profile"
    Then I see "Public Profile" is "Present"

Scenario: Check that the public profile displays the correct information
    Given I am on the "Public Profile" page
    When I see "My business description" in "Business Description"
    And I see "1234567890" in "Business Phone Number"
    And I see "https://www.mywebsite.com" in "Website"
    And I see "Service Location" in "Service/Location"
    And I see "100" in "Hourly Rate"
    And I see "image.jpg" in "Profile Image"
    Then I see "My Profile" is "Present"

Scenario: Change the profile between Public and Private
    Given I am on the "My Profile" page
    When I click on "Public Profile"
    And I click on "Private Profile"
    Then I see "Private Profile" is "Present"

Scenario: Confirm the visibility setting behaves correctly
    Given I am on the "My Profile" page
    When I click on "Public Profile"
    And I click on "Private Profile"
    Then I see "Private Profile" is "Present"

Scenario: Edit the profile a second time to make sure information can be changed after initial setup
    Given I am on the "My Profile" page
    When I click on "Edit Profile"
    And I enter "Updated Business Description" in "Business Description"
    And I click on "Save Profile"
    Then I see "Updated Business Description" in "Business Description"
