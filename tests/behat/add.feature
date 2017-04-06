@qtype @qtype_qportugol
Feature: Test creating an QPortugol question
  As a teacher
  In order to test my students
  I need to be able to create an QPortugol question

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email               |
      | teacher1 | T1        | Teacher1 | teacher1@moodle.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
    And I log in as "teacher1"
    And I follow "Course 1"
    And I navigate to "Question bank" node in "Course administration"

  Scenario: Create an QPortugol question with Response format set to 'HTML editor'
    When I add a "QPortugol" question filling the form with:
      | Question name            | qportugol-001                      |
      | Question text            | Write an qportugol with 500 words. |
      | General feedback         | This is general feedback       |
      | Response format          | HTML editor                    |
    Then I should see "qportugol-001"

  Scenario: Create an QPortugol question with Response format set to 'HTML editor with the file picker'
    When I add a "QPortugol" question filling the form with:
      | Question name            | qportugol-002                      |
      | Question text            | Write an qportugol with 500 words. |
      | General feedback         | This is general feedback       |
      | Response format          | HTML editor                    |
    Then I should see "qportugol-002"
