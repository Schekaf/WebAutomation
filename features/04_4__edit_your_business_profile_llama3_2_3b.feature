Feature: Edit Your Business Profile

Scenario Outline: Edit Business Profile

Given I am logged in to TradeHub
When I click Edit Profile
Then I should see the business description field

Scenario Outline: Add Business Information

Given I am logged in to TradeHub
When I click Edit Profile
Then I should see the business phone number field
And I should see the website field
And I should see the service/location information field
And I should see the hourly or day rate field
And I should see the profile image or logo field

Scenario Outline: Save and Refresh Profile

Given I am logged in to TradeHub
And I have added business information
When I click Save Profile
Then I should see the updated profile
And the page should refresh

Scenario Outline: View Public Profile

Given I am logged in to TradeHub
And I have added business information
When I click View Public Profile
Then I should see the public version of the profile
And the public profile should display the correct information

Scenario Outline: Change Profile Visibility

Given I am logged in to TradeHub
And I have added business information
When I click Change Visibility
Then I should see the Public/Private toggle
And the visibility setting should behave correctly

Scenario Outline: Edit Profile Again

Given I am logged in to TradeHub
And I have added business information
When I click Edit Profile
Then I should be able to edit the business information again
