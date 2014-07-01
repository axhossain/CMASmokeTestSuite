Feature: MBL Commands

   @mfa_direct @mfa_fsg @mbl_direct @mbl_fsg @not_app_mfa @sms_protocol

  Scenario: Execute HELP command
    * clean up adb buffer
    * remove "SMS.txt" file
    * execute "Help" command
    * retrieve SMS messages to "SMS.txt" and check if file contains "BAL, BAL ALL, BAL CHK"
    * stop "Help" android application

   @mfa_direct @mfa_fsg @mbl_direct @mbl_fsg @not_app_mfa @sms_protocol

  Scenario: Execute BAL command
    * clean up adb buffer
    * remove "SMS.txt" file
    * execute "Bal" command
    * retrieve SMS messages to "SMS.txt" and check if file contains "Curr bal"
    * stop "Bal" android application