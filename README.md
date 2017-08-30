fung - bash function generator
==================================================

Usage
--------------------------------------------------

1. Download or clone the repository

2. Create a symlink to `fung`

    `$ ln -s $PWD/fung /usr/local/bin/fung`

3. Create a config file (for example, `~/fung.conf`) - see the provided 
   sample config as a starting point.

4. Generate the aliases

    `$ fung ~/fung.conf > ~/.bash_aliases && . ~/.bash_aliases`

5. If your `~/.bash_rc` doesn't already source `~/.bash_aliases`, you can
   add `. ~/.bash_aliases` to the bottom of the file.

