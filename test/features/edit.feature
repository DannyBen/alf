Feature: Edit

Scenario: Run alf edit
  Given the variable "EDITOR" is "echo"
   When I run "alf edit"
   Then the output should match "alf.conf"

