#Cisco Collaborative Learning file
# Cucumber Automation by SRS Business Solution

@login
Feature: Login to the Cisco Collaborative Learning
    open the cisco collaborative Learning page
    and give valid Login Credentials
    then click login button.

Scenario: TC001 - Login to Cisco Collaborative Learning
 Given  I am on Cisco Collaborative Learning page
 Then   Giving valid Username and Password
 And    Clicking on login Button