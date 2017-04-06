@qtype @qtype_qportugol
Feature: Test editing an QPortugol question
  As a teacher
  In order to be able to update my QPortugol question
  I need to edit them

  Background:
    Given the following "users" exist:
      | username | firstname | lastname | email                |
      | teacher1 | T1        | Teacher1 | teacher1@example.com |
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
    And the following "question categories" exist:
      | contextlevel | reference | name           |
      | Course       | C1        | Test questions |
    And the following "questions" exist:
      | questioncategory | qtype | name      | template         |
      | Test questions   | qportugol | qportugol-001 | editor           |
      | Test questions   | qportugol | qportugol-002 | editorfilepicker |
      | Test questions   | qportugol | qportugol-003 | plain            |
    And I log in as "teacher1"
    And I follow "Course 1"
    And I navigate to "Question bank" node in "Course administration"

  Scenario: Edit an QPortugol question
    When I click on "Edit" "link" in the "qportugol-001" "table_row"
    And I set the following fields to these values:
      | Question name | |
    And I press "id_submitbutton"
    Then I should see "You must supply a value here."
    When I set the following fields to these values:
      | Question name   | Edited qportugol-001 name |
      | Response format | No inline text        |
    And I press "id_submitbutton"
    Then I should see "When \"no inline text\" is selected, or responses are optional, you must allow at least one attachment."
    When I set the following fields to these values:
      | Response format | Plain text |
    And I press "id_submitbutton"
    Then I should see "Edited qportugol-001 name"
