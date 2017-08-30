fung - bash function generator
==================================================

Usage
--------------------------------------------------

1. Download or clone the repository

2. Create a symlink to `fung`

    $ ln -s $PWD/fung /usr/local/bin/fung

3. Create a config file (for example, ~/fung.conf) - see the provided 
   sample config.

4. Generate the aliases

    $ fung ~/fung.conf > ~/.bash_aliases && . ~/.bash_aliases
