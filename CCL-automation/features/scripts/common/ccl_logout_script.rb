# To change this template, choose Tools | Templates
# and open the template in the editor.
require "..\\CCL-automation\\features\\scripts\\common\\generic_lib"

class Ccl_logout_script
 
  def initialize
    
  end
 def logout()
   $log.info "I should verify inner window"
 # is_element_present("div","inner_window")
 sleep 10
   button_click("later_button_class")
  sleep 2
  s= span("user_dropdown_class").click
   sleep 2
  $browser.i(:class,"icon-off").click
  sleep 2
   #open "ccl-url"
 end
 def ccl_home()
  $log.info "verifying the CCL login page"
is_element_present("img","camway_img_src")
$log.info "We are in CCL login page"
 end
end
