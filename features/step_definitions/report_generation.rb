Given ('the user has uploaded a good file and uploaded') do
    @browser.find_element(:id, "file_select_button").send_keys(@good_file_loc)
    sleep(3)
    @browser.find_element(:id, "file_upload_button").click()
    sleep(3)
end

When ('user clicks the generate report button') do
    @browser.find_element(:id, "fetch_results_button").click()
    sleep(3)
end

Then ('the report generation button is disabled') do
    raise "Fail" if @browser.find_element(:id, "fetch_results_button").enabled?
end

Then ('the reports pane should be populated') do
    raise "Fail" if @browser.find_elements(:name, "tab_results").size() == 0
end