Feature: Help

Scenario: Run alf
   When I run "alf"
   Then the output should say "Usage:"
    And the output should not say "Your Little Bash Alias Friend"

Scenario: Run alf --help
   When I run "alf --help"
   Then the output should say "Usage"
    And the output should say "Your Little Bash Alias Friend"
