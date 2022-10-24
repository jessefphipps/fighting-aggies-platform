Given ('the user is on the dashboard page') do
    @browser.navigate.to(@dashboard_url)
end

Given ('the user has uploaded a good file') do
    @browser.find_element(:id, "file_select_button").send_keys(@good_file_loc)
end

When ('user selects incorrect file type') do
    @browser.find_element(:id, "file_select_button").send_keys(@bad_file_type_loc)
end

When ('user selects corrupted file') do
    @browser.find_element(:id, "file_select_button").send_keys(@dummy_file_loc)
end

When ('user clicks the upload button') do
    @browser.find_element(:id, "file_upload_button").click()
end

Then ('user should get negative feeback --incompatible upload type') do
    raise "Fail" if @browser.find_element(:id, "upload_error").text != "Error: Uploaded file is not a video"
end

Then ('user should get negative feeback --incompatible upload file') do
    raise "Fail" if @browser.find_element(:id, "upload_error").text != "Error: Cannot read the video file"
end

Then ('user should get positive feedback --file uploaded successfully') do
    raise "Fail" if @browser.find_element(:id, "file_details").text != "Uploaded File Details:"
end