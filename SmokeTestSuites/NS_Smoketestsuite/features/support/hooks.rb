Before('@sms_protocol') do
  $protocol="SMS"
  $contactinfo="5102988285"
end

Before('@email_protocol') do
  $protocol="EMAIL"
  $contactinfo="ns.ifs.test@gmail.com"
  $password = "nsifstest1"
end

Before('@voice_protocol') do
  $protocol="VOICE"
  $contactinfo="5102988285"
end

def set_headers
  case ENV["ROUTE"]
    when "mfa_direct"
      self.base_uri "http://pqalnsqas300.corp.intuit.net:8080"
      self.headers 'intuit_tid'=> 'jmetertests'
      self.headers 'intuit_appId'=> 'CASService'
      self.headers 'intuit_offeringId'=>'CASService'
      self.headers 'Authorization'=>'8fb5832f-2e63-4d05-b514-0401906b8c90'
      self.headers 'intuit_originatingip'=>'127.0.0.1'
      self.headers 'DI-SSL-ClientCert' => 'mtalkclient.prd.intuit.com'
      self.headers 'Content-Type' => 'application/xml'

    when "mfa_fsg"
      self.base_uri "http://services-int-sl1-qal-qydc.banking.intuit.net:80"
      self.headers 'intuit_tid'=> 'jmetertests'
      self.headers 'intuit_appId'=> 'CASService'
      self.headers 'intuit_offeringId'=>'CASService'
      self.headers 'Authorization'=>'6d4bcdc15d724bb0a476b12507f8278d'
      self.headers 'intuit_originatingip'=>'127.0.0.1'
      self.headers 'DI-SSL-ClientCert' => 'mtalkclient.prd.intuit.com'
      self.headers 'Content-Type' => 'application/xml'

    when "mbl_direct"
      self.base_uri "http://pqalnsqas303.corp.intuit.net:8080"
      self.headers 'intuit_tid'=> 'jmetertests'
      self.headers 'intuit_appId'=> 'CASService'
      self.headers 'intuit_offeringId'=>'CASService'
      self.headers 'Authorization'=>'8fb5832f-2e63-4d05-b514-0401906b8c90'
      self.headers 'intuit_originatingip'=>'127.0.0.1'
      self.headers 'DI-SSL-ClientCert' => 'mtalkclient.prd.intuit.com'
      self.headers 'Content-Type' => 'application/xml'

    when "mbl_fsg"
      self.base_uri "http://services-int-sl1-qal-qydc.banking.intuit.net:80"
      self.headers 'intuit_tid'=> 'jmetertests'
      self.headers 'intuit_appId'=> 'CASService'
      self.headers 'intuit_offeringId'=>'CASService'
      self.headers 'Authorization'=>'6d4bcdc15d724bb0a476b12507f8278d'
      self.headers 'intuit_originatingip'=>'127.0.0.1'
      self.headers 'DI-SSL-ClientCert' => 'mtalkclient.prd.intuit.com'
      self.headers 'Content-Type' => 'application/xml'
   end
end

def set_uri
  $fi_id="DI9901"
  $product="IB"
  $username="autoNS"
  $nickname="Smoke Test"
  $activated="true"
  $default="false"
  $debug=false
  case ENV["ROUTE"]
    when "mfa_direct"
      $notification_app="MFA"
      $destination_uriString = "/notificationService/v2/fis/" + $fi_id + "/products/" + $product + "/notificationApps/" + $notification_app + "/fiCustomers/" + $username + "/destinations"
      $create_activation_code_notification_uriString="/notificationService/v2/fis/"+ $fi_id +"/products/" + $product +"/notificationApps/"+ $notification_app +"/fiCustomers/"+ $username +"/activationCodeNotification"
      $create_oob_uriString="/notificationService/v2/fis/"+$fi_id+"/products/" +$product+"/notificationApps/"+$notification_app+"/fiCustomers/"+$username+"/oobCodeNotification"
      $get_oob_by_id_uriString = "/notificationService/v2/fis/"+$fi_id+"/products/" +$product+"/notificationApps/"+$notification_app+"/fiCustomers/"+$username+"/oobCodeNotification?destId="
      $create_one_time_pass_code_uriString="/notificationService/v2/fis/"+$fi_id+"/products/" +$product+"/notificationApps/"+$notification_app+"/fiCustomers/"+$username+"/oneTimePassCodeNotification"
      $update_oob_uriString = "/notificationService/v2/fis/"+$fi_id+"/products/" +$product +"/notificationApps/"+$notification_app+"/fiCustomers/"+$username+"/oobCodeNotification"
      $create_activation_confirmation_uriString ="/notificationService/v2/fis/"+$fi_id+"/products/" +$product+"/notificationApps/"+$notification_app+"/fiCustomers/"+$username+"/notification?method=sendActivationConfirmation"
      $create_password_by_dest_id_uriString="/notificationService/v2/fis/"+$fi_id+"/products/" +$product+"/notificationApps/"+$notification_app+"/fiCustomers/"+$username+"/passwordNotification"
      $sms_status_uriString = "/notificationService/v2/sms/status"
      $voice_status_uriString = "/notificationService/v2/voice/status"
      $email_status_uriString = "/notificationService/v2/email/status"
      $db_status_uriString = "/notificationService/v2/db/status"
      $circuit_breaker_status_uriString ="/notificationService/v2/circuitBreaker/status"
      $router_status_uriString ="/notificationService/v2/router/status"
      $end_point_status_uriString = "/notificationService/v2/status"
    when "mfa_fsg"
      $notification_app="MFA"
      $destination_uriString = "/v2/fis/" + $fi_id + "/products/" + $product + "/notificationApps/" + $notification_app + "/fiCustomers/" + $username + "/destinations"
      $create_activation_code_notification_uriString="/v2/fis/"+ $fi_id +"/products/" + $product +"/notificationApps/"+ $notification_app +"/fiCustomers/"+ $username +"/activationCodeNotification"
      $create_oob_uriString="/v2/fis/"+$fi_id+"/products/" +$product+"/notificationApps/"+$notification_app+"/fiCustomers/"+$username+"/oobCodeNotification"
      $get_oob_by_id_uriString = "/v2/fis/"+$fi_id+"/products/" +$product+"/notificationApps/"+$notification_app+"/fiCustomers/"+$username+"/oobCodeNotification?destId="
      $create_one_time_pass_code_uriString="/v2/fis/"+$fi_id+"/products/" +$product+"/notificationApps/"+$notification_app+"/fiCustomers/"+$username+"/oneTimePassCodeNotification"
      $update_oob_uriString = "/v2/fis/"+$fi_id+"/products/" +$product +"/notificationApps/"+$notification_app+"/fiCustomers/"+$username+"/oobCodeNotification"
      $create_activation_confirmation_uriString ="/v2/fis/"+$fi_id+"/products/" +$product+"/notificationApps/"+$notification_app+"/fiCustomers/"+$username+"/notification?method=sendActivationConfirmation"
      $create_password_by_dest_id_uriString="/v2/fis/"+$fi_id+"/products/" +$product+"/notificationApps/"+$notification_app+"/fiCustomers/"+$username+"/passwordNotification"
    when "mbl_direct"
      $notification_app="MBL"
      $destination_uriString = "/notificationService/v2/fis/" + $fi_id + "/products/" + $product + "/notificationApps/" + $notification_app + "/fiCustomers/" + $username + "/destinations"
      $sms_status_uriString = "/notificationService/v2/sms/status"
      $voice_status_uriString = "/notificationService/v2/voice/status"
      $email_status_uriString = "/notificationService/v2/email/status"
      $db_status_uriString = "/notificationService/v2/db/status"
      $circuit_breaker_status_uriString ="/notificationService/v2/circuitBreaker/status"
      $router_status_uriString ="/notificationService/v2/router/status"
      $end_point_status_uriString = "/notificationService/v2/status"
    when "mbl_fsg"
      $notification_app="MBL"
      $destination_uriString = "/v2/fis/" + $fi_id + "/products/" + $product + "/notificationApps/" + $notification_app + "/fiCustomers/" + $username + "/destinations"

  end
end






