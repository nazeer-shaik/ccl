require 'watir-webdriver'
require 'log4r'
require 'page-object'
#require '..\\CCL-automation\\features\\scripts\\common'
include Log4r

require '..\\CCL-automation\\features\\scripts\\common\\hooks'


LOG4R_LOGS_DIR="..\\CCL-automation\\report\\log"
LOG4R_LOGGER_NAME="MYLOG"
LOG4R_LOGS_FILE="#{LOG4R_LOGGER_NAME}.log"

# create a logger
$log = Log4r::Logger.new("#{LOG4R_LOGGER_NAME}")

# format the log4r message pattern
fmtr = PatternFormatter.new(:pattern => "%d [%l] %m \n \t\t [%t]")

# to log about the info where log method was called
$log.trace = true

#Create a directory 'logs' for ccl test log
Dir::mkdir("#{LOG4R_LOGS_DIR}") if not File.directory?("#{LOG4R_LOGS_DIR}")
$log.info "Created logs directory."

# define log4r outputters
Log4r::StdoutOutputter.new('console', :formatter => fmtr)
Log4r::FileOutputter.new('logfile',
  :filename=>"#{LOG4R_LOGS_DIR}/#{LOG4R_LOGS_FILE}",
  :trunc=>false,
  :formatter => fmtr
)
$log.add('console','logfile')

$log.info "Started configuring automation environment..."
$log.info "Logger Directory Name: #{LOG4R_LOGS_DIR}"
$log.info "Log File Name: #{LOG4R_LOGS_FILE}"
#$log.info "Failed Scenarios Snapshots Directory Name: #{FAILED_SCENARIOS_SCREENSHOTS_DIR}"

#----------------------method to access object-------------------
$current_page=" "
def on_page(ele)
puts ele
  $current_page="..\\CCL-automation\\features\\scripts\\common\\#{ele}".new
  end


#----------Reading properties files-------------------------------------
def load_properties(properties_filename)
  properties = {}
    File.open("#{properties_filename}", 'r') do |properties_file|
      properties_file.read.each_line do |line|
        line.strip!
        if (line[0] != ?# and line[0] != ?=)
          i = line.index('=')
          if (i)
            properties[line[0..i - 1].strip] = line[i + 1..-1].strip
          else
            properties[line] = ''
          end
        end
      end
    end
   return properties
end

  $array=load_properties '..\\CCL-automation\\configuration\\webele.properties'
  $array1=load_properties '..\\CCL-automation\\configuration\\data.properties'
  $array2=load_properties '..\\CCL-automation\\configuration\\config.properties'

#------------------ method for opening the browser---------------------------
def open_browser (ele)

   but_ref=$array2["#{ele}"]
  if but_ref == "firefox"
 $log.info "Firefox browser is going to open"
  $browser = Watir::Browser.new :firefox
  elsif but_ref== "ie"
 $log.info "Internet browser is going to open"
 $browser = Watir::Browser.new :ie
  elsif but_ref == "chrome"
  $log.info "Chrome browser is going to open"
    profile = Selenium::WebDriver::Chrome::Profile.new
    profile['download.prompt_for_download'] = false
    profile['download.default_directory'] = "D:\\CCL -naz\\configuration"
  $browser = Watir::Browser.new :chrome, :profile => profile
	else
	fail_screenshot
	 $log.info "failed to open the #{ele} browser"
   raise("failed to open the #{ele} browser")  
  end
  $browser.window.resize_to(1616,876)
end

#----------------------opening the url----------------------------------
def open (url)
$log.info "Url is given to the browser"
  but_ref=$array2["#{url}"]
  #ref=but_ref.split(" ").last
 $log.info "opening the given application"
 $browser.goto(but_ref)
end


#-------------------get the webelement--------------------------
  def get_webele(ele)
    s=$array["#{ele}"]
                      if s.split(" ").first == "xpath"
                            puts s.split(" ").last
                    elsif s.split(" ").first == "id"
                            puts s.split(" ").last
                      elsif s.split(" ").first == "name"
                            puts s.split(" ").last
                      elsif s.split(" ").first == "value"
                            puts s.split(" ").last
                    else
                      $log.error "Failed to click a button: #{ele}!"
                      raise Exception.new("Failed to locate click a button: #{ele}!")
            end
  end
  
  #--------------------button click operation------------------------
def button_click(ele)
 ref=$array["#{ele}"]
   
   path=ele.split("_").last
  $log.info "verifying #{ele} is available or not"
  puts path
  puts ref
 if $browser.button(:"#{path}" ,"#{ref}").exists?
  $log.info "#{ele} is displayed"
   $browser.button(:"#{path}" ,"#{ref}").click
  $log.info "#{ele} is clicked"
      else
   $log.error "failed to find the #{ele}"
   raise("failed to find the #{ele}")  
 end
                
end
#------------------------span operation---------------------------------
def span(ele)
  ref=$array["#{ele}"]
   path=ele.split("_").last
  $log.info "verifying #{ele} is available or not"
 if $browser.span(:"#{path}" , "#{ref}").exists?
  $log.info "#{ele} is displayed"
  return $browser.span(:"#{path}" , "#{ref}")
 else
   $log.error "failed to find the #{ele}"
   raise("failed to find the #{ele}")
 end
end
#-------------------image button click operation---------------------------------
def link_click(ele)
 ref=$array["#{ele}"]
   path=ele.split("_").last
     $log.info "verifying the #{ele} present or not "
     if $browser.link(:"#{path}", "#{ref}").exists?
       $log.info "#{ele} is prsented on the webpage"
     $browser.link(:"#{path}", "#{ref}").click
      $log.info "clicked the #{ele} link"

  elsif $browser.span(:"#{path}", "#{ref}").exists?
       $log.info "{ele} is presented on the webpage"
       $browser..span(:"#{path}", "#{ref}").click
       $log.info "clicked the #{ele}"
   else
     $log.info "failed to find the #{ele} link"
     raise("failed to find the #{ele} link")  
   end
   
  
end
#-----------------------checkbox check operation-------------------
def checkbox_check(ele)

  ref=$array["#{ele}"]
   path=ele.split("_").last
  	 $log.info "verifying the #{ele} availability"
   if $browser.checkbox(:"#{path}", "#{ref}").exists?
     $log.info "#{ele} is available"
     $browser.checkbox(:"#{path}", "#{ref}").set
	 $log.info "#{ele} is set"
   else
     log.info "failed to find the #{ele} checkbox"
     raise("failed to find the #{ele} checkbox")  
   end
    
end

def checkbox_uncheck(ele)
 ref=$array["#{ele}"]
  path=ele.split("_").last
   if $browser.checkbox(:"#{path}", "#{ref}").exists?
     $browser.checkbox(:"#{path}", "#{ref}").clear
     puts "clicked the button"
   else
     $log.error "failed to find the #{ele} checkbox"
     raise("failed to find the #{ele} checkbox")  
   end
   

end
#----------------------Radiobutton check operation----------------------
def radiobutton_check(ele)
 ref=$array["#{ele}"]
   path=ele.split("_").last
   if $browser.radio(:"#{path}", "#{ref}").exists?
     $browser.radio(:"#{path}", "#{ref}").set
     puts "clicked the radio button"
   else
     $log.error "failed to find the #{ele} radio button"
     raise("failed to find the #{ele} radio button")  
   end
   
end
def radiobutton_uncheck(ele)
 ref=$array["#{ele}"]
   path=ele.split("_").last
   if $browser.radio(:"#{path}", "#{ref}").exists?
     $browser.radio(:"#{path}", "#{ref}").clear
     puts "uncheck the radio button"
   else
     log.info "failed to find the #{ele} radio button"
     raise("failed to find the #{ele} radio button")  
   end
   
end
#--------------------selectionbox opeation--------------------------------
def list_select(ele,option)
 ref=$array["#{ele}"]
   path=ele.split("_").last
   if $browser.select_list(:"#{path}", "#{ref}").exists?
     $browser.select_list(:"#{path}", "#{ref}").set("#{option}")
     puts "selected option from list"
   else
     log.info "failed to find the #{ele} select list"
     raise("failed to find the #{ele} select list")  
   end
   
end
def list_unselect(ele)
   ref=$array["#{ele}"]
   path=ele.split("_").last
   if $browser.select_list(:"#{path}", "#{ref}").exists?
     $browser.select_list(:"#{path}", "#{ref}").clearSelection
     puts "unslected the list"
   else
     log.info "failed to find the #{ele} select list"
     raise("failed to find the #{ele} select list")  
   end
   
end
def list_getall(ele)
   ref=$array["#{ele}"]
   path=ele.split("_").last
 if $browser.select_list(:"#{path}", "#{ref}").exists?
   return $browser.select_list(:"#{path}", "#{ref}").getAllContents
     puts "sending all contents from select option"
   else
     $log.error "failed to find the #{ele} select list"
     raise("failed to find the #{ele} select list")  
   end
   
end
#-------------------TextField operation--------------------
def text_field(ele,data)
  ref=$array["#{ele}"]
     path=ele.split("_").last
     #-----getting data from the data.properties-----
       dat=$array1["#{data}"]
      $log.info "verifying #{ele} is available or not"    
     if $browser.text_field(:"#{path}", "#{ref}").exists?
	 $log.info "#{ele} is available"
     $browser.text_field(:"#{path}", "#{ref}").send_keys("#{dat}")
     $log.info "Entered the text in #{ele}"
   else
     $log.info "failed to find the #{ele} "
     raise("failed to find the #{ele} ")  
   end
  
end
#-------------------verifying the element present or not-------------------------
def is_text_present(ele)
  $log.info "verifying #{ele} present or not"
   if s=$browser.button(:id, "#{ele}").exists?
   $log.info "{ele} available on the page"
   elsif
     $log.info "failed to find the element: #{ele}!"
     raise Exception.new("Failed to find the element: #{ele}!")
   end
  
end
#-------------------to retrive the text of given element------------------
def get_text(type,ele)
  ref=$array["#{ele}"]
   path=ele.split("_").last
       if type == "button"
         return $browser.button(:"#{path}", "#{ref}").text
       elsif type == "div"
         return $browser.div(:"#{path}", '"#{ref}"').text
       elsif type == "span"
         return $browser.span(:"#{path}", "#{ref}").text
       elsif type == "link"
         return $browser.link(:"#{path}", "#{ref}").text
       elsif type == "h2"
         return $browser.h2(:"#{path}", "#{ref}").text
     else
       $log.error "failed to find the #{ele} text"
       raise("failed to find the #{ele} text")  
     end
    
end

#-------------------verifying the text present or not---------------------------
def is_element_present(type,ele)
  ref=$array["#{ele}"]
        
         path=ele.split("_").last
         val=""
         if type == "button"
           val=$browser.button(:"#{path}", "#{ref}").exists?
          
         elsif type == "link"
           val=$browser.link(:"#{path}", "#{ref}").exists?
          
         elsif type == "checkbox"
           val=$browser.checkbox(:"#{path}", "#{ref}").exists? 
            
         elsif type == "textfield"
           val=$browser.text_field(:"#{path}", "#{ref}").exists?
           
         elsif type == "radiobutton"
           val=$browser.radio(:"#{path}", "#{ref}").exists?
            
         elsif type == "list"
           val=$browser.select_list(:"#{path}", "#{ref}").exists?
           
           elsif type == "img"
            val=$browser.img(:"#{path}", "#{ref}").exists?
            
          elsif type == "div"
             val=$browser.div(:"#{path}", "#{ref}").exists?
             
         else
            $log.info "{ele} is not present"
           raise("given type is not found")
         end
         if val
            $log.info "given #{ele} present on the page"
         else
           $log.info " fail to find the element"
           raise("given #{ele} does not exists")
         end
end
#-------------------comparing the text with given text--------------------

def assert_equal(type,expected, actual)
  text1=get_text(type,expected)
  text2=$array1["#{actual}"] 
    puts text1
    puts text2
  if text1 == text2
   puts "given text is available"
  elsif 
    $log.error "given #{expected} text is not displayed"
    raise("given #{expected} text is not displayed")
  end
end
#-------------------------------screenshot for fail-----------------------------------
#def fail_screenshot()
#Dir::mkdir('..\\CCL\\report') if not File.directory?('..\\CCL -\\report')
#    screenshot = "./screenshots_failed_tests/FAILED_#{scenario.name.gsub(' ','_').gsub(/[^0-9A-Za-z_]/, '')}_#{Time.new.to_i}.png"
#    $browser.driver.save_screenshot(screenshot)
#    embed screenshot, 'image/png'
#end
#-----------------------------------------After scenario----------------------------------

