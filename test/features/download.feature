Feature: Download

Background:
  Given the variable "ALF_RC_FILE" is "./alfrc"

Scenario: Run alf download
  Given I am in the "fixtures/connect" folder
    And I have already ran "alf connect DannyBen -y"
    And the directory "alf-conf" exists
   When I run "alf download"
   Then the output should match "Pulling from repository"
    And the output should match "Already up.to.date"
    And the exit code should mean success

Scenario: Run alf download without repo connection
  Given I am in the "fixtures/empty" folder
    And the directory "alf-conf" does not exist
   When I run "alf download"
   Then the output should match "ERROR: Cannot find config file"

