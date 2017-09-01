Feature: Connect

Background:
  Given the variable "ALF_RC_FILE" is "0"

Scenario: Run alf connect without repo
   When I run "alf connect"
   Then the output should match "ERROR: Please provide a repo name or URL."
    And the exit code should mean failure

Scenario: Run alf connect with a github username
  Given I am in the "fixtures/connect" folder
   When I run "alf connect JohnSnow"
   Then the output should match "clone  https://github.com/JohnSnow/alf-conf.git"
    And the output should match "write  /.+/connect/alf-conf"

Scenario: Run alf connect with a github username and reponame
  Given I am in the "fixtures/connect" folder
   When I run "alf connect JohnSnow/winterfell"
   Then the output should match "clone  https://github.com/JohnSnow/winterfell.git"
    And the output should match "write  /.+/connect/alf-conf"

Scenario: Run alf connect with a full repo url
  Given I am in the "fixtures/connect" folder
   When I run "alf connect https://bitbucket.com/JohnSnow/winterfell"
   Then the output should match "clone  https://bitbucket.com/JohnSnow/winterfell"
    And the output should match "write  /.+/connect/alf-conf"

