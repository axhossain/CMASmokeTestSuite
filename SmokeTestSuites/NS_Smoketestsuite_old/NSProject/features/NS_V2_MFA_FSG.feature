Feature: NS_V2_MFA_FSG

  Background:
    Given Connect to the server

  @dest_all_cases1 @dest_create_cases @temp1
  Scenario: Create Destination
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
    |key         | value            |
    |contactInfo | 6509336942       |
    |nickname    | Smoke Test       |
    |protocol    | SMS              |
    |activated   | true             |
    |default     | false            |
    And Validate successful create destination response
    Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
      |key         | value            |
      |contactInfo | 6509336942       |
      |nickname    | Smoke Test       |
      |protocol    | SMS              |
      |activated   | true             |
      |default     | false            |
    And Validate create destination response in case of data conflict

  @dest_all_cases1 @dest_delete_cases
  Scenario: Delete Destination
    Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
      |key         | value            |
      |contactInfo | 6509336942       |
      |nickname    | Smoke Test       |
      |protocol    | SMS              |
      |activated   | true             |
      |default     | false            |
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    And Validate successful delete destination response
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    And Validate delete destination response when entity is not found

  @dest_all_cases1 @dest_get_cases
    Scenario: Get Destination
      Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
      Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
        |key         | value            |
        |contactInfo | 6509336942       |
        |nickname    | Smoke Test       |
        |protocol    | SMS              |
        |activated   | true             |
        |default     | false            |
      Then Get customer destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
      And Validate successful get destination response against following test data
        |key         | value            |
        |contactInfo | 6509336942       |
        |nickname    | Smoke Test       |
        |protocol    | SMS              |
        |activated   | true             |
        |default     | false            |

  @dest_all_cases1 @dest_update_cases
  Scenario: Update customer Destination
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
      |key         | value            |
      |contactInfo | 6509336942       |
      |nickname    | Smoke Test       |
      |protocol    | SMS              |
      |activated   | true             |
      |default     | false            |
     And Update destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
     |key         | value            |
     |contactInfo | 6509336942       |
     |nickname    | Smoke Test       |
     |protocol    | VOICE            |
     |activated   | true             |
     |default     | false            |
    Then Get customer destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    And Validate successful update destination response against following test data
     |key1         | value            |
     |contactInfo1 | 6509336942       |
     |nickname1    | Smoke Test       |
     |protocol1    | SMS              |
     |activated1   | true             |
     |default1     | false            |
     |key2         | value            |
     |contactInfo2 | 6509336942       |
     |nickname2    | Smoke Test       |
     |protocol2    | VOICE            |
     |activated2   | true             |
     |default2     | false            |


  @help_command  @SMS_channel   @all_commands
  Scenario: Execute HELP command
    And Clean up adb buffer
    Then Remove "SMS.txt" file
    Then execute "Help" command
    And Wait for "30" seconds
    Then Retrieve SMS messages and save them in "SMS.txt"
    And Check if "SMS.txt" contains "BAL, BAL ALL, BAL CHK"

  @bal_command   @SMS_channel   @all_commands
  Scenario: Execute BAL command
    And Clean up adb buffer
    Then Remove "SMS.txt" file
    Then execute "Bal" command
    And Wait for "30" seconds
    Then Retrieve SMS messages and save them in "SMS.txt"
    And Check if "SMS.txt" contains "Curr bal"

  @create_activation_code  @SMS_channel
  Scenario: Create activation code and send it to user
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    And Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
      |key         | value            |
      |contactInfo | 6509336942       |
      |nickname    | Smoke Test       |
      |protocol    | SMS              |
      |activated   | true             |
      |default     | false            |
    And Clean up adb buffer
    Then Create activation code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and following request properties:
      |key         | value            |
      |contactInfo | 6509336942       |
      |protocol    | SMS              |
    And Validate successful create activation code response
    Then Remove "SMS.txt" file
    And Wait for "15" seconds
    Then Retrieve SMS messages and save them in "SMS.txt"
    And Check if "SMS.txt" contains activation code

  @create_one_time_pass_code @SMS_channel
  Scenario: Create one time pass code and send it to user using "SMS" channel
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    And Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
      |key         | value            |
      |contactInfo | 6509336942       |
      |nickname    | Smoke Test       |
      |protocol    | SMS              |
      |activated   | true             |
      |default     | false            |
    And Clean up adb buffer
    Then Create one time pass code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and following request properties:
      |key         | value            |
      |contactInfo | 6509336942       |
      |protocol    | SMS              |
    And Validate one time pass code response
    Then Remove "SMS.txt" file
    And Wait for "15" seconds
    Then Retrieve SMS messages and save them in "SMS.txt"
    And Check if "SMS.txt" contains one time pass code

  @create_OOB @SMS_channel
    Scenario: Create and sends OOBCode using "SMS" channel
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
        |key         | value            |
        |contactInfo | 6509336942       |
        |nickname    | Smoke Test       |
        |protocol    | SMS              |
        |activated   | true             |
        |default     | false            |
    Then Get customer destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    And Clean up adb buffer
    And Read destination id
    Then Create OOB code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved in previous step
    And Validate OOB code response
    Then Remove "SMS.txt" file
    And Wait for "15" seconds
    Then Retrieve SMS messages and save them in "SMS.txt"
    And Get OOB code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved earlier
    And Check if "SMS.txt" contains OOBCode
    And Check if "SMS.txt" contains "Identity confirmed."

   @update_OOB @SMS_channel
   Scenario: Get OOBCode using "SMS" channel
     Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
     Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
       |key         | value            |
       |contactInfo | 6509336942       |
       |nickname    | Smoke Test       |
       |protocol    | SMS              |
       |activated   | true             |
       |default     | false            |
     Then Get customer destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
     And Clean up adb buffer
     And Read destination id
     Then Create OOB code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved in previous step
     And Validate OOB code response
     Then Remove "SMS.txt" file
     And Wait for "15" seconds
     Then Retrieve SMS messages and save them in "SMS.txt"
     And Get OOB code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved earlier
     And Check if "SMS.txt" contains OOBCode
     And Check if "SMS.txt" contains "Identity confirmed."
     And Copy OOB to temporarily location
     Then Update OOB code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved in previous steps
     And Validate OOB code response
     Then Remove "SMS.txt" file
     And Wait for "15" seconds
     Then Retrieve SMS messages and save them in "SMS.txt"
     And Get OOB code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved earlier
     And Check if "SMS.txt" contains OOBCode
     And Check if "SMS.txt" contains "Identity confirmed."
     And Confirm that OOB code was changed

   @create_activation_confirmation  @SMS_channel
   Scenario: Create and send activation confirmation by destination ID using "SMS" channel
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
      |key         | value            |
      |contactInfo | 6509336942       |
      |nickname    | Smoke Test       |
      |protocol    | SMS              |
      |activated   | true             |
      |default     | false            |
    Then Get customer destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    And Clean up adb buffer
    And Read destination id
    Then Create activation confirmation and for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved in previous step
    And Validate create activation confirmation response
    Then Remove "SMS.txt" file
    And Wait for "15" seconds
    Then Retrieve SMS messages and save them in "SMS.txt"
    And Check if "SMS.txt" contains "Device Activated"

  @create_reset_password @SMS_channel
  Scenario: Create, reset and send password to the user using "SMS"channel
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
      |key         | value            |
      |contactInfo | 6509336942       |
      |nickname    | Smoke Test       |
      |protocol    | SMS              |
      |activated   | true             |
      |default     | false            |
    Then Get customer destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    And Read destination id
    Then Create password for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved in previous step
    And Validate password response
    Then Remove "SMS.txt" file
    And Wait for "15" seconds
    Then Retrieve SMS messages and save them in "SMS.txt"
    And Verify that "SMS.txt" contains password
    Then Create password for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved in previous step
    And Validate password response
    Then Remove "SMS.txt" file
    And Wait for "10" seconds
    Then Retrieve SMS messages and save them in "SMS.txt"
    And Verify that "SMS.txt" contains password


  # @create_OOB  @temp
  #Scenario: Create and sends OOBCode using "EMAIL" channel  Not Supported
  # Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
  # Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
  #    |key         | value                         |
  #    |contactInfo | ns.ifs.test@gmail.com         |
  #    |nickname    | Smoke Test                    |
  #    |protocol    | EMAIL                         |
  #    |activated   | true                          |
  #    |default     | false                         |
  #Then Get customer destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
  #And Read destination id
  #Then Create OOB code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved in previous step
  #And Validate OOB code response
  #Then Remove "Emails.txt" file
  #And Wait for "30" seconds
  #And Retrieve messages from e-mail "ns.ifs.test@gmail.com" with password "nsifstest" and save them in Emails.txt


  @create_one_time_pass_code   @email_channel
   Scenario: Create one time pass code by destination ID and send it to user using "EMAIL" channel
   Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
   Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
     |key         | value                         |
     |contactInfo | ns.ifs.test@gmail.com         |
     |nickname    | Smoke Test                    |
     |protocol    | EMAIL                         |
     |activated   | true                          |
     |default     | false                         |
    Then Get customer destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    And Read destination id
    Then Create one time pass code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved in previous step
    And Validate one time pass code response
    Then Remove "Emails.txt" file
    And Wait for "30" seconds
    And Retrieve messages from e-mail "ns.ifs.test@gmail.com" with password "nsifstest1" and save them in Emails.txt
    And Check if "Emails.txt" contains one time pass code

   @create_one_time_pass_code  @email_channel
  Scenario: Create one time pass code and send it to user using "EMAIL" channel
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
      |key         | value                         |
      |contactInfo | ns.ifs.test@gmail.com         |
      |nickname    | Smoke Test                    |
      |protocol    | EMAIL                         |
      |activated   | true                          |
      |default     | false                         |
    Then Create one time pass code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and and the following request properties:
      |key         | value                         |
      |contactInfo | ns.ifs.test@gmail.com         |
      |protocol    | EMAIL                         |
   And Validate one time pass code response
   Then Remove "Emails.txt" file
   And Wait for "30" seconds
   And Retrieve messages from e-mail "ns.ifs.test@gmail.com" with password "nsifstest1" and save them in Emails.txt
   And Check if "Emails.txt" contains one time pass code

  @create_one_time_pass_code @email_channel
  Scenario: Push one time pass code and send it to user using "EMAIL" channel
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
      |key         | value                         |
      |contactInfo | ns.ifs.test@gmail.com         |
      |nickname    | Smoke Test                    |
      |protocol    | EMAIL                         |
      |activated   | true                          |
      |default     | false                         |
    Then Push one time pass code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and and the following request properties:
      |key            | value                      |
      |contactInfo    | ns.ifs.test@gmail.com      |
      |protocol       | EMAIL                      |
      |oneTimePassCode| 123456                     |
    And Validate that one time pass code response value is "123456"
    Then Remove "Emails.txt" file
    And Wait for "40" seconds
    And Retrieve messages from e-mail "ns.ifs.test@gmail.com" with password "nsifstest1" and save them in Emails.txt
    And Check if "Emails.txt" contains one time pass code

 @create_one_time_pass_code  @email_channel
  Scenario: Create one time pass code of specified length and send it to user using "EMAIL" channel
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
      |key         | value                         |
      |contactInfo | ns.ifs.test@gmail.com         |
      |nickname    | Smoke Test                    |
      |protocol    | EMAIL                         |
      |activated   | true                          |
      |default     | false                         |
    Then Create one time pass code of specified length for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and and the following request properties:
      |key                  | value                 |
      |contactInfo          | ns.ifs.test@gmail.com |
      |protocol             | EMAIL                 |
      |oneTimePassCodeLength| 9                     |
    And Validate response when one time pass code length is "9"
    Then Remove "Emails.txt" file
    And Wait for "30" seconds
    And Retrieve messages from e-mail "ns.ifs.test@gmail.com" with password "nsifstest1" and save them in Emails.txt
    And Check if "Emails.txt" contains one time pass code

 # @create_activation_code  @email_channel @temp
 # Scenario: Create activation code and send it to user
 #   Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
 #   And Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
 #     |key         | value                        |
 #     |contactInfo | ns.ifs.test@gmail.com        |
 #     |nickname    | Smoke Test                   |
 #     |protocol    | EMAIL                        |
 #     |activated   | true                         |
 #     |default     | false                        |
 #   And Clean up adb buffer
 #   Then Create activation code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and following request properties:
 #    |key         | value                       |
 #     |contactInfo | ns.ifs.test@gmail.com       |
 #     |protocol    | SMS                         |
 #   And Validate successful create activation code response
 #   Then Remove "Emails.txt" file
 #   And Wait for "30" seconds
 #   Then Retrieve SMS messages and save them in "Emails.txt"
 #   And Check if "Emails.txt" contains activation code

  @create_activation_confirmation  @email_channel
  Scenario: Create and send activation confirmation by destination ID using "SMS" channel
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
      |key         | value                      |
      |contactInfo | ns.ifs.test@gmail.com      |
      |nickname    | Smoke Test                 |
      |protocol    | EMAIL                      |
      |activated   | true                       |
      |default     | false                      |
    Then Get customer destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    Then Remove "Emails.txt" file
    And Read destination id
    Then Create activation confirmation and for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved in previous step
    And Validate create activation confirmation response
    And Wait for "15" seconds
    And Retrieve messages from e-mail "ns.ifs.test@gmail.com" with password "nsifstest1" and save them in Emails.txt
    And Check if "Emails.txt" contains "Congratulations! Your email has been activated."

#Not supported
#@create_reset_password @email_channel @temp
#  Scenario: Create, reset and send password to the user using "SMS"channel
#    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
#    Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
#      |key         | value                       |
#      |contactInfo | ns.ifs.test@gmail.com       |
#      |nickname    | Smoke Test                  |
#      |protocol    | EMAIL                       |
#      |activated   | true                        |
#      |default     | false                       |
#    Then Get customer destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
#    And Read destination id
#    Then Create password for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved in previous step
#    And Validate password response
#    Then Remove "Emails.txt" file
#    And Wait for "15" seconds
#    Then Retrieve SMS messages and save them in "Emails.txt"
#    And Verify that "Emails.txt" contains password
#    Then Create password for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved in previous step
#    And Validate password response
#    Then Remove "SMS.txt" file
#    And Wait for "15" seconds
#   Then Retrieve SMS messages and save them in "Emails.txt"
#    And Verify that "Emails.txt" contains password

  @create_one_time_pass_code
    Scenario: Create one time pass code by destination Id and send it to user using "VOICE" channel
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    Then Create destination for FI "DI9901", product "IB", notificationApp "MFA", customer "autoNS" and the following request properties:
      |key         | value                         |
      |contactInfo | 6502041039                    |
      |nickname    | Smoke Test                    |
      |protocol    | VOICE                         |
      |activated   | true                          |
      |default     | false                         |
     Then Get customer destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
     And Read destination id
     Then Create one time pass code for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS" and destination ID retrieved in previous step
     And Validate one time pass code response

  @get_fi_customer
  Scenario: Searches for Fi Customer by using contact number, protocol and product Id under given FI
    Then Delete destination for FI "DI9901", product "IB", notificationApp "MFA" and customer "autoNS"
    Then Create destination for FI "DI9901", product "IB", notificationApp "MBL", customer "autoNS" and the following request properties:
      |key         | value            |
      |contactInfo | 6509336942       |
      |nickname    | Smoke Test       |
      |protocol    | SMS              |
      |activated   | true             |
      |default     | false            |
    And Retrieve Account entities for for FI "9901", product "IB", notificationApp "MBL" and customer "autoNS"
    And Search for the FI "DI9901" customer by using "IB" product ID, "SMS" protocol and "6509336942" contact information


  @monitoring_api @get_endpoint_status
  Scenario: Retrieves status of Notification Server
    Then Retrieve endpoint status
    And Validate successful connection

  @monitoring_api @get_SMS_status
    Scenario: Retrieves status of connection between NS and MTalk
    Then Retrieve status of SMS
    And Validate successful connection

  @monitoring_api @get_voice_status
  Scenario: Retrieves status of connection between NS and Asterisk
    Then Retrieve status of voice
    And Validate successful connection

  @monitoring_api @get_email_status
  Scenario: Retrieves status of connection between NS and the local sendmail daemon running on the NS server.
    Then Retrieve status of email
    And Validate successful connection

  @monitoring_api @get_db_status
  Scenario: Retrieves status of connection between NS and DB server.
    Then Retrieve DB status
    And Validate successful connection

  @monitoring_api @get_circuit_breaker_status
  Scenario: Retrieves status of circuit breaker
    Then Retrieve circuit breaker status
    And Validate successful connection

  @monitoring_api @get_router_status
  Scenario: Retrieves status of connection between NS QDC/LVDC and WLK server
    Then Retrieve router status
    And Validate successful connection


























