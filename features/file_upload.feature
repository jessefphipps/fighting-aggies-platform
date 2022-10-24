Feature: file upload

  Scenario: user tries uploading to server before selecting folder
    Given the user is logged in and on dashboard
    Then the upload button is disabled

  Scenario: user uploads incompatible file type
    Given the user is logged in and on dashboard
    When user selects incorrect file type
    When user clicks the upload button
    Then user should get negative feeback --incompatible upload type

@file_upload_corrupted
  Scenario: user uploads corrupted file
    Given the user is logged in and on dashboard
    When user selects corrupted file
    When user clicks the upload button
    Then user should get negative feeback --incompatible upload file

@file_upload_correct
  Scenario: user uploads file successfully
    Given the user is logged in and on dashboard
    Given the user has uploaded a good file
    When user clicks the upload button
    Then user should get positive feedback --file uploaded successfully
