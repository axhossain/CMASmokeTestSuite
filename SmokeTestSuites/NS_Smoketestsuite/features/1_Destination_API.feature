Feature: Destination API cases

  @mfa_direct @mbl_direct @mfa_fsg @mbl_fsg @not_app_mfa @sms_protocol

  Scenario: Create Destination

    *       connect to the server
    *       delete destination
    *       create destination
    *       validate response code "201" and response message "Created"
    *       create destination
    *       validate response code "409" and response message "Conflict"


  @mfa_direct @mbl_direct @mfa_fsg @mbl_fsg @not_app_mfa @sms_protocol

  Scenario: Delete Destination

    *       connect to the server
    *       create destination
    *       delete destination
    *       validate response code "204" and response message "No Content"
    *       delete destination
    *       validate response code "404" and response message "Not Found"

  @mfa_direct @mbl_direct @mfa_fsg @mbl_fsg @not_app_mfa @sms_protocol

  Scenario: Get Destination

    *       connect to the server
    *       delete destination
    *       create destination
    *       get destination
    *       validate response

   @mfa_direct @mbl_direct @mfa_fsg @mbl_fsg @not_app_mfa @sms_protocol

  Scenario: Update customer Destination

    *       connect to the server
    *       delete destination
    *       create destination
    *       update destination with following values
      | key         | value      |
      | contactInfo | 5102988285 |
      | nickname    | Smoke Test |
      | protocol    | VOICE      |
      | activated   | true       |
      | default     | false      |
    *       get destination
    *       validate response for the following nested payload
      | key1         | value      |
      | contactInfo1 | 5102988285 |
      | nickname1    | Smoke Test |
      | protocol1    | SMS        |
      | activated1   | true       |
      | default1     | false      |
      | key2         | value      |
      | contactInfo2 | 5102988285 |
      | nickname2    | Smoke Test |
      | protocol2    | VOICE      |
      | activated2   | true       |
      | default2     | false      |
