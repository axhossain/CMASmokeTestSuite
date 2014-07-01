require 'rspec/expectations'
#
#Then /^Create destination for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)"$/ do |arg1, arg2, arg3, arg4|
#  @response = @connection.create_destination(arg1, arg2, arg3, arg4)
#end
#Then /^Create destination for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)", customer "([^"]*)" and the following request properties:$/ do |arg1, arg2, arg3, arg4, table|
#  @response = @connection.create_destination(arg1, arg2, arg3, arg4, table.rows_hash)
#  #puts @response.body, @response.code, @response.message, @response.headers.inspect
#end
#Then /^Delete destination for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)"$/ do |arg1, arg2, arg3, arg4|
#  @response = @connection.delete_destination(arg1, arg2, arg3, arg4)
#end
#Then /^Get customer destination for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)"$/ do |arg1, arg2, arg3, arg4|
#  @response = @connection.get_destination(arg1, arg2, arg3, arg4)
#end
#Then /^Update destination for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)", customer "([^"]*)" and the following request properties:$/ do |arg1, arg2, arg3, arg4, table|
#  @response = @connection.update_destination(arg1, arg2, arg3, arg4, table.rows_hash)
#end
#Then /^Create activation code for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and following request properties:$/ do |arg1, arg2, arg3, arg4, table|
#  @response = @connection.create_activation_code_notification(arg1, arg2, arg3, arg4, table.rows_hash)
#end
#Then /^Create one time pass code for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and following request properties:$/ do |arg1, arg2, arg3, arg4, table|
#  @response = @connection.create_one_time_pass_code_notification(arg1, arg2, arg3, arg4, table.rows_hash)
#end
#
#
#
#Then /^Create one time pass code for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and and the following request properties:$/ do |arg1, arg2, arg3, arg4, table|
#  @response = @connection.create_one_time_pass_code_notification(arg1, arg2, arg3, arg4, table.rows_hash)
#end
#
#Then /^Push one time pass code for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and and the following request properties:$/ do |arg1, arg2, arg3, arg4, table|
#  hashData=table.rows_hash
#  @pushedOneTimePassCode = hashData["oneTimePassCode"]
#  @response = @connection.push_one_time_pass_code_notification(arg1, arg2, arg3, arg4, hashData)
#end
#Then /^Create one time pass code of specified length for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and and the following request properties:$/ do |arg1, arg2, arg3, arg4, table|
#  @response = @connection.create_one_time_pass_code_notification_of_specified_lentght(arg1, arg2, arg3, arg4, table.rows_hash)
#end
#
#
#
#
#
#
#Then /^Create password for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)" and destination ID retrieved in previous step; Password length is "([^"]*)"$/ do |arg1, arg2, arg3, arg4, arg5|
#  @response = @connection.create_password_specified_length_by_dest_id(arg1, arg2, arg3, arg4, @ID, arg5)
##end
#
#
#
#
#
#
##########################################################################################################################################
#
#
#
#When /^Validate successful get destination response$/ do
#  puts @response.inspect
#  @response.code.to_s.should == '200'
#  @response.message.should =='OK'
#  dest = @response.parsed_response
#  #puts dest ['Destinations']['destination']['protocol']
#  puts dest ['Destinations']['destination'].length
#    dest['Destinations']['destination'].each do |element|
#      puts element
#      puts element['protocol']
#      puts element['nickname']
#      puts element['activated']
#      puts element['contactInfo']
#      puts element['id']
#    end
#end
#
#
#
#
#
#
#
#
#
#
#
##########################################################################################################################################
#
#
#
#
#
#
#
#
#Then /^Retrieve Account entities for for FI "([^"]*)", product "([^"]*)", notificationApp "([^"]*)" and customer "([^"]*)"$/ do |arg1, arg2, arg3, arg4|
#  @response = @connection.retrieve_accounts(arg1, arg2, arg3, arg4)
#end
#When /^Search for the FI "([^"]*)" customer by using "([^"]*)" product ID, "([^"]*)" protocol and "([^"]*)" contact information$/ do |arg1, arg2, arg3, arg4|
#  @response = @connection.retrieve_fi_customer(arg1, arg2, arg3, arg4)
#end
