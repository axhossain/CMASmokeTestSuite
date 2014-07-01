Feature: Monitoring API

  Background:
    * connect to the server

  @mfa_direct @mbl_direct

  Scenario: Retrieves status of Notification Server
    * retrieve endpoint status
    * validate response code "200" and response message "OK"

  @mfa_direct @mbl_direct

  Scenario: Retrieves status of connection between NS and MTalk
    * retrieve status of SMS
    * validate response code "200" and response message "OK"

   @mfa_direct

  Scenario: Retrieves status of connection between NS and Asterisk
    * retrieve status of voice
    * validate response code "200" and response message "OK"

  @mfa_direct @mbl_direct

  Scenario: Retrieves status of connection between NS and the local sendmail daemon running on the NS server.
    * retrieve status of email
    * validate response code "200" and response message "OK"

  @mfa_direct @mbl_direct

  Scenario: Retrieves status of connection between NS and DB server.
    * retrieve DB status
    * validate response code "200" and response message "OK"

   @mfa_direct @mbl_direct

  Scenario: retrieves status of circuit breaker
    * retrieve circuit breaker status
    * validate response code "200" and response message "OK"

  @mfa_direct @mbl_direct

  Scenario: Retrieves status of connection between NS QDC/LVDC and WLK server
    * retrieve router status
    * validate response code "200" and response message "OK"
