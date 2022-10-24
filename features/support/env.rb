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


current_dir = FileUtils.pwd()
dummy_video_path = File.join(current_dir, "storage", "dummy_video.mp4")

Before do |scenario|
	@browser = Selenium::WebDriver.for :chrome, switches: %w[--headless --no-sandbox --disable-gpu --remote-debugin-port=9222 --screen-size=1200x800]
	@login_url = "http://127.0.0.1:8080"
	@bad_file_type_loc = File.join(current_dir, "storage", "supplementary_video.jpg")
	@dummy_file_loc = dummy_video_path
	@good_file_loc = File.join(current_dir, "storage", "supplementary_video.mp4")
	FileUtils.touch(dummy_video_path)
end

After do |scenario|
	@browser.quit
	FileUtils.rm(dummy_video_path)
end

# TODO only create and delete dummy file for corrupted test case
# Before(@file_upload_corrupted) do 
# 	FileUtils.touch(dummy_video_path)
# end

# After(@file_upload_corrupted) do 
# 	FileUtils.rm(dummy_video_path)
# end