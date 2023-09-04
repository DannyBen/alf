% alf.conf(5) alf.conf(5) | File Formats Manual
% Danny Ben Shitrit \<https://github.com/dannyben\>
% September 2023

NAME
==================================================

**alf.conf** - configuration file for alf

DESCRIPTION
==================================================

The **alf.conf** file consists of aliases and the command associated with them.

Base Aliases
--------------------------------------------------

Any line that does not start with a whitespace is considered a base alias.

```
dir: ls -l
```

Sub Aliases
--------------------------------------------------

Any line that starts with one or more whitespaces will be nested as a
sub command of the previous base alias. Note that the command of the base alias
will be used as a prefix to all nested commands.

```
g: git
  s: status
  l: log --all --graph --date=relative
  p: push
```

In this example, running **g s** will execute **git status**.


Reusing Aliases
--------------------------------------------------

You can call an alias from another alias.

```
g: git
  p: push

gg: g p
```

In this example, running **gg** will execute **git push**.

Escape Code
--------------------------------------------------

Sub commands that start with an exclamation mark will not be prefixed by their
base command.

```
dc: docker-compose
  deploy: !docker stack deploy -c docker-compose.yml
  upd: up -d
```

Virtual Command
--------------------------------------------------

When you do not need to prepend your sub aliases with the primary command,
specify an exclamation mark in the primary command.

```
dns: !
  check: host -t ns
  flush: sudo systemd-resolve --flush-caches
```

This example provides two completely different aliases: **dns check** and 
**dns flush**.


SEE ALSO
==================================================

**alf**(1)


SOURCE CODE
==================================================

https://github.com/dannyben/alf


ISSUE TRACKER
==================================================

https://github.com/dannyben/alf/issues
