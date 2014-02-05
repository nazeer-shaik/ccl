# To change this template, choose Tools | Templates
# and open the template in the editor.

#object=Ccl_login_script.new

Given /^I am on Cisco Collaborative Learning page$/ do
 on_page("Ccl_login_script")
 $current_page.login
 
 end
Then /^Giving valid Username and Password$/ do
$current_page.user_credentials
#object.user_credentials
 end
 And /^Clicking on login Button$/ do
$current_page.login_click
 #object.login_click
 end

