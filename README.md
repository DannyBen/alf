alf - Your Little Bash Alias Friend
==================================================

Usage
--------------------------------------------------

1. Create your `alf` executable

    `$ sudo bash -c "curl -s https://raw.githubusercontent.com/DannyBen/alf/master/alf > /usr/local/bin/alf && chmod a+x /usr/local/bin/alf"`

2. Create your own `alf-conf` repository
   The easiest way to use alf is to create a repository on github, call it 
   `alf-conf`, and put an `alf.conf` file in it. See the [`alf.conf`][/alf.conf]
   file as a starting poing.

3. Connect alf to your repository

    $ alf connect <your github user>
