% alf-connect(1) | Connect to a remote git repository.
% 
% February 2024

NAME
==================================================

**alf connect** - Connect to a remote git repository.

SYNOPSIS
==================================================

**alf connect** REPO [OPTIONS]

DESCRIPTION
==================================================

Connect to a remote git repository.

- Alias: **c**

ARGUMENTS
==================================================

REPO
--------------------------------------------------

Remote GitHub repository to connect to.

Can be one of:

- Your username on GitHub.
  In this case, the repository is expected to be named **alf-conf**.
- Your username/repo on GitHub.
- Any other full URL to a repository.


- *Required*

OPTIONS
==================================================

--ssh
--------------------------------------------------

Connect to GitHub non-interactively using SSH (implies **--yes**).


--https
--------------------------------------------------

Connect to GitHub non-interactively using HTTPS (implies **--yes**).


--yes, -y
--------------------------------------------------

Connect to any remote repository non-interactively.


DEPENDENCIES
==================================================

git
--------------------------------------------------


EXAMPLES
==================================================

~~~
alf connect you --ssh

alf connect you/alf-config

alf connect https://You@bitbucket.org/YourUser/rush-repo.git --yes

~~~

SEE ALSO
==================================================

**alf**(1)


