require "fileutils"

def stringReplace(searchString, replaceString, fileName)
  aFile = File.open(fileName, "r")
  aString = aFile.read
  aFile.close
  aString.gsub!(searchString, replaceString)
  File.open(fileName, "w") { |file| file << aString }
end

# Initializers - Executed once at the beginning of execution
Before do
  device = ENV["ADB_DEVICE_ARG"]

  if !$dunit

    # app install steps
    uninstall_apps
    install_app(ENV["TEST_APP_PATH"])
    install_app(ENV["APP_PATH"])

    # start test server
    start_test_server_in_background

    # initialize exit code status to 0
    stringReplace("exit 1", "exit 0", "exit_status.sh")


    # global test parameters

    # application labels
    $badpassword = "Bad Password"
    $session_timeout_msg = "Session Timeout"
    $app_error_msg = "Application Error"
    $loginbutton = "Log in"
    $label_yes = "Yes"
    $label_mfa_start_over = "Start Over"
    $accounts_screen_label = "Accounts"
    $signup_label = "Sign up"

    # field descriptors
    $member_number_field_id = "Edt_UserId"
    $password_field_id = "Edt_Password"
    $amt_edit_deposit_id = "check_deposit_amount_ctrl"
    $amt_edit_transfers_id = "tfrAmntEditTxt"
    $amt_edit_billpay_id = "Edt_Amount"
    $loc_search_id = "SearchEditTxt"
    $loc_list_btn_id = "Btn_ListLocation"

    # screen scanner text arrays
    $login_screen_text_array_maskedOFF = ["Log in", "Password", "Save Member Number", "Log In", "Locations", "More"]
    $login_screen_text_array_maskedON = ["****", "Log in", "Password", "Save Member Number", "Log In", "Locations", "More"]
    $transfer_screen_text_array = ["Transfer Money", "From", "To", "Amount", "Transfer"]
    $more_screen_text_array_logged_out = ["We are here to help", "Call us", "Email us", "Or you might try:", "website", "Additional links:"]
    $locations_screen_text_array = ["Search by ZIP or city"]
    $mfa_screen_text_array = ["Secure Login", "We need to confirm your identity", "Text me", "Call me"]
    $cash_back_offers_screen_text_array = ["Offers", "Sort by:", "Newest first"]
    $offer_detail_screen_text_array = ["Offer Details", "Offer ID:"]
    $more_screen_text_array_logged_in = ["We are here to help:", "Call us", "Email us", "Or you might try:", "website", "Remember this device", "Additional links:", "Facebook", "Twitter", "Open new account", "More products and services"]
    $scan_deposit_check_text_array = ["Deposit Checks", "To", "Amount", "max:", "1,000.00", "Front", "Cancel"]
    $bill_pay_screen_text_array = ["Pay Bills", "Make a new payment"]
    $account_history_text_array = ["Account History", "Available", "Current", "Transfer money"]

    # reset adb log buffer
    system("adb -s #{device} logcat -c")
    # create adb log file for the test device in local dir
    system("echo ------------------------------------------------- >> ADB_Log_#{device}.log")
    system("echo Creating ADB log file for device #{device} >> ADB_Log_#{device}.log")
    system("echo ------------------------------------------------- >> ADB_Log_#{device}.log")
    $dunit = true
  else
    # reset adb log buffer at the beginning of each scenario
    system("adb -s #{device} logcat -c")
  end
end

# FI specific credentials configuration
Before('@9901') do
  $username = "cma12"
  $password = "11111"
end

Before('@1000') do
  $username = "cma12"
  $password = "11111"
end

