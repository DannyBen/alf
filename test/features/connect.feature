Feature: Connect

Background:
  Given I am in the "fixtures/connect" folder
    And the variable "ALF_RC_FILE" is "./alfrc"
    And the directory "alf-conf" does not exist

Scenario: Run alf connect without repo
   When I run "alf connect"
   Then the output should match "ERROR: Please provide a repo name or URL."
    And the exit code should mean failure

@current
Scenario: Run alf connect with a github username
   When I run "alf connect JohnSnow"
   Then the output should match "clone  https://github.com/JohnSnow/alf-conf.git"
    And the output should match "write  /.+/connect/alf-conf"

Scenario: Run alf connect with a github username and reponame
   When I run "alf connect JohnSnow/winterfell"
   Then the output should match "clone  https://github.com/JohnSnow/winterfell.git"
    And the output should match "write  /.+/connect/alf-conf"

Scenario: Run alf connect with a full repo url
   When I run "alf connect https://bitbucket.com/JohnSnow/winterfell"
   Then the output should match "clone  https://bitbucket.com/JohnSnow/winterfell"
    And the output should match "write  /.+/connect/alf-conf"

Scenario: Run alf connect non interactively
  Given the file "alfrc" does not exist
   When I run "alf connect DannyBen -y"
   Then the directory "alf-conf" should exist
    And the file "alf-conf/alf.conf" should exist
    And the file "alfrc" should match "/.*/connect/alf-conf"

