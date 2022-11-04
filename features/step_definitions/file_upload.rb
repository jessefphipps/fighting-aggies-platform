Given ('the user has uploaded a good file') do
    @browser.find_element(:id, "file_select_button").send_keys(@good_file_loc)
    sleep(1)
end

When ('user selects incorrect file type') do
    @browser.find_element(:id, "file_select_button").send_keys(@bad_file_type_loc)
    sleep(1)
end

When ('user selects corrupted file') do
    @browser.find_element(:id, "file_select_button").send_keys(@dummy_file_loc)
    sleep(1)
end

When ('user clicks the upload button') do
    @browser.find_element(:id, "file_upload_button").click()
    sleep(3)
end

Then ('user should get negative feedback --incompatible upload type') do
    raise "Fail" if @browser.find_element(:id, "select_error").text != "Error: selected file type is not supported. Try again."
end

Then ('user should get negative feedback --incompatible upload file') do
    raise "Fail" if @browser.find_element(:id, "upload_error").text != "Error: Cannot read the video file"
end

Then ('user should get positive feedback --file uploaded successfully') do
    raise "Fail" if @browser.find_element(:id, "file_details").text != "Uploaded File Details:"
end

Then ('the upload button is disabled') do
    raise "Fail" if @browser.find_element(:id, "file_upload_button").enabled?
end
