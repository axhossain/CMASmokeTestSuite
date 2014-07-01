Feature: MFA EMAIL Channel API

  Background:
    * connect to the server

  @mfa_direct @mfa_fsg @not_app_mfa @email_protocol

  Scenario: Create one time pass code by destination ID and send it to user using "EMAIL" channel
    * delete destination
    * create destination
    * get destination
    * read destination id
    * remove "Emails.txt" file
    * create one time pass code for destination ID retrieved in previous steps
    * validate response code "201" and response message "Created"
    * retrieve messages to "Emails.txt" and check if file contains one time pass code
    * if no email received, print warning

  @mfa_direct @mfa_fsg @not_app_mfa @email_protocol

  Scenario: Create one time pass code and send it to user using "EMAIL" channel
    * delete destination
    * create destination
    * remove "Emails.txt" file
    * create one time pass code
    * validate response code "201" and response message "Created"
    * retrieve messages to "Emails.txt" and check if file contains one time pass code
    * if no email received, print warning

   @mfa_direct @mfa_fsg @not_app_mfa @email_protocol

  Scenario: Push one time pass code and send it to user using "EMAIL" channel
    * delete destination
    * create destination
    * remove "Emails.txt" file
    * push "123456" one time pass code
    * validate that one time pass code response value is "123456"
    * retrieve messages to "Emails.txt" and check if file contains one time pass code
    * if no email received, print warning

   @mfa_direct @mfa_fsg @not_app_mfa @email_protocol
  Scenario: Create one time pass code of specified length and send it to user using "EMAIL" channel
    * delete destination
    * create destination
    * remove "Emails.txt" file
    * create one time pass code of length "9"
    * validate response when one time pass code length is "9"
    * retrieve messages to "Emails.txt" and check if file contains one time pass code
    * if no email received, print warning

   @mfa_direct @mfa_fsg @not_app_mfa @email_protocol
  Scenario: Create and send activation confirmation by destination ID using "EMAIL" channel
    * delete destination
    * create destination
    * get destination
    * remove "Emails.txt" file
    * read destination id
    * create activation confirmation for destination ID retrieved in previous step
    * validate response code "201" and response message "Created"
    * retrieve messages to "Emails.txt" and check if file contains "Congratulations! Your email has been activated."
    * if no email received, re-create  activation confirmation for destination ID retrieved in previous steps


