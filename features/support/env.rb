# require 'rubygems'
# require 'watir'

# # open browser and maximize before test

# Before do |scenario|
#     browser = watir::Browser.new :chromex
#     $browser = browser
#     $browser.driver.manage.window.maximize
# end



# # close browser after test

# After do |scenario|
#     $browser.close
# end

require 'selenium-webdriver'
require 'fileutils'

# capabilities = Selenium::WebDriver::Remote::Capabilities.new
# capabilities['platform'] = ENV['SELENIUM_PLATFORM'] || 'ANY'
# capabilities['name'] = 'My first Test'
# capabilities['browserName'] = ENV['SELENIUM_BROWSER'] || 'chrome'
# capabilities['version'] = ENV['SELENIUM_VERSION'] if ENV['SELENIUM_VERSION']

# browser = Selenium::WebDriver.for :chrome, capabilities: capabilities
# args = ['ignore-certificate-errors', 'disable-popup-blocking', 'disable-translate', 'no-sandbox', 'disable-dev-shm-usage']

# options = Selenium::WebDriver::Chrome::Options.new(args: args)
# @browser = Selenium::WebDriver.for :chrome, options: options
browser = Selenium::WebDriver.for :chrome, switches: %w[--headless --no-sandbox --disable-gpu --remote-debugin-port=9222 --screen-size=1200x800]

dummy_video_path = Rails.root.join("storage", "dummy_video.mp4").to_s

Before do |scenario|
	@browser = browser
	@login_url = "https://fightin-aggies.herokuapp.com/"
	@dashboard_url = "https://fightin-aggies.herokuapp.com/dashboard"
	@bad_file_type_loc = Rails.root.join("storage", "supplementary_video.jpg").to_s
	@dummy_file_loc = dummy_video_path
	@good_file_loc = Rails.root.join("storage", "supplementary_video.mp4").to_s
	FileUtils.touch(dummy_video_path)
end

After do |scenario|
	FileUtils.rm(dummy_video_path)
end
# at_exit do
# 	browser.quit
# end