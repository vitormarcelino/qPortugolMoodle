@qtype @qtype_qportugol
Feature: Test duplicating a quiz containing an Assay question
  As a teacher
  In order re-use my courses containing QPortugol questions
  I need to be able to backup and restore them

  Background:
    And the following "courses" exist:
      | fullname | shortname | category |
      | Course 1 | C1        | 0        |
    And the following "question categories" exist:
      | contextlevel | reference | name           |
      | Course       | C1        | Test questions |
    And the following "questions" exist:
      | questioncategory | qtype     | name      | template         |
      | Test questions   | qportugol     | qportugol-001 | editor           |
      | Test questions   | qportugol     | qportugol-002 | editorfilepicker |
      | Test questions   | qportugol     | qportugol-003 | plain            |
    And the following "activities" exist:
      | activity   | name      | course | idnumber |
      | quiz       | Test quiz | C1     | quiz1    |
    And quiz "Test quiz" contains the following questions:
      | qportugol-001 | 1 |
      | qportugol-002 | 1 |
      | qportugol-003 | 1 |
    And I log in as "admin"
    And I am on site homepage
    And I follow "Course 1"

  @javascript
  Scenario: Backup and restore a course containing 3 QPortugol questions
    When I backup "Course 1" course using this options:
      | Confirmation | Filename | test_backup.mbz |
    And I restore "test_backup.mbz" backup into a new course using this options:
      | Schema | Course name | Course 2 |
    And I navigate to "Question bank" node in "Course administration"
    And I should see "qportugol-001"
    And I should see "qportugol-002"
    And I should see "qportugol-003"
    And I click on "Edit" "link" in the "qportugol-001" "table_row"
    Then the following fields match these values:
      | Question name              | qportugol-001                                               |
      | Question text              | Please write a story about a frog.                      |
      | General feedback           | I hope your story had a beginning, a middle and an end. |
      | Response format            | HTML editor                                             |
      | Require text               | Require the student to enter text                       |
    And I press "Cancel"
    And I click on "Edit" "link" in the "qportugol-002" "table_row"
    Then the following fields match these values:
      | Question name              | qportugol-002                                               |
      | Question text              | Please write a story about a frog.                      |
      | General feedback           | I hope your story had a beginning, a middle and an end. |
      | Response format            | HTML editor with file picker                            |
      | Require text               | Require the student to enter text                       |
    And I press "Cancel"
    And I click on "Edit" "link" in the "qportugol-003" "table_row"
    Then the following fields match these values:
      | Question name              | qportugol-003                                               |
      | Question text              | Please write a story about a frog.                      |
      | General feedback           | I hope your story had a beginning, a middle and an end. |
      | Response format            | Plain text                                              |
      | Require text               | Require the student to enter text                       |
