TRADEHUB_BUSINESS_KNOWLEDGE = """
TRADEHUB SYSTEM RULES & BUSINESS LOGIC:

1. User Roles & Account Creation:
   - Account Types: Trade Business (Plumbing, Electrical, Carpentry, Painting, etc.).
   - Registration fields: Name, Business Name, Email, Phone, Primary Trade, Suburb/Location, Password.
   - Requires activation email link before first login.

2. ABN / Business Verification Rules:
   - Users CAN create an account and browse jobs, tenders, and directory WITHOUT an ABN.
   - Attempting to Post Job, Quote/Apply for Job, Post Tender, Quote on Tender, or List Availability MUST trigger an ABN prompt.
   - Once valid ABN is added and saved, restrictions are lifted.

3. Job vs. Tender Lifecycle:
   - Job Lifecycle: Open -> Pending -> Accepted -> Confirmed -> Completed.
   - Jobs are single-trade quick requests (e.g., rough-in assistance).
   - Tenders are multi-trade project packages (e.g., 3 Townhouse Development requiring Plumbing, Electrical, Carpentry) with attached plans and trade-specific budgets.

4. Free vs. Premium Tier Restrictions:
   - Free Tier: Limited to 15km radius, limited tender browsing/posting allowances, limited quote counts, standard in-app notifications.
   - Premium Tier: Unlimited radius, unlimited jobs/tenders/quotes, availability broadcasts, SMS/email alerts, verified badge, market rate data.

5. Subcontracting Availability ("List Subcontracting Dates"):
   - Allows businesses with spare labour to list future available dates (e.g., "2 plumbers available Wed/Thu").
   - Integrated into Directory Search filter: "Show only profiles with upcoming available dates".

6. Security & Logged-Out Restrictions:
   - Public/Logged-Out users visiting Tenders pages MUST see blurred/restricted information and be prompted to Sign Up/Login.
"""

TRADEHUB_RAW_INSTRUCTIONS = """
1. Create a New Account
[ ] Visit the TradeHub homepage.

[ ] Click the option to create/register an account.

[ ] Create a new Trade Business account.

[ ] Enter your name.

[ ] Enter a business name.

[ ] Enter an email address.

[ ] Enter a phone number if requested.

[ ] Select your primary trade.

[ ] Enter your suburb/location.

[ ] Create a password.

[ ] Accept any required terms.

[ ] Complete account registration.

[ ] Check if all instructions are easy to understand.

[ ] Check if required fields are clearly identified.

[ ] Check if incorrect fields show useful error messages.

[ ] Check if the primary trade selection works correctly.

[ ] Check if the location/suburb search works correctly.

[ ] Check if the page displays correctly on mobile.

[ ] Check if registration completes successfully.

[ ] Check if the user receives the correct activation/verification email.

[ ] Check if the activation email is easy to understand.

[ ] Check if the activation link works.

[ ] Check if after activation, you can log in successfully.

2. Login and Logout
[ ] Log out of TradeHub.

[ ] Log back in using the account you created.

[ ] Close the browser and reopen TradeHub.

[ ] Check whether login/session behaviour seems correct.

[ ] Test the "Forgot Password" function.

[ ] Check whether the password reset email arrives.

[ ] Check whether the password reset link works.

[ ] Check for unexpected logouts.

[ ] Check for login loops.

[ ] Check for incorrect redirects.

[ ] Check for password reset issues.

[ ] Check for pages that remain accessible when logged out but should require an account.

3. Dashboard
[ ] Make sure your name/business information displays correctly.

[ ] Check the date/day display.

[ ] Check the profile information/card.

[ ] Check Profile Public/Private controls.

[ ] Check the ABN verification status area.

[ ] Check the profile views statistic.

[ ] Check open jobs in your area.

[ ] Check unread message count.

[ ] Check Recent Listings.

[ ] Click each dashboard link.

[ ] Confirm each link takes you to the correct page.

[ ] Check for missing information.

[ ] Check for incorrect counts.

[ ] Check for overlapping text.

[ ] Check for empty areas.

[ ] Check for buttons that cannot be clicked.

[ ] Check for incorrect mobile layouts.

[ ] Check for information that does not update after actions are completed.

4. Edit Your Business Profile
[ ] View your profile.

[ ] Click Edit Profile.

[ ] Add or edit your business description.

[ ] Add your business phone number.

[ ] Add your website if available.

[ ] Add your service/location information.

[ ] Add your hourly or day rate if available.

[ ] Upload/change your profile image or logo.

[ ] Edit any other available business information.

[ ] Save the profile.

[ ] Refresh the page.

[ ] Confirm all changes remain saved.

[ ] View the public version of the profile.

[ ] Check that the public profile displays the correct information.

[ ] Change the profile between Public and Private.

[ ] Confirm the visibility setting behaves correctly.

[ ] Edit the profile a second time to make sure information can be changed after initial setup.

5. ABN / Business Verification
[ ] Browse jobs without an ABN.

[ ] Browse tenders without an ABN.

[ ] Browse the Directory without an ABN.

[ ] Post a job without an ABN and verify system requests ABN.

[ ] Apply/quote for a job where applicable without an ABN and verify system requests ABN.

[ ] Post a tender without an ABN and verify system requests ABN.

[ ] Quote on a tender without an ABN and verify system requests ABN.

[ ] List subcontracting availability without an ABN and verify system requests ABN.

[ ] Enter an ABN.

[ ] Save it.

[ ] Confirm the ABN is attached to the account.

[ ] Repeat an action that was previously restricted.

[ ] Confirm you can now continue.

6. Post a Job
[ ] Enter a job title.

[ ] Select the required trade.

[ ] Enter a detailed description.

[ ] Enter the job location.

[ ] Enter the date.

[ ] Enter the expected duration.

[ ] Enter the rate/budget if applicable.

[ ] Add an emergency/urgent tag if available.

[ ] Upload an attachment/photo if available.

[ ] Submit the job.

[ ] Confirm you receive a successful submission message.

[ ] Confirm the job appears in your account.

[ ] Check whether it correctly shows as awaiting admin approval if approval is required.

[ ] Open the job.

[ ] Check that all information you entered appears correctly.

[ ] Edit the job.

[ ] Change the description.

[ ] Change the date.

[ ] Change the price/rate.

[ ] Save the changes.

[ ] Refresh the page.

[ ] Confirm the changes remain.

[ ] Test cancelling/closing the job if the option is available.

7. Browse Jobs
[ ] Open Find Jobs / Jobs.

[ ] Browse available jobs.

[ ] Search for jobs.

[ ] Filter by trade.

[ ] Filter by location/distance if available.

[ ] Open several job listings.

[ ] Return to the job search results.

[ ] Check whether your search/filter settings behave correctly.

[ ] Test the experience on mobile.

[ ] Open a job to test applying.

[ ] Apply/respond to the job.

[ ] Go backwards without becoming stuck.

[ ] Return to the jobs list.

[ ] See that your application has been submitted.

8. Test the Job Lifecycle
[ ] Business A posts a job.

[ ] Business B applies/responds.

[ ] Business A selects Business B.

[ ] Job changes to Pending.

[ ] Business B accepts.

[ ] Business A performs the final confirmation.

[ ] Job becomes Confirmed.

[ ] Job can eventually be marked Completed.

[ ] Check that both users see the correct status at every stage.

[ ] Check whether notifications are generated when the status changes.

9. List Subcontracting Availability
[ ] Go to List Subcontracting Dates / Availability.

[ ] Select future dates.

[ ] Add a description.

[ ] Enter the number/type of workers available if applicable.

[ ] Enter your rate if applicable.

[ ] Save the availability.

[ ] Confirm the dates appear on your account.

[ ] Refresh the page.

[ ] Confirm they remain saved.

[ ] Edit the dates.

[ ] Edit the description.

[ ] Remove one available date.

[ ] Add another available date.

[ ] Delete/cancel an availability listing if possible.

[ ] Search the Directory using another account.

[ ] Enable "Show only profiles with upcoming available dates".

[ ] Confirm the test business appears.

[ ] Confirm the "Available Soon" indicator appears correctly.

[ ] Confirm the available dates are correct.

10. Directory / Search Trades
[ ] Open Directory.

[ ] Search for a trade.

[ ] Search by suburb/location.

[ ] Change distance/radius.

[ ] Test available-date filtering.

[ ] Open several profiles.

[ ] Check rates.

[ ] Check reviews.

[ ] Check available dates.

[ ] Check profile descriptions.

[ ] Contact/message a business.

[ ] Confirm that the results make sense based on the filters selected.

[ ] Check the Free account radius restrictions if applicable.

11. Create a Project Tender
[ ] Enter the project name.

[ ] Enter project location.

[ ] Enter project dates.

[ ] Add the overall project description.

[ ] Upload plans.

[ ] Select multiple required trades.

[ ] Enter a separate description for each trade.

[ ] Enter a budget for each trade.

[ ] Upload trade-specific attachments if available.

[ ] Test the Limited Quotes option.

[ ] Submit the tender.

[ ] Confirm the tender appears in your account.

[ ] Check its approval/status.

[ ] Open it.

[ ] Confirm all information displays correctly.

[ ] Edit the tender.

[ ] Save changes.

[ ] Refresh and verify changes remain.

12. Browse and Quote on Tenders
[ ] Open Available Tenders using a matching trade account.

[ ] Find the tender created above.

[ ] Open it.

[ ] Confirm the relevant trade information is visible.

[ ] Submit a quote.

[ ] Enter a price.

[ ] Enter a message/description.

[ ] Upload supporting information if available.

[ ] Submit the quote.

[ ] Confirm submission was successful.

[ ] Open the tender using the account that posted it.

[ ] View received quotes.

[ ] Open the test quote.

[ ] Check business profile information.

[ ] Check quoted amount.

[ ] Contact/message the quoting business.

[ ] Check that businesses with unrelated trades do not incorrectly see restricted trade information where applicable.

13. Messages
[ ] Send a message from Account A to Account B.

[ ] Open Account B.

[ ] Confirm the message appears.

[ ] Reply.

[ ] Confirm Account A receives the reply.

[ ] Send multiple messages.

[ ] Test long messages.

[ ] Test short messages.

[ ] Test messaging from a job.

[ ] Test messaging from a tender if available.

[ ] Check unread message counts.

[ ] Open the conversation.

[ ] Confirm unread status changes correctly.

[ ] Test messaging functionality on mobile.

14. Notifications
[ ] Generate activities between two accounts (job application, selection, acceptance, tender quote, message, availability activity).

[ ] Check that notifications appear.

[ ] Check if notification wording makes sense.

[ ] Check if clicking the notification takes you to the correct item.

[ ] Check if read/unread behaviour works.

[ ] Check if notification counts update.

[ ] Check if old notifications remain accessible.

15. Reviews
[ ] Mark the job Completed.

[ ] Check whether the review option appears.

[ ] Leave a review.

[ ] Submit a rating.

[ ] Add written feedback.

[ ] Confirm the review appears on the appropriate business profile.

[ ] Test the ability to respond to a review if available.

[ ] Check the Reliability Review process associated with late cancellations if applicable.

16. Free vs Premium Restrictions
[ ] Check Free account 15 km radius restriction.

[ ] Check Free account tender browsing.

[ ] Check Free account free tender posting allowance.

[ ] Check Free account tender quote allowance.

[ ] Check Free account quote limits.

[ ] Check Free account in-app notifications.

[ ] Check Free account jobs access.

[ ] Check Free account directory access.

[ ] Check Premium account unlimited radius.

[ ] Check Premium account unlimited jobs.

[ ] Check Premium account unlimited tender access.

[ ] Check Premium account unlimited tender quotes.

[ ] Check Premium account unlimited tender posting.

[ ] Check Premium account availability broadcasts.

[ ] Check Premium account SMS/email alerts where applicable.

[ ] Check Premium account premium/verified badge functionality.

[ ] Check Premium account market rate information where available.

[ ] Confirm Premium users are not accidentally shown Free restrictions.

17. Public / Logged-Out Testing
[ ] Visit the homepage while logged out.

[ ] Open the public Tenders page while logged out.

[ ] Open an individual public tender while logged out.

[ ] Check blurred/restricted information while logged out.

[ ] Try clicking actions requiring an account while logged out.

[ ] Confirm TradeHub asks you to sign up/login when clicking restricted actions.

[ ] Visit public SEO tender pages where available while logged out.

[ ] Test navigation throughout the public website while logged out.

[ ] Check for any private information that is accidentally visible while logged out.

18. Mobile Testing
[ ] Test account registration on mobile.

[ ] Test login on mobile.

[ ] Test Dashboard on mobile.

[ ] Test Edit Profile on mobile.

[ ] Test Directory on mobile.

[ ] Test Find Jobs on mobile.

[ ] Test Open Job on mobile.

[ ] Test Apply for Job on mobile.

[ ] Test Return from Apply for Job on mobile.

[ ] Test Post Job on mobile.

[ ] Test View Tender on mobile.

[ ] Test Submit Tender Quote on mobile.

[ ] Test Messages on mobile.

[ ] Test Notifications on mobile.

[ ] Test List Availability on mobile.

[ ] Check for text overlapping on mobile.

[ ] Check for buttons outside the screen on mobile.

[ ] Check for buttons covered by menus on mobile.

[ ] Check for tiny buttons on mobile.

[ ] Check for menus that will not close on mobile.

[ ] Check for keyboard covering input fields on mobile.

[ ] Check for pages that cannot scroll on mobile.

[ ] Check for pop-ups/drawers that cannot be closed on mobile.

[ ] Check for back buttons that do not work on mobile.

[ ] Check for forms losing information on mobile.

[ ] Check for layouts that look significantly different from desktop.

19. Navigation Test
[ ] Test link for Dashboard.

[ ] Test link for Jobs.

[ ] Test link for Find Jobs.

[ ] Test link for Post a Job.

[ ] Test link for Tenders.

[ ] Test link for Post Project Tender.

[ ] Test link for Directory.

[ ] Test link for Profile.

[ ] Test link for Messages.

[ ] Test link for Notifications.

[ ] Test link for Availability.

[ ] Test link for Upgrade/Premium.

[ ] Test link for Logout.

20. Try to Break Things
[ ] Submit an empty form.

[ ] Enter very long descriptions.

[ ] Enter unusual characters.

[ ] Double-click Submit.

[ ] Refresh during a form.

[ ] Click Back after submitting.

[ ] Upload a large attachment.

[ ] Upload an unsupported file type.

[ ] Select a date in the past.

[ ] Enter an incorrect ABN.

[ ] Open the same account on two browser tabs.

[ ] Rapidly switch between pages.

[ ] Try accessing a page through its URL while logged out.

[ ] Try performing Premium actions with a Free account.
"""