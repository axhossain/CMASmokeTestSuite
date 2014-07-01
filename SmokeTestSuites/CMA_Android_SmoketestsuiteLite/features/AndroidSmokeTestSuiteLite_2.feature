Feature: CMA Android Smoke Test Suite Lite - Logged Out Scenarios

  @9901
  Scenario:  More screen
    Given that I am logged out of the application
    When  I select "More" from menu
    Then  message displayed on the screen "More"

  @9901
  Scenario: Login Screen
    When  I select "Log In" from menu
    Then  message displayed on the screen "Sign up"

  @9901
  Scenario: Test cleanup
    Then  shutting down test server on the device