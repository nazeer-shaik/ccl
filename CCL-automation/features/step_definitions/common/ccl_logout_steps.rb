# To change this template, choose Tools | Templates
# and open the template in the editor.
#require "..\\CCL-automation\\features\\scripts\\common\\ccl_logout_script"
object=Ccl_logout_script.new
 When /^User clicks on logout link/ do
  object.logout
 end
 Then /^We will get Main page/ do
 object.ccl_home
 end