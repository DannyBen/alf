Feature: Save

Background:
  Given the variable "ALF_RC_FILE" is "0"
    And the variable "ALF_ALIASES_FILE" is "aliases.txt"

Scenario: Run alf save when alf.conf is present
  Given I am in the "fixtures/generate" folder
    And the file "aliases.txt" does not exist
   When I run "alf save"
   Then the file "aliases.txt" should be like "output1.txt"

Scenario: Run alf save when alf.conf is not present
  Given I am in the "fixtures/empty" folder
    And the file "aliases.txt" does not exist
   When I run "alf save"
   Then the output should match "ERROR: Cannot find config file"
    And the exit code should mean failure
    And the file "aliases.txt" should not exist

