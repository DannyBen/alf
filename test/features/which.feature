Feature: Which

Background:
  Given the variable "ALF_RC_FILE" is "0"
    And I am in the "fixtures/generate" folder

Scenario: Run alf which without parameters
   When I run "alf which"
   Then the output should match "ERROR: Please provide a code."
    And the exit code should mean failure

Scenario: Run alf which CODE
   When I run "alf which g"
   Then the output should say "git"
    And the exit code should mean success

Scenario: Run alf which CODE SUBCODE
   When I run "alf which g l"
   Then the output should say "git log --all --graph --date=relative"
    And the exit code should mean success

Scenario: Run alf which CODE with invalid code
   When I run "alf which no"
   Then the output should say "Error: No such alias: no"
    And the exit code should mean failure

Scenario: Run alf which CODE SUBCODE with invalid code
   When I run "alf which g no"
   Then the output should say "Error: No such alias: g no"
    And the exit code should mean failure

Scenario: Run alf which CODE SUBCODE with escaped code
   When I run "alf which dc deploy"
   Then the output should match "^docker stack deploy -c docker-compose.yml$"
    And the exit code should mean success

Scenario: Run alf which CODE SUBCODE on a separated code
   When I run "alf which dc upd"
   Then the output should match "^docker-compose up -d"
    And the exit code should mean success
