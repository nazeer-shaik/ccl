##
#
# 
#
# Revision History:
# -----------------
# Creator Name  : Venu J, 09 August 2013
# Modifier By   : <NAME>,<MODIFY DATE>,<REASON>
#
# @description      : Before hooks will be run before the first step of each scenario. They will run in the same order of which they are registered.
#  Cucumber provides a number of hooks which allow us to run blocks at various points in the Cucumber test cycle.
#  You can put them in your support/env.rb file or any other file under the support directory, for example in a file called support/hooks.rb.
#  There is no association between where the hook is defined and which scenario/step it is run for, but you can use tagged hooks (see below) if
#  you want more fine grained control.
#  All defined hooks are run whenever the relevant event occurs.
##

# Before hooks will be run before the first step of each scenario. They will run in the same order of which they are registered.
Before do |scenario|
  $log.debug "\n\nStarting scenario... \"#{scenario.title}\""
 
  
end

#  Take screenshots for pass and fail scenarios
After do |scenario|
  # begin
  if scenario.failed?
    Dir::mkdir('..\\CCL-automation\\report\\screenshots_failed_tests') if not File.directory?('..\\CCL-automation\\report\\screenshots_failed_tests')
    puts "directory created"
    screenshot = "..\\CCL-automation\\report\\screenshots_failed_tests\\FAILED_#{scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}_#{Time.new.to_i}.png"
    $browser.driver.save_screenshot(screenshot)
    embed screenshot, 'image/png'
  end
  # Turn on the below lines if need screen shots for passed scenarios
  #    if scenario.passed?
  #      Dir::mkdir('screenshots_pass_tests') if not File.directory?('screenshots_pass_tests')
  #      #time = Time.now.strftime("%d_%m_%Y_%H:%M:%S")
  #      #puts time
  #      #time = Time.now.to_i
  #      screenshot = "./screenshots_pass_tests/PASSED_#{scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}_#{Time.new.to_i}.png"
  #      @browser.driver.save_screenshot(screenshot)
  #      embed screenshot, 'image/png'
  #    end
  #    if scenario.exception?
  #      # logger
  #    end
  #  end
  #$log.add('console','logfile')
end
