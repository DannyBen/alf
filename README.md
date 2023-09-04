<div align='center'>
<img src='alf-logo.svg' width=300>

# Alf - Your Little Bash Alias Friend

![Version](https://img.shields.io/badge/version-0.6.0-blue.svg)
[![Build Status](https://github.com/DannyBen/alf/workflows/Test/badge.svg)](https://github.com/DannyBen/alf/actions?query=workflow%3ATest)

</div>

---

Alf enhances your bash alias management. It was developed using the
[Bashly Command Line Framework][bashly].


## Features

- Create aliases by using a config file.
- Create aliases for sub-commands (for example, `g s` for `git status`).
- Synchronize your aliases across hosts or users by uploading your 
  config file to GitHub.
- Does not alter anything in your system except for creating the
  `~/.bash_aliases` file, which is normally already sourced by your login
  process.
- Works with bash and zsh.


## Demo

![Demo](/demo/cast.gif)


## Installation

Install the `alf` executable script:

```bash
$ curl -Ls get.dannyb.co/alf/setup | bash
```

If you prefer to install manually, simply download the [alf](/alf) file,
place it somewhere in your path, and make it executable.

Note that alf requires bash 4.0 or higher (`brew install bash` for mac users).


## Using with GitHub-hosted configuration (recommended)

The easiest way to use alf is to create a repository on github, call it 
`alf-conf`, and put an `alf.conf` file in it.

### 1. Create your own `alf-conf` repository  

- See the [alf.conf](alf.conf) file as a starting point, or
- [Generate a template][template] from my [alf-conf][conf]

### 2. Connect alf to your repository

```shell
$ alf connect <your github user>
```

### 3. Save and source your aliases

```shell
$ alf save
$ source ~/.bash_aliases  # this normally already exists in your ~/.bashrc
```


## Using without GitHub

If you want to try alf before creating your github repo, use this method to
create your `bash_aliases` file from a local configuration file.

### 1. Create your `alf.conf` file

See the sample [alf.conf](alf.conf) file as a starting point.

### 2. Save and source your aliases

```bash
$ alf save
$ source ~/.bash_aliases
```

## Additional usage patterns

```
$ alf --help

alf - Your Little Bash Alias Friend

Usage:
  alf [command]
  alf [command] --help | -h
  alf --version | -v

Commands:
  connect    Connect to a remote git repository
  download   Perform git pull on the connected repo
  upload     Perform git commit and push on the connected repo
  generate   Generate aliases to stdout
  save       Generate aliases to ~/.bash_aliases
  edit       Open your alf.conf for editing
  which      Show the alias command
  upgrade    Upgrade alf to the latest version
  info       Show all alf related system facts

Options:
  --help, -h
    Show this help

  --version, -v
    Show version number

Environment Variables:
  ALF_RC_FILE
    Path to alfrc file
    This file holds the path to the alf-conf repository
    Default: ~/.alfrc
```

## File format reference (`alf.conf`)

- [Sample, documented `alf.conf` file](alf.conf)
- [`alf.conf(5)` man page](doc/alf.conf.md)


## Uninstalling

To uninstall alf:

```shell
# Run the uninstall script 
$ curl -Ls get.dannyb.co/alf/uninstall | bash

# Optionally, remove .alfrc (exists only if you have performed `alf connect`)
$ rm -f ~/.alfrc

# Optionally, remove .bash_aliases (exists only if you have performed `alf save`)
$ rm -f ~/.bash_aliases
```


## Compatibility

Alf was tested on **bash** and **zsh** (and might work with other shells).

In all cases, bash version 4.0 or higher must be installed, since alf uses
associative arrays which are not available in older versions.

If your shell does not automatically source `~/.bash_aliases` on startup, you
should add this line to your startup script:

```shell
source ~/.bash_aliases
```

### ZSH Users

Oh-My-Zsh users may skip this step.

If you would like to have autocompletion for alf's sub-aliases and you are using
zsh, you should enable completion by adding this to your `~/.zshrc` (if is it not
already there) before sourcing `.bash_aliases`:

```bash
# Load completion functions
autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit
```


## Related Projects

For a similar project, but for command shortcuts on a per-directory basis, 
see [opcode][opcode].


## Contributing / Support

If you experience any issue, have a question or a suggestion, or if you wish
to contribute, feel free to [open an issue][issues].

---

[issues]: https://github.com/DannyBen/alf/issues
[conf]: https://github.com/DannyBen/alf-conf
[template]: https://github.com/DannyBen/alf-conf/generate
[opcode]: https://github.com/DannyBen/opcode
[bashly]: https://bashly.dannyb.co
