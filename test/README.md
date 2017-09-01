Test Folder
==================================================

This folder contains scripts for automated testing of `alf`.

It uses Ruby's cucumber testing framework.

Run Tests
--------------------------------------------------

First, make sure that the command `alf` points to the script you want to test.

This can be done either by symlinking `/usr/local/bin/alf` or by adding the 
repo's root folder to the PATH.

Then:

    $ bundle
    $ run features

