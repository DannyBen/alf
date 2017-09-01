Feature: Generate

Background:
  Given the variable "ALF_RC_FILE" is "0"

Scenario: Run alf generate when alf.conf is present
  Given I am in the "fixtures/generate" folder
   When I run "alf generate"
   Then the output should be like "output1.txt"

Scenario: Run alf generate when alf.conf is not present
  Given I am in the "fixtures/empty" folder
   When I run "alf generate"
   Then the output should match "ERROR: Cannot find config file"
    And the exit code should mean failure

