require 'rubygems'
require 'httparty'
require "rexml/document"

  class Webservice
    include HTTParty
    format :xml
    set_headers
    set_uri


    def delete_destination()
      response = self.class.delete($destination_uriString)
    end
    def create_destination(hash={})
      requestBody ="<ns1:Destinations xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\">
                                         <ns1:destination>
                                              <ns1:contactInfo>#{$contactinfo}</ns1:contactInfo>
                                              <ns1:nickname>#{$nickname}</ns1:nickname>
                                              <ns1:protocol>#{$protocol}</ns1:protocol>
                                              <ns1:activated>#{$activated}</ns1:activated>
                                              <ns1:default>#{$default}</ns1:default>
                                        </ns1:destination>
                    </ns1:Destinations>"
      response=self.class.post($destination_uriString,{ :body => requestBody })
    end
    def get_destination()
      response = self.class.get($destination_uriString)
    end

    def update_destination(hash={})
      requestBody ="<ns1:Destinations xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\">
                                                                                                      <ns1:destination>
                                                                                                            <ns1:contactInfo>" + hash["contactInfo"]+ "</ns1:contactInfo>
                                                                                                            <ns1:nickname>" + hash["nickname"] + "</ns1:nickname>
                                                                                                            <ns1:protocol>" + hash["protocol"] + "</ns1:protocol>
                                                                                                            <ns1:activated>" + hash["activated"] + "</ns1:activated>
                                                                                                            <ns1:default>" + hash["default"] + "</ns1:default>
                                                                                                      </ns1:destination>
                                                                                             </ns1:Destinations>"
      response = self.class.post($destination_uriString,{ :body => requestBody })
    end

    def create_activation_code_notification()
      requestBody ="<ns1:ActivationCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\">
                                                                                                  <ns1:destination>
                                                                                                          <ns1:contactInfo>"+ $contactinfo+ "</ns1:contactInfo>
                                                                                                          <ns1:protocol>" + $protocol + "</ns1:protocol>
                                                                                                          </ns1:destination>
                                                                                                  </ns1:ActivationCodeNotification>"
      response = self.class.post($create_activation_code_notification_uriString,{ :body => requestBody })
    end

    def create_one_time_pass_code_notification()
      requestBody="<ns1:OneTimePassCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\">
                                <ns1:destination>
                                     <ns1:contactInfo>" + $contactinfo + "</ns1:contactInfo>
                                     <ns1:protocol>" + $protocol + "</ns1:protocol>
                                </ns1:destination>
                  </ns1:OneTimePassCodeNotification>"

      response = self.class.post($create_one_time_pass_code_uriString,{ :body => requestBody })
    end

    def create_one_time_pass_code_notification_by_dest_id(id)
      requestBody="<ns1:OneTimePassCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\">
                             <ns1:destination><ns1:id>" + id +"</ns1:id></ns1:destination>
                  </ns1:OneTimePassCodeNotification>"
      response = self.class.post($create_one_time_pass_code_uriString,{ :body => requestBody })
    end

    def push_one_time_pass_code_notification(passCode)
      requestBody="<ns1:OneTimePassCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\">
                          <ns1:destination>
                               <ns1:contactInfo>" + $contactinfo + "</ns1:contactInfo>
                               <ns1:protocol>" + $protocol + "</ns1:protocol>
                           </ns1:destination>
                           <ns1:oneTimePassCode>" + passCode + "</ns1:oneTimePassCode>
                  </ns1:OneTimePassCodeNotification>"
      response = self.class.post($create_one_time_pass_code_uriString,{ :body => requestBody })
    end

    def create_one_time_pass_code_notification_of_specified_length(length)
      requestBody="<ns1:OneTimePassCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\">
                                <ns1:destination>
                                     <ns1:contactInfo>" +  $contactinfo + "</ns1:contactInfo>
                                     <ns1:protocol>" + $protocol + "</ns1:protocol>
                                 </ns1:destination>
                                 <ns1:oneTimePassCodeLength>" +length+ "</ns1:oneTimePassCodeLength>
                  </ns1:OneTimePassCodeNotification>"
      response = self.class.post($create_one_time_pass_code_uriString,{ :body => requestBody })
    end

    def create_activation_confirmation_by_dest_id(id)
      requestBody="<ns1:Notification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\">
                              <ns1:destination><ns1:id>" + id +"</ns1:id>
                  </ns1:destination></ns1:Notification>"
      response = self.class.post($create_activation_confirmation_uriString,{ :body => requestBody })
    end

    def create_OOB_code(id)
      requestBody="<ns1:OOBCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\">
                             <ns1:responseMaxTimeoutInSec>300</ns1:responseMaxTimeoutInSec>
                             <ns1:invalidResponseMaxCount>5</ns1:invalidResponseMaxCount>
                             <ns1:requestChannel>WEB</ns1:requestChannel>
                             <ns1:destination><ns1:id>" + id +"</ns1:id></ns1:destination>
                   </ns1:OOBCodeNotification>"
      response = self.class.post($create_oob_uriString,{ :body => requestBody })
    end

    def update_OOB_code(id)

      requestBody="<ns1:OOBCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\">
                              <ns1:responseMaxTimeoutInSec>300</ns1:responseMaxTimeoutInSec>
                              <ns1:invalidResponseMaxCount>5</ns1:invalidResponseMaxCount>
                              <ns1:requestChannel>WEB</ns1:requestChannel>
                              <ns1:destination><ns1:id>" + id +"</ns1:id></ns1:destination>
                  </ns1:OOBCodeNotification>"
      response = self.class.post($update_oob_uriString,{ :body => requestBody })
    end

   def get_OOB_code(id)
      uriString = $get_oob_by_id_uriString + id
      response=self.class.get(uriString)
    end

    def create_password_by_dest_id(id)
      requestBody="<ns1:PasswordNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\">
                                                            <ns1:destination><ns1:id>" + id + "</ns1:id></ns1:destination>
                                                            <ns1:passwordLength>12</ns1:passwordLength>
                                          </ns1:PasswordNotification>"
      response = self.class.post($create_password_by_dest_id_uriString,{ :body => requestBody })
    end

      def get_endpoint_status

      requestBody="<SystemInfo xmlns=\"http://schema.intuit.com/fs/common/v2\" xmlns:ns2=\"http://schema.intuit.com/domain/banking/fiCustomer/v2\"
 xmlns:ns3=\"http://schema.intuit.com/domain/banking/notification/v2\" xmlns:ns4=\"http://schema.intuit.com/domain/banking/challengeQuestionInfo/v2\"
 xmlns:ns5=\"http://schema.intuit.com/domain/banking/account/v2\" xmlns:ns6=\"http://schema.intuit.com/domain/banking/fundingAccount/v2\"
 xmlns:ns7=\"http://schema.intuit.com/domain/banking/financialInstitution/v2\" xmlns:ns8=\"http://schema.intuit.com/domain/banking/accountTransaction/v2\"
 xmlns:ns9=\"http://schema.intuit.com/domain/banking/transfer/v2\" xmlns:ns10=\"http://schema.intuit.com/domain/billpay/billPayment/v2\"
 xmlns:ns11=\"http://schema.intuit.com/domain/banking/scheduledTransfer/v2\" xmlns:ns12=\"http://schema.intuit.com/domain/banking/achId/v2\"
 xmlns:ns13=\"http://schema.intuit.com/domain/banking/image/v2\" xmlns:ns14=\"http://schema.intuit.com/domain/banking/preference/V2\"
 xmlns:ns15=\"http://schema.intuit.com/platform/integration/identity/authToken/v2\" xmlns:ns16=\"http://schema.intuit.com/domain/banking/financialInfo/v2\"
 xmlns:ns17=\"http://schema.intuit.com/domain/banking/configuration/v2\"/>"
      response=self.class.get($end_point_status_uriString, { :body => requestBody })
    end


    def get_sms_status
      response=self.class.get($sms_status_uriString)
    end

    def get_voice_status
      response=self.class.get($voice_status_uriString)
    end

    def get_email_status
      response=self.class.get($email_status_uriString)
    end

    def get_db_status
      response=self.class.get($db_status_uriString)
    end

    def get_circuit_breaker_status
      response=self.class.get($circuit_breaker_status_uriString)
    end

    def get_router_status
      response=self.class.get($router_status_uriString)
    end
   end
