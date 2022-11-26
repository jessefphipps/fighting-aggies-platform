Feature: file upload

@button_inactive_before_file_select
  Scenario: user uploads corrupted file
    Given the user is logged in and on dashboard
    Then the report generation button is disabled

@button_inactive_before_upload
  Scenario: user uploads corrupted file
    Given the user is logged in and on dashboard
    Given the user has uploaded a good file
    Then the report generation button is disabled

@report_generation_correct
  Scenario: user uploads file successfully
    Given the user is logged in and on dashboard
    Given the user has uploaded a good file and uploaded
    When user clicks the generate report button
    Then the reports pane should be populated
