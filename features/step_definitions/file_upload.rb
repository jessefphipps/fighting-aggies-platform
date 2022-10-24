Given ('the user is on the dashboard page') do
    @browser.navigate.to(@dashboard_url)
end

# TODO: Specify path for test file(s)

When ('user selects bad files') do
    @browser.find_element(:id, "file_select_button").send_keys("<bad test file loc>")
end

Given ('the user has uploaded a good file') do
    @browser.find_element(:id, "file_select_button").send_keys("<good test file loc>")
end

Then ('user should get a negative feeback --incompatible upload') do
    raise "Fail" if @browser.find_element(:id, "upload_error").text != "Error: Uploaded file is not a video"
end

When ('they click the upload button') do
    @browser.find_element(:id, "file_upload_button").click()
end

Then ('user should get a positive feedback --file uploaded successfully') do
    raise "Fail" if @Browser.find_element(:id, "upload_error").text != "Success: File uploaded"
end
