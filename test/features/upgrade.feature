Feature: Upgrade

Scenario: Run alf --upgrade
   When I run "alf --upgrade"
   Then the output should match "This operation will download the alf bash script"
    And the exit code should mean success
