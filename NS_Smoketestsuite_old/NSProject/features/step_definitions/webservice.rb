require 'rubygems'
require 'httparty'
require "rexml/document"

  class Webservice
    include HTTParty
    format :xml
    #base_uri 'http://10.136.239.181:80'
    base_uri 'http://pqalnsqas300.corp.intuit.net:8080'

    #headers 'intuit_tid' => 'jmetertests'
    #headers 'intuit_appId' => 'USP'
    #headers 'intuit_offeringId' => 'USP'
    #headers 'Authorization' => 'nstestclient'
    #headers 'Content-Type' => 'application/xml'

    headers 'intuit_tid'=> 'jmetertests'
    headers 'intuit_appId'=> 'CASService'
    headers 'intuit_offeringId'=>'CASService'
    headers 'Authorization'=>'8fb5832f-2e63-4d05-b514-0401906b8c90'
    headers 'intuit_originatingip'=>'127.0.0.1'
    headers 'DI-SSL-ClientCert' => 'mtalkclient.prd.intuit.com'
    headers 'Content-Type' => 'application/xml'

    def create_destination(di, product, notificationApps, customerName, hash={})

      uriString = "/notificationService/v2/fis/"+di+"/products/" +product+"/notificationApps/"+notificationApps+"/fiCustomers/" +customerName+"/destinations"
      requestBody ="<ns1:Destinations xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\"><ns1:destination><ns1:contactInfo>" + hash["contactInfo"]+ "</ns1:contactInfo><ns1:nickname>" + hash["nickname"] + "</ns1:nickname><ns1:protocol>" + hash["protocol"] + "</ns1:protocol><ns1:activated>" + hash["activated"] + "</ns1:activated><ns1:default>" + hash["default"] + "</ns1:default></ns1:destination></ns1:Destinations>"
      response=self.class.post(uriString,{ :body => requestBody })
    end

    def delete_destination()
      response = self.class.delete('/notificationService/v2/fis/DI9901/products/IB/notificationApps/MFA/fiCustomers/autoNS/destinations')
      puts "Code " + response.code.to_s, "Message " + response.message, "Headers " + response.headers.inspect
    end

    def delete_destination(di, product, notificationApps, customerName)
      uriString = "/notificationService/v2/fis/" + di + "/products/" + product +"/notificationApps/" + notificationApps+ "/fiCustomers/" + customerName +"/destinations"
      response = self.class.delete(uriString)
    end


    def get_destination(di, product, notificationApps, customerName)
      uriString =
          "/notificationService/v2/fis/" + di + "/products/" + product +"/notificationApps/" + notificationApps+ "/fiCustomers/" + customerName +"/destinations"
      response = self.class.get(uriString)
    end

    def update_destination(di, product, notificationApps, customerName, hash={})
      uriString = "/notificationService/v2/fis/"+di+"/products/" +product+"/notificationApps/"+notificationApps+"/fiCustomers/" +customerName+"/destinations"
      requestBody ="<ns1:Destinations xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\"><ns1:destination><ns1:contactInfo>" + hash["contactInfo"]+ "</ns1:contactInfo><ns1:nickname>" + hash["nickname"] + "</ns1:nickname><ns1:protocol>" + hash["protocol"] + "</ns1:protocol><ns1:activated>" + hash["activated"] + "</ns1:activated><ns1:default>" + hash["default"] + "</ns1:default></ns1:destination></ns1:Destinations>"
      response = self.class.post(uriString,{ :body => requestBody })
    end

    def create_activation_code_notification(di, product, notificationApps, customerName, hash={})
      uriString="/notificationService/v2/fis/"+di+"/products/" +product+"/notificationApps/"+notificationApps+"/fiCustomers/"+customerName+"/activationCodeNotification"
      requestBody ="<ns1:ActivationCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\"><ns1:destination><ns1:contactInfo>"+ hash["contactInfo"]+ "</ns1:contactInfo><ns1:protocol>" + hash["protocol"] + "</ns1:protocol></ns1:destination></ns1:ActivationCodeNotification>"
      response = self.class.post(uriString,{ :body => requestBody })
    end

    def create_one_time_pass_code_notification(di, product, notificationApps, customerName, hash={})
      uriString="/notificationService/v2/fis/"+di+"/products/" +product+"/notificationApps/"+notificationApps+"/fiCustomers/"+customerName+"/oneTimePassCodeNotification"
      requestBody="<ns1:OneTimePassCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\"><ns1:destination><ns1:contactInfo>" + hash["contactInfo"] + "</ns1:contactInfo><ns1:protocol>" + hash["protocol"] + "</ns1:protocol></ns1:destination></ns1:OneTimePassCodeNotification>"
      response = self.class.post(uriString,{ :body => requestBody })
    end

    def create_one_time_pass_code_notification_by_dest_id(di, product, notificationApps, customerName, id)
      uriString="/notificationService/v2/fis/"+di+"/products/" +product+"/notificationApps/"+notificationApps+"/fiCustomers/"+customerName+"/oneTimePassCodeNotification"
      requestBody="<ns1:OneTimePassCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\"><ns1:destination><ns1:id>" + id +"</ns1:id></ns1:destination></ns1:OneTimePassCodeNotification>"
      response = self.class.post(uriString,{ :body => requestBody })
    end

    def push_one_time_pass_code_notification(di, product, notificationApps, customerName, hash={})
      uriString="/notificationService/v2/fis/"+di+"/products/" +product+"/notificationApps/"+notificationApps+"/fiCustomers/"+customerName+"/oneTimePassCodeNotification"
      requestBody="<ns1:OneTimePassCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\"><ns1:destination><ns1:contactInfo>" + hash["contactInfo"] + "</ns1:contactInfo><ns1:protocol>" + hash["protocol"] + "</ns1:protocol></ns1:destination><ns1:oneTimePassCode>" +hash["oneTimePassCode"]+ "</ns1:oneTimePassCode></ns1:OneTimePassCodeNotification>"
      response = self.class.post(uriString,{ :body => requestBody })
    end

    def create_one_time_pass_code_notification_of_specified_lentght(di, product, notificationApps, customerName, hash={})
      uriString="/notificationService/v2/fis/"+di+"/products/" +product+"/notificationApps/"+notificationApps+"/fiCustomers/"+customerName+"/oneTimePassCodeNotification"
      requestBody="<ns1:OneTimePassCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\"><ns1:destination><ns1:contactInfo>" + hash["contactInfo"] + "</ns1:contactInfo><ns1:protocol>" + hash["protocol"] + "</ns1:protocol></ns1:destination><ns1:oneTimePassCodeLength>" +hash["oneTimePassCodeLength"]+ "</ns1:oneTimePassCodeLength></ns1:OneTimePassCodeNotification>"
      response = self.class.post(uriString,{ :body => requestBody })
    end

    def create_activation_confirmation_by_dest_id(di, product, notificationApps, customerName, id)
      uriString="/notificationService/v2/fis/"+di+"/products/" +product+"/notificationApps/"+notificationApps+"/fiCustomers/"+customerName+"/notification?method=sendActivationConfirmation"
      requestBody="<ns1:Notification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\"><ns1:destination><ns1:id>" + id +"</ns1:id></ns1:destination></ns1:Notification>"
      response = self.class.post(uriString,{ :body => requestBody })
    end

    def create_OOB_code(di, product, notificationApps, customerName, id)
      uriString="/notificationService/v2/fis/"+di+"/products/" +product+"/notificationApps/"+notificationApps+"/fiCustomers/"+customerName+"/oobCodeNotification"
      requestBody="<ns1:OOBCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\"><ns1:responseMaxTimeoutInSec>300</ns1:responseMaxTimeoutInSec><ns1:invalidResponseMaxCount>5</ns1:invalidResponseMaxCount><ns1:requestChannel>WEB</ns1:requestChannel><ns1:destination><ns1:id>" + id +"</ns1:id></ns1:destination></ns1:OOBCodeNotification>"
      response = self.class.post(uriString,{ :body => requestBody })
    end

    def update_OOB_code(di, product, notificationApps, customerName, id)
      uriString="/notificationService/v2/fis/"+di+"/products/" +product+"/notificationApps/"+notificationApps+"/fiCustomers/"+customerName+"/oobCodeNotification"
      requestBody="<ns1:OOBCodeNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\"><ns1:responseMaxTimeoutInSec>300</ns1:responseMaxTimeoutInSec><ns1:invalidResponseMaxCount>5</ns1:invalidResponseMaxCount><ns1:requestChannel>WEB</ns1:requestChannel><ns1:destination><ns1:id>" + id +"</ns1:id></ns1:destination></ns1:OOBCodeNotification>"
      response = self.class.put(uriString,{ :body => requestBody })
      puts response
    end

   def get_OOB_code(di, product, notificationApps, customerName, id)
      uriString="/notificationService/v2/fis/"+di+"/products/" +product+"/notificationApps/"+notificationApps+"/fiCustomers/"+customerName+"/oobCodeNotification?destId="+id
      response=self.class.get(uriString)
    end

    def retrieve_accounts(di, product, notificationApps, customerName)
      uriString="/notificationService/v2/fis/" + di +"/products/" + product + "/notificationApps/" + notificationApps + "/fiCustomers/" + customerName + "/accounts"
      puts uriString
      response=self.class.get(uriString)
      puts response.to_s
    end


    def create_password_by_dest_id(di, product, notificationApps, customerName, id)
      uriString="/notificationService/v2/fis/"+di+"/products/" +product+"/notificationApps/"+notificationApps+"/fiCustomers/"+customerName+"/passwordNotification"
      requestBody="<ns1:PasswordNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\"><ns1:destination><ns1:id>" + id +
          "</ns1:id></ns1:destination><ns1:passwordLength>12</ns1:passwordLength></ns1:PasswordNotification>"
      response = self.class.post(uriString,{ :body => requestBody })
    end

    def create_password_specified_length_by_dest_id(di, product, notificationApps, customerName, id, length)
      uriString="/notificationService/v2/fis/"+di+"/products/" +product+"/notificationApps/"+notificationApps+"/fiCustomers/"+customerName+"/passwordNotification"
      requestBody="<ns1:PasswordNotification xmlns:ns1=\"http://schema.intuit.com/domain/banking/notification/v2\"><ns1:destination><ns1:id>" + id +
          "</ns1:id></ns1:destination><ns1:passwordLength>length</ns1:passwordLength></ns1:PasswordNotification>"
      response = self.class.post(uriString,{ :body => requestBody })
    end

    def retrieve_fi_customer(di, product, protocol, contactInfo)

      uriString="/notificationService/v2/fis/"+di+"/products/" +product+"/fiCustomers?contactInfo=" + contactInfo + "&protocol=" + protocol
      puts uriString
      response=self.class.get(uriString)
      puts response.inspect
    end

    def get_endpoint_status
      uriString="/notificationService/v2/status"
      requestBody="<SystemInfo xmlns=\"http://schema.intuit.com/fs/common/v2\" xmlns:ns2=\"http://schema.intuit.com/domain/banking/fiCustomer/v2\"
 xmlns:ns3=\"http://schema.intuit.com/domain/banking/notification/v2\" xmlns:ns4=\"http://schema.intuit.com/domain/banking/challengeQuestionInfo/v2\"
 xmlns:ns5=\"http://schema.intuit.com/domain/banking/account/v2\" xmlns:ns6=\"http://schema.intuit.com/domain/banking/fundingAccount/v2\"
 xmlns:ns7=\"http://schema.intuit.com/domain/banking/financialInstitution/v2\" xmlns:ns8=\"http://schema.intuit.com/domain/banking/accountTransaction/v2\"
 xmlns:ns9=\"http://schema.intuit.com/domain/banking/transfer/v2\" xmlns:ns10=\"http://schema.intuit.com/domain/billpay/billPayment/v2\"
 xmlns:ns11=\"http://schema.intuit.com/domain/banking/scheduledTransfer/v2\" xmlns:ns12=\"http://schema.intuit.com/domain/banking/achId/v2\"
 xmlns:ns13=\"http://schema.intuit.com/domain/banking/image/v2\" xmlns:ns14=\"http://schema.intuit.com/domain/banking/preference/V2\"
 xmlns:ns15=\"http://schema.intuit.com/platform/integration/identity/authToken/v2\" xmlns:ns16=\"http://schema.intuit.com/domain/banking/financialInfo/v2\"
 xmlns:ns17=\"http://schema.intuit.com/domain/banking/configuration/v2\"/>"
      response=self.class.get(uriString, { :body => requestBody })
    end


    def get_sms_status
      uriString="/notificationService/v2/sms/status"
      response=self.class.get(uriString)
    end

    def get_voice_status
      uriString="/notificationService/v2/voice/status"
      response=self.class.get(uriString)
    end

    def get_email_status
      uriString="/notificationService/v2/email/status"
      response=self.class.get(uriString)
    end

    def get_db_status
      uriString="/notificationService/v2/db/status"
      response=self.class.get(uriString)
    end

    def get_circuit_breaker_status
      uriString="/notificationService/v2/circuitBreaker/status"
      response=self.class.get(uriString)
    end

    def get_circuit_router_status
      puts "I am here"
      uriString="/notificationService/v2/router/status"
      response=self.class.get(uriString)
    end





   end
