require 'rspec/expectations'

Given /^connect to the server$/ do
  @connection=Webservice.new
end
Then /^delete destination$/ do
  @response = @connection.delete_destination
end
Then /^create destination$/ do
  @response = @connection.create_destination
end

Then /^get destination$/ do
  @response = @connection.get_destination
end

Then /^update destination with following values$/ do |table|
  @response = @connection.update_destination(table.rows_hash)
end
Then /^create password for destination ID retrieved in previous step$/ do
  @response = @connection.create_password_by_dest_id(@ID)
end

Then /^create activation code$/ do
  @response = @connection.create_activation_code_notification
end

Then /^push "([^"]*)" one time pass code$/ do |arg|
  @response = @connection.push_one_time_pass_code_notification(arg)
end
Then /^create one time pass code of length "([^"]*)"$/ do |arg|
  @response = @connection.create_one_time_pass_code_notification_of_specified_length(arg)
end

When /^get OOB code for destination ID retrieved earlier$/ do
  @response = @connection.get_OOB_code(@ID)
end

Then /^create OOB code for destination ID retrieved in previous step$/ do
  @response = @connection.create_OOB_code(@ID)
  puts @response
end

Then /^retrieve endpoint status$/ do
  @response = @connection.get_endpoint_status
end

Then /^retrieve status of SMS$/ do
  @response = @connection.get_sms_status
end

Then /^retrieve status of voice$/ do
  @response = @connection.get_voice_status
end

Then /^retrieve status of email$/ do
  @response = @connection.get_email_status
end

Then /^retrieve DB status$/ do
  @response = @connection.get_db_status
end

Then /^retrieve circuit breaker status$/ do
  @response = @connection.get_circuit_breaker_status
end

Then /^retrieve router status$/ do
  @response = @connection.get_router_status
end

Then /^create one time pass code$/ do
  @response = @connection.create_one_time_pass_code_notification
end

Then /^create activation confirmation for destination ID retrieved in previous step$/ do
  @response = @connection.create_activation_confirmation_by_dest_id(@ID)
end

Then /^create one time pass code for destination ID retrieved in previous steps$/ do
  @response = @connection.create_one_time_pass_code_notification_by_dest_id(@ID)
end

Then /^update OOB code for destination ID retrieved in previous steps$/ do
  @response = @connection.update_OOB_code(@ID)
end

##########################################################################################

Then /retrieve SMS messages to "([^"]*)" and check if file contains OOBCode$/ do |arg|
  oob_code_data=@response.parsed_response
  @OOBCode=oob_code_data["OOBCodeNotification"]["oobCode"]
  cmdString = "adb logcat -v time -d|grep \"SMSText\">>" +arg

  (poll(15, arg, 15, cmdString, @OOBCode)).should == true

end

When /^retrieve SMS messages to "([^"]*)" and check if file contains activation code$/ do |arg|
  activationData=@response.parsed_response
  activationCode=activationData["ActivationCodeNotification"]["activationCode"]
  cmdString = "adb logcat -v time -d|grep \"SMSText\">>" +arg
  (poll(15, arg, 15, cmdString, activationCode)).should == true

end

When /^retrieve SMS messages to "([^"]*)" and check if file contains "([^"]*)"$/ do |arg1, arg2|
  cmdString = "adb logcat -v time -d|grep \"SMSText\">>" +arg1
  (poll(15, arg1, 15, cmdString, arg2)).should == true

end

Then /^retrieve SMS messages to "([^"]*)" and check if file contains one time pass code$/ do |arg|
  oneTimePassCodeData=@response.parsed_response
  oneTimePassCode=oneTimePassCodeData["OneTimePassCodeNotification"]["oneTimePassCode"]
  cmdString = "adb logcat -v time -d|grep \"SMSText\">>" +arg
  (poll(15, arg, 15, cmdString, oneTimePassCode)).should == true

end

When /^retrieve SMS messages to "([^"]*)" and check if file contains password$/ do |arg|
  passwordData=@response.parsed_response
  password = passwordData["PasswordNotification"]["password"]
  cmdString = "adb logcat -v time -d|grep \"SMSText\">>" +arg
  (poll(15, arg, 15, cmdString, password)).should == true
end

Then /^retrieve messages to "([^"]*)" and check if file contains one time pass code$/ do  |arg|
  oneTimePassCodeData=@response.parsed_response
  oneTimePassCode=oneTimePassCodeData["OneTimePassCodeNotification"]["oneTimePassCode"]
  cmdString = "java -classpath ./lib/javamail-mail-1.4.jar:./lib/jsr94-j2ee.jar:./lib/FetchEmails.jar FetchEmail " + $contactinfo +" " + $password
  #(poll(6, arg, 30, cmdString, oneTimePassCode)).should == true
  @returnValue = (poll(6, arg, 30, cmdString, oneTimePassCode))
end

Then /^if no email received, print warning$/ do
  if(!@returnValue)
    print_warning("Email is not received. Re-create one time passcode")
  end
end

Then /^retrieve messages to "([^"]*)" and check if file contains "([^"]*)"$/ do  |arg1, arg2|
  cmdString = "java -classpath ./lib/javamail-mail-1.4.jar:./lib/jsr94-j2ee.jar:./lib/FetchEmails.jar FetchEmail " + $contactinfo +" " + $password
  #(poll(6, arg1, 30, cmdString, arg2)).should == true
  @returnValue = (poll(6, arg1, 30, cmdString, arg2))
end

Then /^if no email received, re-create  activation confirmation for destination ID retrieved in previous steps$/ do
  if(!@returnValue)
    print_warning("Email is not received.Re-create activation confirmation for destination ID retrieved in previous steps")
    step "create activation confirmation for destination ID retrieved in previous step"
    step 'validate response code "201" and response message "Created"'
    step 'retrieve messages to "Emails.txt" and check if file contains "Congratulations! Your email has been activated."'
    if(!@returnValue)
      print_warning("Email is not received again")
    end
  end
end

When /^read destination id$/ do
  dest = @response.parsed_response
  @ID = dest['Destinations']['destination']['id']
end

When /^copy OOB to temporarily location$/ do
  @tempOOB=@OOBCode
end

When /^confirm that OOB code was changed$/ do
  @OOBCode.to_s.should_not == @tempOOB.to_s
end

When /^verify that password length is "([^"]*)"$/ do |arg|
  pretty_print @response.inspect
  passwordData=@response.parsed_response
  password = passwordData["PasswordNotification"]["password"]
  password.length.to_s.should == arg
end

###############################################################################################

def validate_code_and_message(arg1, arg2)
  pretty_print @response.inspect
  puts @response
  @response.code.to_s.should == arg1
  @response.message.should == arg2
end

When /^validate response code "([^"]*)" and response message "([^"]*)"$/ do |arg1, arg2|
  validate_code_and_message(arg1, arg2)
end
When /^validate response$/ do
  validate_code_and_message('200', 'OK')
  dest = @response.parsed_response
  dest['Destinations']['destination']['protocol'].should == $protocol
  dest['Destinations']['destination']['nickname'].should == $nickname
  dest['Destinations']['destination']['contactInfo'].should == $contactinfo
  dest['Destinations']['destination']['activated'].should == $activated
  dest['Destinations']['destination']['default'].should == $default
end
When /^validate one time pass code response$/ do
  validate_code_and_message('200', 'OK')
  responseData = @response.parsed_response
  tempString = "One Time pass code: " +  responseData["OneTimePassCodeNotification"]["oneTimePassCode"]
  puts tempString
end
When /^validate response for the following nested payload$/ do |table|
  validate_code_and_message('200', 'OK')
  testData=table.rows_hash
  dest = @response.parsed_response
  i=0
  dest['Destinations']['destination'].each do |element|
    i=i+1
    element['protocol'].should == testData['protocol' + i.to_s]
    element['nickname'].should == testData['nickname' + i.to_s]
    element['activated'].should == testData['activated' + i.to_s]
    element['contactInfo'].should == testData['contactInfo' + i.to_s]
    element['default'].should == testData['default' + i.to_s]
  end
end
When /^validate that one time pass code response value is "([^"]*)"$/ do |arg|
  validate_code_and_message('201', 'Created')
  responseData = @response.parsed_response
  oneTimePassCode = responseData["OneTimePassCodeNotification"]["oneTimePassCode"]
  tempString = "One Time pass code: " +  oneTimePassCode
  pretty_print tempString
  oneTimePassCode.should == arg
end
When /^validate response when one time pass code length is "([^"]*)"$/ do |arg|
  validate_code_and_message('201', 'Created')
  responseData = @response.parsed_response
  oneTimePassCode = responseData["OneTimePassCodeNotification"]["oneTimePassCode"]
  tempString = "One Time pass code: " +  oneTimePassCode
  pretty_print  tempString
  oneTimePassCode.length.to_s == '9'
end
##############################################################################################


Given /^that I am logged into the application$/ do
  login_action
end

When /^button displayed on the screen "([^"]*)"$/ do |arg|
  check_button arg
end

When /^I touch the button "([^"]*)"$/ do |arg|
  touch_button arg
end

Then /^message displayed on the screen "([^"]*)"$/ do |arg|
  check_text arg
end

When /^I take a screenshot of the "([^"]*)"$/ do |arg|
  custom_screenshot arg
end

# test cleanup steps
When /^shutting down test server on the device$/ do
  shutdown_test_server
end

