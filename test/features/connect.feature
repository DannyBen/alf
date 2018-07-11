Feature: Connect

Background:
  Given I am in the "fixtures/connect" folder
    And the variable "ALF_RC_FILE" is "./alfrc"
    And the directory "alf-conf" does not exist

Scenario: Run alf connect without repo
   When I run "alf connect"
   Then the output should match "ERROR: Please provide a repo name or URL."
    And the exit code should mean failure

Scenario: Run alf connect with a github username
   When I run "alf connect JohnSnow"
  # And I save the output to "output-username.txt"
   Then the output should be like "output-username.txt"

Scenario: Run alf connect with a github username and reponame
   When I run "alf connect JohnSnow/winterfell"
  # And I save the output to "output-reponame.txt"
   Then the output should be like "output-reponame.txt"

Scenario: Run alf connect with a full repo url
   When I run "alf connect https://bitbucket.com/JohnSnow/winterfell"
  # And I save the output to "output-fullname.txt"
   Then the output should be like "output-fullname.txt"

Scenario: Run alf connect non interactively
  Given the file "alfrc" does not exist
   When I run "alf connect https://github.com/DannyBen/alf-conf.git -y"
   Then the directory "alf-conf" should exist
    And the file "alf-conf/alf.conf" should exist
    And the file "alfrc" should match "/.*/connect/alf-conf"

