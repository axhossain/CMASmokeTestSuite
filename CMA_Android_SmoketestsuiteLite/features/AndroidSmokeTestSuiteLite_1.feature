Feature: CMA Android Smoke Test Suite Lite - Logged In Scenarios

  Background: This step will be executed before each scenario
    Given that I am logged into the application

  @9901
  Scenario: Accounts Screen with MFA
    When  message displayed on the screen "We need to confirm your identity"
    Then  I touch the button "Text me"
    Then  message displayed on the screen "We texted you at"
    And   message displayed on the screen "Success!"
    Then  button displayed on the screen "Go to my accounts"
    Then  I touch the button "Go to my accounts"
    Then  message displayed on the screen "Accounts"
    And   I pick the first account available
    Then  message displayed on the screen "Account History"

  Scenario: Accounts Screen without MFA
    Then  I pick the first account available
    Then  message displayed on the screen "Account History"

  @9901
  Scenario: Transfers Screen
    When  I select "Transfers" from menu
    Then  message displayed on the screen "Transfer Money"

  @9901
  Scenario: Bill Pay Screen
    When  I select "Bills" from menu
    Then  message displayed on the screen "Pay Bills"
    And   I touch the button "Make a new payment"
    Then  message displayed on the screen "Select Payee"
    And   I pick the first vendor available
    Then  message displayed on the screen "New Payment"

  @9901
  Scenario: Deposits Screen
    When  I select "Deposits" from menu
    Then  message displayed on the screen "Deposit Checks"

  @9901
  Scenario: Offers Screen
    When  I select "Offers" from menu
    Then  message displayed on the screen "Offers"

  @9901
  Scenario:  More screen
    When  I select "More" from menu
    Then  message displayed on the screen "More"
