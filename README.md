Alf - Your Little Bash Alias Friend
==================================================

[![Build Status](https://travis-ci.org/DannyBen/alf.svg?branch=tests)](https://travis-ci.org/DannyBen/alf)

---

Alf enhances your bash alias management.

Features
--------------------------------------------------

- Create aliases by using a config file
- Create aliases for sub-commands (for example, `g s` for `git status`)
- Synchronize your aliases across hosts or users by uploading your 
  config file to GitHub.


Getting Started
--------------------------------------------------

1. Install the `alf` executable script

    `$ bash <(curl -s https://raw.githubusercontent.com/DannyBen/alf/master/setup)`

2. Create your own `alf-conf` repository  
   The easiest way to use alf is to create a repository on github, call it 
   `alf-conf`, and put an `alf.conf` file in it. See the [`alf.conf`](alf.conf)
   file as a starting point, or fork my [alf-conf][1] repository.

3. Connect alf to your repository

    `$ alf connect <your github user>`


Usage
--------------------------------------------------

    $ alf --help
    alf 0.0.4 - Your Little Bash Alias Friend

    Usage:
      alf connect REPO [-y]
        Connect to a remote git repository.
        REPO can be:
        - Your username on GitHub. In this case, we will assume the
          repository is named 'alf-config'
        - Your username/repo on GitHub
        - Any other full URL to a repository
        In case the -y flag is specified, the operation will be
        executed without prompting for confirmation.

      alf download
        Perform 'git pull' on a previously connected repo

      alf upload
        Perform 'git commit' and 'git push' on a previously connected
        repo

      alf generate
        Generate aliases from the config file in the connected repo
        to stdout

      alf save
        Generate aliases and save to ~/.bash_aliases

      alf -h|--help
        Show this message

      alf -v|--version
        Show version number


---

[1]: https://github.com/DannyBen/alf-conf
