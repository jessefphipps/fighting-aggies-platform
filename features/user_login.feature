Feature: user login
  
  # test bad path first because logout is not done
  Scenario: user login bad path 1
    Given the user is on the login page
    Given the user provides invalid password
    When they click the login button
    Then they should get a negative feedback --wrong password
  
  Scenario: user login bad path 2
    Given the user is on the login page
    Given the user provides invalid email
    When they click the login button
    Then they should get a negative feedback --user not found
  
  Scenario: user login bad path 3
    Given the user is on the login page
    Given the user provides bad email
    When they click the login button
    Then they should get a negative feedback --bad email
  
  Scenario: user login correct path
    Given the user is on the login page
    Given the user provides correct email and password
    When they click the login button
    Then they should be redirected to dashboard and see their username and a logout button

  Scenario: user logout
    Given the user is logged in and on dashboard
    When they click the logout button
    Then they should be logged out and redirected to login page