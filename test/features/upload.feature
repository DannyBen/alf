Feature: Download

Background:
  Given the variable "ALF_RC_FILE" is "./alfrc"

Scenario: Run alf upload
  Given I am in the "fixtures/connect" folder
    And I have already ran "alf connect DannyBen -y"
    And the directory "alf-conf" exists
   When I run "alf upload"
   Then the output should match "Pushing /.*/connect/alf-conf to repository"
    And the output should match "On branch master"

Scenario: Run alf download without repo connection
  Given I am in the "fixtures/empty" folder
    And the directory "alf-conf" does not exist
   When I run "alf upload"
   Then the output should match "ERROR: Cannot find config file"

