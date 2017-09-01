Alf - Your Little Bash Alias Friend
==================================================

[![Build Status](https://travis-ci.org/DannyBen/alf.svg?branch=tests)](https://travis-ci.org/DannyBen/alf)

---

Alf enhances your bash alias management.

Features
--------------------------------------------------

- Create aliases by using a config file
- Create aliases for sub-commands (for example, `g s` for `git status`)
- Synchronize your aliases across hosts by uploading your config file to 
  GitHub.


Usage
--------------------------------------------------

1. Install the `alf` executable script

    `$ bash <(curl -s https://raw.githubusercontent.com/DannyBen/alf/master/setup)`

2. Create your own `alf-conf` repository  
   The easiest way to use alf is to create a repository on github, call it 
   `alf-conf`, and put an `alf.conf` file in it. See the [`alf.conf`](alf.conf)
   file as a starting poing.

3. Connect alf to your repository

    `$ alf connect <your github user>`
