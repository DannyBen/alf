% alf(1) Version 0.6.0 | Your Little Bash Alias Friend
% Danny Ben Shitrit \<https://github.com/dannyben\>
% August 2023

NAME
==================================================

**alf** - Your Little Bash Alias Friend

SYNOPSIS
==================================================

**alf** COMMAND

DESCRIPTION
==================================================

Your Little Bash Alias Friend


COMMANDS
==================================================

alf connect
--------------------------------------------------

Connect to a remote git repository.

alf download
--------------------------------------------------

Perform git pull on the connected repo.

alf upload
--------------------------------------------------

Perform git commit and push on the connected repo.

alf generate
--------------------------------------------------

Generate aliases to stdout.

alf save
--------------------------------------------------

Generate aliases to **~/.bash_aliases**.

alf edit
--------------------------------------------------

Open your **alf.conf** for editing.

alf which
--------------------------------------------------

Show the alias command.

alf upgrade
--------------------------------------------------

Upgrade alf to the latest version.

alf info
--------------------------------------------------

Show all alf related system facts.


ENVIRONMENT VARIABLES
==================================================

ALF_RC_FILE
--------------------------------------------------

Path to alfrc file.

This file holds the path to the alf-conf repository.

Default: **~/.alfrc**



SEE ALSO
==================================================

**alf-connect**(1), **alf-download**(1), **alf-upload**(1), **alf-generate**(1), **alf-save**(1), **alf-edit**(1), **alf-which**(1), **alf-upgrade**(1), **alf-info**(1)

# SOURCE CODE

https://github.com/dannyben/alf

# ISSUE TRACKER

https://github.com/dannyben/alf/issues
