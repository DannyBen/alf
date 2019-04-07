Alf - Your Little Bash Alias Friend
==================================================

![Version](https://img.shields.io/badge/version-0.2.2-blue.svg)
[![Build](https://img.shields.io/travis/DannyBen/alf.svg)](https://travis-ci.org/DannyBen/alf)

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

### 1. Install the `alf` executable script

    $ bash <(curl -s https://raw.githubusercontent.com/DannyBen/alf/master/setup)

If you prefer to install manually, simply download the [alf](/alf) file,
place it somewhere in your path, and make it executable.

### 2. Create your own `alf-conf` repository  

The easiest way to use alf is to create a repository on github, call it 
`alf-conf`, and put an `alf.conf` file in it.

- See the [alf.conf](alf.conf) file as a starting point, or
- Fork my [alf-conf][conf] repository

### 3. Connect alf to your repository

    $ alf connect <your github user>


Usage
--------------------------------------------------

```
$ alf --help
alf - Your Little Bash Alias Friend

Usage:
  alf c|connect REPO [-y]
    Connect to a remote git repository.
    REPO can be:
    - Your username on GitHub. In this case, we will assume the
      repository is named 'alf-conf'
    - Your username/repo on GitHub
    - Any other full URL to a repository
    In case the -y flag is specified, the operation will be
    executed without prompting for confirmation.

  alf d|download
    Perform 'git pull' on a previously connected repo

  alf u|upload
    Perform 'git commit' and 'git push' on a previously connected
    repo

  alf g|generate
    Generate aliases from the config file in the connected repo
    to stdout

  alf s|save
    Generate aliases and save to ~/.bash_aliases

  alf e|edit
    Open your alf.conf for editing

  alf w|which CODE [SUBCODE]
    Shows the alias command

  alf -u|--upgrade|upgrade
    Upgrade alf to latest version

  alf -h|--help|help
    Show this message

  alf -v|--version|version
    Show version number
```

---

For a similar project, but for command shortcuts on a per-directory basis, 
see [opcode][opcode].


---

[conf]: https://github.com/DannyBen/alf-conf
[opcode]: https://github.com/DannyBen/opcode
