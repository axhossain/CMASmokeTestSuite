Then /^Remove "([^"]*)" file$/ do |arg|
  tempString = "rm -r " + arg
  system(tempString)
end
When /^Wait for "([^"]*)" seconds$/ do |arg|
  sleep(arg.to_i)
end
Then /^Retrieve SMS messages and save them in "([^"]*)"$/ do |arg|
  tempString = "adb logcat -v time -d|grep \"SMSText\">>" +arg
  system(tempString)
end
When /^Clean up adb buffer$/ do
  system("adb logcat -c")
end

When /^Retrieve messages from e-mail "([^"]*)" with password "([^"]*)" and save them in Emails.txt$/ do |arg1, arg2|
  tempString   = "java -classpath ./lib/javamail-mail-1.4.jar:./lib/jsr94-j2ee.jar:./lib/FetchEmails.jar FetchEmail " + arg1 +" " + arg2
  system(tempString)
end
Then /^execute "([^"]*)" command$/ do |arg|
  packageName ="com.example.sms" + arg.downcase
  activityName=packageName+".MainActivity"
  applicationName = "SMS" + arg +".apk"
  tempString="adb install -r " + applicationName
  system(tempString)
  tempString1="adb shell am start -n " + packageName +"/" + activityName
  system(tempString1)

end