def pretty_print(arg)
  if $debug
    puts ""
    puts "------------------------"
    puts "Response Inspector Output"
    puts ""
    puts arg
    puts "------------------------"
    puts ""
  end
end

def print_warning(arg)
    puts ""
    puts "------------------------"
    puts "Warning"
    puts ""
    puts arg
    puts "------------------------"
    puts ""
end


When /^clean up adb buffer$/ do
  system("adb logcat -c")
end

Then /^remove "([^"]*)" file$/ do |arg|
  tempString = "rm -r " + arg
  system(tempString)
end

When /^wait for "([^"]*)" seconds$/ do |arg|
  sleep(arg.to_i)
end

Then /^retrieve SMS messages and save them in "([^"]*)"$/ do |arg|
  tempString = "adb logcat -v time -d|grep \"SMSText\">>" +arg
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

Then /^stop "([^"]*)" android application$/ do |arg|
  packageName ="com.example.sms" + arg.downcase
  tempString="adb shell am force-stop  " + packageName
  system(tempString)
end

def login_action()
  if is_logged_out?
    performAction('clear_id_field', $member_number_field_id)
    performAction('enter_text_into_id_field', $username, $member_number_field_id)
    performAction('enter_text_into_id_field', $password, $password_field_id)
    performAction('press_button_with_text', $loginbutton)
    performAction('wait_for_text', $accounts_screen_label, 180)
    wait_seconds 5
  end
end

def wait_seconds(arg)
  performAction('wait', arg)
end

def is_logged_out?
  begin
    performAction('wait_for_text', $signup_label, 20)
    true
  rescue Exception => e
    false
  end
end

def check_button(arg)
  performAction('wait_for_button', arg)
end

def touch_button(arg1)
  performAction('press_button_with_text', arg1)
end

def check_text(arg)
  performAction('wait_for_text', arg, 120)
  performAction('assert_text', arg, true)
end

def custom_screenshot(arg)
  screenshot_embed(:name => arg)
end

# methods called in hooks files
def is_timeout_msg?
  begin
    performAction('assert_text', $session_timeout_msg, true)
    true
  rescue Exception => e
    false
  end
end

def is_app_error_msg?
  begin
    performAction('assert_text', $app_error_msg, true)
    true
  rescue Exception => e
    false
  end
end


def poll(attempts, filename, idle_time, sys_cmd, lookup_str)
  system("touch #{filename}")
  counter=0
  result=false
  while (counter < attempts && !result)
    system(sys_cmd)
    result = (File.read(filename).include?(lookup_str))
    counter += 1
    sleep idle_time
  end
  puts "Counter: " + counter.to_s
  return result
end
