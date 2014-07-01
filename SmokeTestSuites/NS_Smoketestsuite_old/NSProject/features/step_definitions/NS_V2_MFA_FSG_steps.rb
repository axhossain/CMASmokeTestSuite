require 'rspec/expectations'

Given /^Connect to the server$/ do
  @connection=Webservice.new
end

Then /^Create destination for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)"$/ do |arg1, arg2, arg3, arg4|
  @response = @connection.create_destination(arg1, arg2, arg3, arg4)
end
Then /^Create destination for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)", customer "([^"]*)" and the following request properties:$/ do |arg1, arg2, arg3, arg4, table|
  @response = @connection.create_destination(arg1, arg2, arg3, arg4, table.rows_hash)
  #puts @response.body, @response.code, @response.message, @response.headers.inspect
end
Then /^Delete destination for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)"$/ do |arg1, arg2, arg3, arg4|
  @response = @connection.delete_destination(arg1, arg2, arg3, arg4)
end
Then /^Get customer destination for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)"$/ do |arg1, arg2, arg3, arg4|
  @response = @connection.get_destination(arg1, arg2, arg3, arg4)
end
Then /^Update destination for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)", customer "([^"]*)" and the following request properties:$/ do |arg1, arg2, arg3, arg4, table|
  @response = @connection.update_destination(arg1, arg2, arg3, arg4, table.rows_hash)
end
Then /^Create activation code for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and following request properties:$/ do |arg1, arg2, arg3, arg4, table|
  @response = @connection.create_activation_code_notification(arg1, arg2, arg3, arg4, table.rows_hash)
end
Then /^Create one time pass code for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and following request properties:$/ do |arg1, arg2, arg3, arg4, table|
  @response = @connection.create_one_time_pass_code_notification(arg1, arg2, arg3, arg4, table.rows_hash)
end

Then /^Create one time pass code for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and destination ID retrieved in previous step$/ do |arg1, arg2, arg3, arg4|
  @response = @connection.create_one_time_pass_code_notification_by_dest_id(arg1, arg2, arg3, arg4, @ID)
end

Then /^Create one time pass code for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and and the following request properties:$/ do |arg1, arg2, arg3, arg4, table|
  @response = @connection.create_one_time_pass_code_notification(arg1, arg2, arg3, arg4, table.rows_hash)
end

Then /^Push one time pass code for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and and the following request properties:$/ do |arg1, arg2, arg3, arg4, table|
  hashData=table.rows_hash
  @pushedOneTimePassCode = hashData["oneTimePassCode"]
  @response = @connection.push_one_time_pass_code_notification(arg1, arg2, arg3, arg4, hashData)
end
Then /^Create one time pass code of specified length for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and and the following request properties:$/ do |arg1, arg2, arg3, arg4, table|
  @response = @connection.create_one_time_pass_code_notification_of_specified_lentght(arg1, arg2, arg3, arg4, table.rows_hash)
end
Then /^Create OOB code for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and destination ID retrieved in previous step$/ do |arg1, arg2, arg3, arg4|
  @response = @connection.create_OOB_code(arg1, arg2, arg3, arg4, @ID)
  puts @response.inspect
end

When /^Get OOB code for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and destination ID retrieved earlier$/ do |arg1, arg2, arg3, arg4|
  @response = @connection.get_OOB_code(arg1, arg2, arg3, arg4, @ID)
end

Then /^Update OOB code for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and destination ID retrieved in previous steps$/ do |arg1, arg2, arg3, arg4|
  @response = @connection.create_OOB_code(arg1, arg2, arg3, arg4, @ID)
end
Then /^Create password for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and destination ID retrieved in previous step$/ do |arg1, arg2, arg3, arg4|
  @response = @connection.create_password_by_dest_id(arg1, arg2, arg3, arg4, @ID)
end

Then /^Create password for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and destination ID retrieved in previous step; Password length is "([^"]*)"$/ do |arg1, arg2, arg3, arg4, arg5|
  @response = @connection.create_password_specified_length_by_dest_id(arg1, arg2, arg3, arg4, @ID, arg5)
end

Then /^Create activation confirmation and for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and destination ID retrieved in previous step$/ do |arg1, arg2, arg3, arg4|
  @response = @connection.create_activation_confirmation_by_dest_id(arg1, arg2, arg3, arg4, @ID)
end

Then /^Retrieve endpoint status$/ do
  @response = @connection.get_endpoint_status
end

Then /^Retrieve status of SMS$/ do
  @response = @connection.get_sms_status
end

Then /^Retrieve status of voice$/ do
  @response = @connection.get_voice_status
end

Then /^Retrieve status of email$/ do
  @response = @connection.get_email_status
end

Then /^Retrieve DB status$/ do
  @response = @connection.get_db_status
end

Then /^Retrieve circuit breaker status$/ do
  @response = @connection.get_circuit_breaker_status
end

Then /^Retrieve router status$/ do
  @response = @connection.get_circuit_router_status
end



#########################################################################################################################################
When /^Validate successful delete destination response$/ do
  puts @response.inspect
  @response.code.to_s.should == '204'
  @response.message.should =='No Content'
end
When /^Validate delete destination response when entity is not found$/ do
  puts @response.inspect
  @response.code.to_s.should == '404'
  @response.message.should =='Not Found'
end
When /^Validate successful create destination response$/ do
  puts @response.inspect
  @response.code.to_s.should == '201'
  @response.message.should =='Created'
  puts "received response code was #{@response.code.to_s} and response message was #{@response.message}"
end
When /^Validate create destination response in case of data conflict$/ do
  puts @response.inspect
  @response.code.to_s.should == '409'
  @response.message.should =='Conflict'
end
When /^Validate successful get destination response$/ do
  puts @response.inspect
  @response.code.to_s.should == '200'
  @response.message.should =='OK'
  dest = @response.parsed_response
  #puts dest ['Destinations']['destination']['protocol']
  puts dest ['Destinations']['destination'].length
    dest['Destinations']['destination'].each do |element|
      puts element
      puts element['protocol']
      puts element['nickname']
      puts element['activated']
      puts element['contactInfo']
      puts element['id']
    end
end

 When /^Validate successful get destination response against following test data$/ do |table|
  puts @response.inspect
  @response.code.to_s.should == '200'
  @response.message.should =='OK'
  testData=table.rows_hash
  dest = @response.parsed_response
  dest['Destinations']['destination']['protocol'].should == testData["protocol"]
  dest['Destinations']['destination']['nickname'].should == testData["nickname"]
  dest['Destinations']['destination']['contactInfo'].should == testData["contactInfo"]
  dest['Destinations']['destination']['activated'].should == testData["activated"]
  dest['Destinations']['destination']['default'].should == testData["default"]
end

When /^Validate successful update destination response against following test data$/ do |table|
  puts @response.inspect
  @response.code.to_s.should == '200'
  @response.message.should =='OK'
  testData=table.rows_hash
  dest = @response.parsed_response
  i=0
  dest['Destinations']['destination'].each do |element|
    i=i+1
    puts element
    element['protocol'].should == testData['protocol' + i.to_s]
    element['nickname'].should == testData['nickname' + i.to_s]
    element['activated'].should == testData['activated' + i.to_s]
    element['contactInfo'].should == testData['contactInfo' + i.to_s]
    element['default'].should == testData['default' + i.to_s]
  end
end

When /^Validate successful create activation code response$/ do
  puts @response.inspect
  @response.code.to_s.should == '201'
  @response.message.should =='Created'
end

When /^Validate one time pass code response$/ do
  puts @response.inspect
  responseData = @response.parsed_response
  tempString = "One Time pass code: " +  responseData["OneTimePassCodeNotification"]["oneTimePassCode"]
  puts tempString
  @response.code.to_s.should == '201'
  @response.message.should =='Created'
end

When /^Validate that one time pass code response value is "([^"]*)"$/ do |arg|
  puts @response.inspect
  responseData = @response.parsed_response
  oneTimePassCode = responseData["OneTimePassCodeNotification"]["oneTimePassCode"]
  tempString = "One Time pass code: " +  oneTimePassCode
  puts tempString
  @response.code.to_s.should == '201'
  @response.message.should =='Created'
  oneTimePassCode.should == arg
end

When /^Validate response when one time pass code length is "([^"]*)"$/ do |arg|
  responseData = @response.parsed_response
  oneTimePassCode = responseData["OneTimePassCodeNotification"]["oneTimePassCode"]
  tempString = "One Time pass code: " +  oneTimePassCode
  puts tempString
  @response.code.to_s.should == '201'
  @response.message.should =='Created'
  oneTimePassCode.length.to_s == '9'
end

When /^Validate OOB code response$/ do
  puts @response.inspect
  @response.code.to_s.should == '201'
  @response.message.should =='Created'
end

When /^Validate password response$/ do
  puts @response.inspect
  @response.code.to_s.should == '201'
  @response.message.should =='Created'
end

When /^Validate create activation confirmation response$/ do
  puts @response.inspect
  @response.code.to_s.should == '201'
  @response.message.should =='Created'
end

When /^Validate successful connection$/ do
  puts @response.inspect

  @response.code.to_s.should == '200'
  @response.message.should =='OK'
end
#########################################################################################################################################
When /^Check if "([^"]*)" contains activation code$/ do |arg|

  activationData=@response.parsed_response
  activationCode=activationData["ActivationCodeNotification"]["activationCode"]
  tempValue = false
  if File.open(arg).lines.any?{|line| line.include?(activationCode)}
    tempValue = true
  end
  tempValue.to_s.should == 'true'
end

When /^Check if "([^"]*)" contains one time pass code$/ do |arg|
  oneTimePassCodeData=@response.parsed_response
  oneTimePassCode=oneTimePassCodeData["OneTimePassCodeNotification"]["oneTimePassCode"]
  tempValue = false
  if File.open(arg).lines.any?{|line| line.include?(oneTimePassCode)}
    tempValue = true
  end
  tempValue.to_s.should == 'true'
end
When /^Read destination id$/ do
  puts @response.inspect
  dest = @response.parsed_response
  @ID = dest['Destinations']['destination']['id']
  destIDString = "Destination ID: " + @ID
  puts destIDString
end
When /^Check if "([^"]*)" contains OOBCode$/ do |arg|
  puts @response.inspect
  tempValue = false
  OOBCodeData=@response.parsed_response
  puts "OOB Code: " + OOBCodeData["OOBCodeNotification"]["oobCode"].inspect
  @OOBCode=OOBCodeData["OOBCodeNotification"]["oobCode"]
  if File.open(arg).lines.any?{|line| line.include?(@OOBCode)}
    tempValue = true
  end
  tempValue.to_s.should == 'true'
end
When /^Copy OOB to temporarily location$/ do
  @tempOOB=@OOBCode
end

When /^Confirm that OOB code was changed$/ do
  @OOBCode.to_s.should_not == @tempOOB.to_s
end
When /^Verify that "([^"]*)" contains password$/ do |arg|
  puts @response.inspect
  passwordData=@response.parsed_response
  tempValue = false
  password = passwordData["PasswordNotification"]["password"]
  puts "Password: " + password
  if File.open(arg).lines.any?{|line| line.include?(password)}
    tempValue = true
  end
end
When /^Verify that password length is "([^"]*)"$/ do |arg|
  passwordData=@response.parsed_response
  tempValue = false
  password = passwordData["PasswordNotification"]["password"]
  password.length.to_s.should == arg
end
When /^Check if "([^"]*)" contains "([^"]*)"$/ do |arg1, arg2|
  tempValue = false
  if File.open(arg1).lines.any?{|line| line.include?(arg2)}
    tempValue = true
  end
  tempValue.to_s.should == 'true'
end
Then /^Retrieve Account entities for for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)"$/ do |arg1, arg2, arg3, arg4|
  @response = @connection.retrieve_accounts(arg1, arg2, arg3, arg4)
end
When /^Search for the FI "([^"]*)" customer by using "([^"]*)" product ID, "([^"]*)" protocol and "([^"]*)" contact information$/ do |arg1, arg2, arg3, arg4|
  @response = @connection.retrieve_fi_customer(arg1, arg2, arg3, arg4)
end
