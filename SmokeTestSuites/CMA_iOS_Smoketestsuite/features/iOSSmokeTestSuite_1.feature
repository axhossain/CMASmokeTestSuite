Feature: CMA iOS Smoke Test Suite - Logged In Scenarios

  Background: This step will be executed before each scenario
    Given I launch the app
    Given that I am logged into the application

  @9901
 Scenario: MFA OOB
 Then do nothing
#    Then  I scan "MFA_screen" and take screen shot
#    And   I touch the button "Text me"
#    Then  message displayed on the screen "We texted you at"
#    And   I take a screenshot of the "Text_Confirmation_screen"
#    And   message displayed on the screen "Success!"
#    And   I take a screenshot of the "Success_Confirmation_screen"
#    And   button displayed on the screen "Go to my accounts"
#    When  I touch the button "Go to my accounts"
#    Then  message displayed on the screen "Accounts"
#    And   I take a screenshot of the "Accounts_screen"
#
#  @9901
#  Scenario: Member number persistence
#    Given that I am logged out of the application
#    Then  "Member Number" field's "text" property value should be ""
#    And   I scan "Login_screen_with_no_persistence" and take screen shot
#    Then  I toggle save member number switch
#    And   that I am logged into the application
#    And   that I am logged out of the application
#    Then  "Member Number" field's "text" property value should be "masked"
#    And   I scan "Login_screen_with_persistence" and take screen shot
#
#  @9901
#  Scenario: Accounts
#    When I select "Accounts" from menu
#    Then I take a screenshot of the "Accounts_screen"
#    And  I pick the first account available
#    And  I scan "Account_history_screen" and take screen shot
#
#  @9901
#  Scenario: Transfers
#    When  I select "Transfers" from menu
#    And   I scan "Transfers_screen" and take screen shot
#    Then  I pick "From" and "To" accounts and take screen shot
#    And   I touch the text "Amount"
#    And   I edit the amount field in the "Transfers" screen
#    And   I touch the key on the soft keyboard "8"
#    And   I touch the key on the soft keyboard "66"
#    And   I take a screenshot of the "Transfer_Money_screen"
#    And   I touch the button "Transfer"
#    And   I take a screenshot of the "Transfer_Confirmation_screen"
#    And   I touch the button "Yes"
#    Then  message displayed on the screen "Success!"
#    And   button displayed on the screen "Go to my accounts"
#    And   I take a screenshot of the "Success_Confirmation_screen"
#
#  @9901
#  Scenario: Bill Pay
#    When  I select "Bills" from menu
#    Then  message displayed on the screen "Pay Bills"
#    And   I scan "Bill_pay_screen" and take screen shot
#    And   I touch the button "Make a new payment"
#    And   I wait "5" seconds
#    And   I take a screenshot of the "Payee_Selection_screen"
#    And   I pick the first vendor available
#    Then  message displayed on the screen "New Payment"
#    And   I touch the text "Amount"
#    And   I edit the amount field in the "Bill_pay" screen
#    And   I enter a random amount
#    And   I touch the key on the soft keyboard "66"
#    And   I take a screenshot of the "Payment_Date_screen"
#    And   I touch the button "Pay"
#    And   I take a screenshot of the "Payment_Information_prompt"
#    And   I touch the button "Yes"
#    Then  message displayed on the screen "Success!"
#    And   I take a screenshot of the "Success_Confirmation_screen"
#    And   I touch the button "Cancel payment"
#    Then  I check for prompt with heading "Confirmation" message "Are you sure you want to cancel this payment?" buttons "Yes" "No"
#    And   I take a screenshot of the "Heading_Confirmation_prompt"
#    And   I touch the button "Yes"
#    Then  message displayed on the screen "Pay Bills"
#
#  @9901
#  Scenario: Purchase Rewards
#    When  I select "Offers" from menu
#    Then  message displayed on the screen "Offers"
#    And   I scan "Cash_back_offers_screen" and take screen shot
#    Then  I pick the first offer available
#    And   I scan "Offer_detail_screen" and take screen shot
#
#  @9901
#  Scenario: Remote Deposit
#    When  I select "Deposits" from menu
#    Then  message displayed on the screen "Deposit Checks"
#    And   I take a screenshot of the "Deposit_Checks_screen"
#    And   I touch the button "Deposit"
#    Then  I edit the amount field in the "Deposit Checks" screen
#    And   I touch the key on the soft keyboard "8"
#    And   I touch the text "Deposit Checks"
#    And   I scan "scan_deposit_screen" and take screen shot
#    And   I touch the button "Cancel"
#    Then  I check for prompt with heading "Confirmation" message "Are you sure you want to cancel your deposit?" buttons "Yes" "No"
#    And   I take a screenshot of the "Heading_Confirmation_prompt"
#    And   I touch the button "Yes"
#
#  @9901
#  Scenario: More Screen
#    When  I select "More" from menu
#    And   I touch the text "Call us"
#    Then  I check for prompt with heading "" message "" buttons "Cancel" "Call"
#    And   I take a screenshot of the "Call_Us_prompt"
#    Then  I touch the button "Cancel"
#    And   I scan "More_screen_with_user_logged_in" and take screen shot

#  @9901
#  Scenario:  Locations screen
#    When  I select "Locations" from menu
#    Then  I scan "Locations_screen" and take screen shot
#    And   I enter the text in the search field with user logged out "fremont, ca"
#    Then  I should see ATM, Branch locations displayed with distance unit in miles
#    And   I take a screenshot of the "Displayed_Locations_screen"

