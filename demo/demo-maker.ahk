; --------------------------------------------------
; This script generates the demo svg
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 50

Commands := []
Index := 1

; NOTE: This should be executed in the demo folder

Commands.Push("rm cast.json {;} rm alf.conf {;} asciinema rec cast.json")
Commands.Push("alf")

Commands.Push("{#} Create a simple alf.conf file")
Commands.Push("vi alf.conf")
Commands.Push("ig: git`n  s: status`n  c: add . --all && git commit -am`n`ndir: ls`n")

Commands.Push("{#} Generate and save ~/.bash_aliases")
Commands.Push("alf save")
Commands.Push("source ~/.bash_aliases")

Commands.Push("{#} Inspect any of your aliases")
Commands.Push("alf which g s")

Commands.Push("{#} The new aliases and sub-aliases are available")
Commands.Push("g --version")
Commands.Push("g s")

Commands.Push("{#} ... and accept arguments")
Commands.Push("dir -1")

Commands.Push("exit")
Commands.Push("cat cast.json | svg-term --out cast.svg --window")

F12::
  Send % Commands[Index]
  Index := Index + 1
return

^F12::
  Reload
return

^x::
  ExitApp
return
