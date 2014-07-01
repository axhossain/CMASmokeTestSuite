#Feature: CMA Android Smoke Test Suite - Logged Out Scenarios
#
#  @9901
#  Scenario: Invalid login
#    Given that I am logged out of the application
#    And   I attempt an invalid login by entering "Bad Pwd"
#    Then  I check for prompt with heading "Sorry" message "Please enter valid login credentials" buttons "OK" ""
#    Then  I wait "5" seconds
#    And   I take a screenshot of the "Invalid_Login_prompt_with_user_logged_out"
#    And   I touch the button "OK"
#
#  @9901
#  Scenario: More screen
#    When  I touch the text "More"
#    And   I touch the text "Call us"
#    Then  I check for prompt with heading "" message "" buttons "Cancel" "Call"
#    And   I take a screenshot of the "Call_Us_prompt_with_user_logged_out"
#    And   I touch the button "Cancel"
#    And   I scan "More_screen_with_user_logged_out" and take screen shot
#
#  @9901
#  Scenario: Test cleanup
#    Then shutting down test server on the device

#  @9901
#  Scenario:  Locations screen
#    When I touch the text "Locations"
#    And  I scan "Locations_screen" and take screen shot
#    And  I enter the text in the search field with user logged out "fremont, ca"
#    Then I should see ATM, Branch locations displayed with distance unit in miles
#    And   I take a screenshot of the "Displayed_Locations_screen_with_user_logged_out"

