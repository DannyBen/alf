Feature: Version

Scenario: Run alf --version
   When I run "alf --version"
   Then the output should match "\d+\.\d+\.\d+"
