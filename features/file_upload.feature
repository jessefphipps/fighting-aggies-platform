Feature: file upload

#   TODO: Implement file upload assertion
#   Scenario: user tries uploading to server before selecting folder
#     Given the user is on the dashboard page
#     Given the user has not selected a file yet
#     When they click the upload button
#     Then the button is disabled and are met with the message "Please select a file first"

  Scenario: user uploads incompatible file type
    Given the user is on the dashboard page
    When user selects incorrect file type
    When user clicks upload button
    Then user should get negative feeback --incompatible upload type

  Scenario: user uploads corrupted file
    Given the user is on the dashboard page
    When user selects corrupted file
    When user clicks upload button
    Then user should get negative feeback --incompatible upload file

@file_upload_correct
  Scenario: user uploads file successfully
    Given the user is on the dashboard page
    Given the user has uploaded a good file
    When user clicks the upload button
    Then they should get "file uploaded successfully" message
