Feature: E2E Scenarios


  @e2e
  Scenario: MFA OOB
    Given that I am logged into the application
    And   I touch the button "Text me"
    Then  message displayed on the screen "We texted you at"
    And   message displayed on the screen "Success!"
    And   I take a screenshot of the "Success_Confirmation_screen"
    And   button displayed on the screen "Go to my accounts"
    When  I touch the button "Go to my accounts"
    Then  message displayed on the screen "Accounts"
    And   I take a screenshot of the "Accounts_screen"
    Then shutting down test server on the device