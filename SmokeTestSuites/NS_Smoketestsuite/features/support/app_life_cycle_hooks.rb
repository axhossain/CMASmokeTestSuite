require 'calabash-android/management/adb'
require 'calabash-android/operations'
require "fileutils"

def stringReplace(searchString, replaceString, fileName)
  aFile = File.open(fileName, "r")
  aString = aFile.read
  aFile.close
  aString.gsub!(searchString, replaceString)
  File.open(fileName, "w") { |file| file << aString }
end

Before do |scenario|
  tag=ENV["ROUTE"]
  if tag=="e2e"
    if !$funit
      # app install steps
      uninstall_apps
      install_app(ENV["TEST_APP_PATH"])
      install_app(ENV["APP_PATH"])

      start_test_server_in_background
      # e2e parameters
      $username = "cma12"
      $password = "11111"
      $member_number_field_id = "Edt_UserId"
      $password_field_id = "Edt_Password"
      $loginbutton = "Log in"
      $accounts_screen_label = "Accounts"
      $signup_label = "Sign up"
      $session_timeout_msg = "Session Timeout"
      $app_error_msg = "Application Error"
      $funit=true
      if !$exit_flag
        stringReplace("exit 1", "exit 0", "exit_status.sh")
        $exit_flag=true
      end
    end
  else
    if !$dunit
      if !$exit_flag
        stringReplace("exit 1", "exit 0", "exit_status.sh")
        $exit_flag=true
      end
      $dunit=true
    end

  end
end

After do |scenario|
  if scenario.failed?
    # set exit code to 1
    stringReplace("exit 0", "exit 1", "exit_status.sh" )
    tag=ENV["ROUTE"]

    if tag=="e2e"
      # take a screen shot
      screenshot_embed

      # restart test server
      shutdown_test_server
      start_test_server_in_background

      # handle timeout condition
      if is_timeout_msg?
        performAction("press_button_with_text", "OK")
      end

      # handle app error condition
      if is_app_error_msg?
        performAction("press_button_with_text", "OK")
      end

    end
  end
end

