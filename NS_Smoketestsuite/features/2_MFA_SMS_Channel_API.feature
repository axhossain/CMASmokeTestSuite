Feature: MFA SMS Channel API

  Background:
    * connect to the server

  @mfa_direct @mfa_fsg @not_app_mfa @sms_protocol

  Scenario: Create activation code and send it to user
    * delete destination
    * create destination
    * clean up adb buffer
    * remove "SMS.txt" file
    * create activation code
    * validate response code "201" and response message "Created"
    * retrieve SMS messages to "SMS.txt" and check if file contains activation code

  @mfa_direct @mfa_fsg @not_app_mfa @sms_protocol

  Scenario: Create one time pass code and send it to user using "SMS" channel
    * delete destination
    * create destination
    * clean up adb buffer
    * remove "SMS.txt" file
    * create one time pass code
    * validate response code "201" and response message "Created"
    * retrieve SMS messages to "SMS.txt" and check if file contains one time pass code


   @mfa_direct @mfa_fsg @not_app_mfa @sms_protocol

  Scenario: Create and sends OOBCode using "SMS" channel
    * delete destination
    * create destination
    * get destination
    * clean up adb buffer
    * read destination id
    * remove "SMS.txt" file
    * create OOB code for destination ID retrieved in previous step
    * validate response code "201" and response message "Created"
    * get OOB code for destination ID retrieved earlier
    * retrieve SMS messages to "SMS.txt" and check if file contains OOBCode
    * retrieve SMS messages to "SMS.txt" and check if file contains "Identity confirmed."

   @mfa_direct @mfa_fsg @not_app_mfa @sms_protocol

  Scenario: Update and retrieve OOBCode using "SMS" channel
    * delete destination
    * create destination
    * get destination
    * clean up adb buffer
    * remove "SMS.txt" file
    * read destination id
    * create OOB code for destination ID retrieved in previous step
    * validate response code "201" and response message "Created"
    * get OOB code for destination ID retrieved earlier
    * retrieve SMS messages to "SMS.txt" and check if file contains OOBCode
    * retrieve SMS messages to "SMS.txt" and check if file contains "Identity confirmed."
    * copy OOB to temporarily location
    * update OOB code for destination ID retrieved in previous steps
    * validate response code "204" and response message "No Content"

   @mfa_direct @mfa_fsg @not_app_mfa @sms_protocol

  Scenario: Create and send activation confirmation by destination ID using "SMS" channel

    * delete destination
    * create destination
    * get destination
    * clean up adb buffer
    * remove "SMS.txt" file
    * read destination id
    * create activation confirmation for destination ID retrieved in previous step
    * validate response code "201" and response message "Created"
    * retrieve SMS messages to "SMS.txt" and check if file contains "Device Activated"

   @mfa_direct @mfa_fsg @not_app_mfa @sms_protocol

  Scenario: Create password to the user using "SMS"channel
    * delete destination
    * create destination
    * get destination
    * clean up adb buffer
    * remove "SMS.txt" file
    * read destination id
    * create password for destination ID retrieved in previous step
    * validate response code "201" and response message "Created"
    * retrieve SMS messages to "SMS.txt" and check if file contains password

