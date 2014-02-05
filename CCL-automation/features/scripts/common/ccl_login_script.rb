# To change this template, choose Tools | Templates
# and open the template in the editor.
require "..\\CCL-automation\\features\\scripts\\common\\generic_lib"

class Ccl_login_script

  def initialize
   
  end

  # --------- login method to open CCL application ---------------------
  def login ()
$log.info "this is opening the firefox"
 open_browser 'browser_name'
 open 'ccl_url'
  $log.info "we have opened the firefox"
end

  #----------- giving the credentials to the CCL login page----------------
def user_credentials()
$log.info "verifying the CCL login page"
is_element_present("img","camway_img_src")
$log.info "We are in CCL login page"
$log.info "verifying the username text field"
      text_field("username_textfield_id","username_text")
$log.info "we are entering valid username"
$log.info "verifying the password text field"
      sleep 2
      text_field("password_textfield_id","password_text")
$log.info "we are entering valid password"

end

#----------------- login_click  to click the login in CCL application--------------
def login_click()
$log.info "verifying the login button"
      sleep 2
      button_click("login_button_id")
$log.info "clicking login button"
 sleep 2
#open 'ccl_url'
sleep 5
end
end
