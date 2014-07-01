# login/logout method

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
def invalid_login(arg)
  performAction('clear_id_field', $member_number_field_id)
  performAction('enter_text_into_id_field', $username, $member_number_field_id)
  performAction('enter_text_into_id_field', arg, $password_field_id)
  performAction('press_button_with_text', $loginbutton)
end
def logout_action()
  if !is_logged_out?
    performAction('click_on_view_by_id', 'app_header_logout')
    if is_logout_during_mfa?
      performAction('press_button_with_text', $label_mfa_start_over)
    else
      performAction('press_button_with_text', $label_yes)
    end
    performAction('wait_for_button', $loginbutton)
  end
end
def is_logged_out?
  begin
    #performAction('assert_text', $signup_label, true)
    performAction('wait_for_text', $signup_label, 5)
    true
  rescue Exception => e
    false
  end
end
def is_logout_during_mfa?
  begin
    performAction('assert_text', $label_mfa_start_over, true)
    true
  rescue Exception => e
    false
  end
end

# screen scanner methods
def screen_scanner(screen_label)
  case screen_label
    when "More_screen_with_user_logged_in"
      $text_array = $more_screen_text_array_logged_in
    when "Locations_screen"
      $text_array = $locations_screen_text_array
    when "MFA_screen"
      $text_array = $mfa_screen_text_array
    when "More_screen_with_user_logged_out"
      $text_array = $more_screen_text_array_logged_out
    when "Login_screen_with_no_persistence"
      $text_array = $login_screen_text_array_maskedOFF
    when "Login_screen_with_persistence"
      $text_array = $login_screen_text_array_maskedON
    when "Cash_back_offers_screen"
      $text_array = $cash_back_offers_screen_text_array
    when "Offer_detail_screen"
      $text_array = $offer_detail_screen_text_array
    when "Transfers_screen"
      $text_array = $transfer_screen_text_array
    when "scan_deposit_screen"
      $text_array = $scan_deposit_check_text_array
    when "Bill_pay_screen"
      $text_array = $bill_pay_screen_text_array
    when "Account_history_screen"
      $text_array = $account_history_text_array
  end
  $text_array.each do |arg|
    performAction('assert_text', arg, true)
  end
  custom_screenshot screen_label
end
def custom_screenshot(arg)
  screenshot_embed(:name => arg)
end

# button methods
def touch_button(arg1)
  performAction('press_button_with_text', arg1)
end
def check_button(arg)
  performAction('wait_for_button', arg)
end

# text methods
def check_text(arg)
  performAction('wait_for_text', arg, 120)
  performAction('assert_text', arg, true)
end
def touch_text(arg)
  performAction('wait_for_text', arg)
  performAction('click_on_text', arg)
end

# property validator method
def property_validator(field, property, value)
  if field == "Member Number"
    view_id = $member_number_field_id
  end
  if value == "masked"
    value = $username
    value[0..3] = "****"
  end
  performAction('assert_view_property', view_id, property, value)
end

# selective row picker methods
def select_account
  wait_seconds 2
  accounts_array = query("textview", "text")
  touch_text accounts_array[2]
  wait_seconds 2
end
def select_transfer_accounts(arg1, arg2)
  touch_text arg1
  wait_seconds 2
  custom_screenshot "Transfer_Account_screen"
  transfers_array = query("textview", "text")
  touch_text transfers_array[1]
  touch_text arg2
  touch_text transfers_array[5]
  wait_seconds 5
end
def select_vendor
  wait_seconds 2
  vendor_array = query("textview", "text")
  touch_text vendor_array[1]
  wait_seconds 2
end
def select_cash_back_offers()
  cash_back_offers_array = query("textview", "text")
  touch_text cash_back_offers_array[9]
  wait_seconds 2
end

# soft keyboard / send keys methods
def calc_field_edit(screen_label)
  case screen_label
    when "Deposit Checks"
      $field_id = $amt_edit_deposit_id
    when "Transfers"
      $field_id = $amt_edit_transfers_id
    when "Bill_pay"
      $field_id = $amt_edit_billpay_id
  end
  performAction('click_on_view_by_id', $field_id)
end
def send_keys(arg)
  system("#{default_device.adb_command}  shell input keyevent #{arg}")
end

# prompt validator methods
def prompt_validator(arg1,arg2,arg3,arg4)
  performAction('wait_for_text', arg1, 60)
  performAction('assert_text', arg1, true)
  performAction('wait_for_text', arg2, 60)
  performAction('assert_text', arg2, true)
  performAction('wait_for_text', arg3, 60)
  performAction('assert_text', arg3, true)
  performAction('wait_for_text', arg4, 60)
  performAction('assert_text', arg4, true)
end

# location methods
def enter_location_info(arg)
  if is_current_location?
    enter_location arg
  else
    if is_gps_warning?
      touch_button "OK"
      enter_location arg
    end
  end
end
def enter_location(arg)
  performAction('enter_text_into_id_field', arg, $loc_search_id)
  performAction('click_on_view_by_id', $loc_list_btn_id)
  wait_seconds 2
end
def is_current_location?
  begin
    performAction('wait_for_text', "Current location", 60)
    true
  rescue Exception => e
    false
  end
end
def is_gps_warning?
  begin
    performAction('wait_for_text', "Warning", 60)
    true
  rescue Exception => e
    false
  end
end
def inspect_location_list
  for row_no in 1..5
    result = performAction('get_list_item_text', '1', row_no)
    response_table = result['bonusInformation']
    response_table.each_with_index do |row_data, index|
      row_data = JSON.parse(row_data)
      response_table[index] = row_data
      val1 = response_table[index]['Txt_address']
      val2 = response_table[index]['Txt_distance']
      val3 = response_table[index]['Txt_type']

      if (val3 == "ATM" || val3 == "Branch" || val3 == "ATM & Branch")
      else
        raise Exception, "ATM or Branch or ATM & Branch expected.  Found #{val3}"
      end

      if  val2.include? "miles"
      else
        raise Exception, "Distance unit expected in miles.  Found #{val2}"
      end
    end
  end
end

# wait methods
def wait_seconds(arg)
  performAction('wait', arg)
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


def random_amount_picker
  digit1 = rand(5)
  digit2 = rand(5)
  digit3 = rand(5)
  digit4 = rand(5)
  digit5 = rand(5)

  case_key_event digit1
  case_key_event digit2
  case_key_event digit3
  case_key_event digit4
  case_key_event digit5

end

def case_key_event(arg)
  case arg
    when 0
      # if random number is 0, then substitute it with 6 by sending key event 13
        send_keys 13
    when 1
      send_keys 8
    when 2
      send_keys 9
    when 3
      send_keys 10
    when 4
      send_keys 11
    when 5
      send_keys 12
  end
end
