Given ('the user is on the login page') do
    @browser.navigate.to(@login_url)
end

Given ('the user provides correct email and password') do
    @browser.find_element(:id, "username").send_keys("admin@example.com")
    @browser.find_element(:id, "password").send_keys("123456")
end

Given ('the user provides invalid password') do
    @browser.find_element(:id, "username").send_keys("admin@example.com")
    @browser.find_element(:id, "password").send_keys("123")
end

Given ('the user provides invalid email') do
    @browser.find_element(:id, "username").send_keys("admin@exampl.com")
    @browser.find_element(:id, "password").send_keys("123456")
end

Given ('the user provides bad email') do
    @browser.find_element(:id, "username").send_keys("admin")
    @browser.find_element(:id, "password").send_keys("123456")
end

When ('they click the login button') do
    @browser.find_element(:id, "login-button").click()
    sleep(1)
end

Then ('they should be redirected to dashboard and see their username and a logout button') do
    raise "Fail" if not @browser.find_element(:id, "logout-button")
end

Then ('they should get a negative feedback --wrong password') do
    raise "Fail" if @browser.find_element(:id, "error-message").text != "Firebase: The password is invalid or the user does not have a password. (auth/wrong-password)."
end

Then ('they should get a negative feedback --user not found') do
    raise "Fail" if @browser.find_element(:id, "error-message").text != "Firebase: There is no user record corresponding to this identifier. The user may have been deleted. (auth/user-not-found)."
end

Then ('they should get a negative feedback --bad email') do
    raise "Fail" if @browser.find_element(:id, "error-message").text != "Firebase: The email address is badly formatted. (auth/invalid-email)."
end
