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

After do |scenario|
  if scenario.failed?

    # take a screen shot
    screenshot_embed

    # set exit code to 1
    stringReplace("exit 0", "exit 1", "exit_status.sh" )

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
  # steps to capture adb log after each scenario
  device = ENV["ADB_DEVICE_ARG"]
  system("echo ------------------------------------------------- >> ADB_Log_#{device}.log")
  system("echo Scenario: #{scenario.name} >> ADB_Log_#{device}.log")
  system("echo ------------------------------------------------- >> ADB_Log_#{device}.log")
  system("adb -s #{device} logcat -d >> ADB_Log_#{device}.log")
end


