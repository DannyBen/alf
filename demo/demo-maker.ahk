; --------------------------------------------------
; This script generates the demo svg
; NOTE: This should be executed in the demo folder
; --------------------------------------------------
#SingleInstance Force
SetkeyDelay 0, 50

Return

Type(Command, Delay=2000) {
  Send % Command
  Sleep 500
  Send {Enter}
  Sleep Delay
}

F12::
  Type("{#} Press F11 to abort at any time")
  Type("cd demo")
  Type("rm cast.json {;} rm alf.conf {;} asciinema rec cast.json")
  Type("alf")

  Type("{#} Create a simple alf.conf file")
  Type("vi alf.conf")
  Type("ig: git`n  s: status`n  c: add . --all && git commit -am`n`ndir: ls`n")
  Type("{Escape}:exit")

  Type("{#} Generate and save ~/.bash_aliases")
  Type("alf save")
  Type("source ~/.bash_aliases")

  Type("{#} Inspect any of your aliases")
  Type("alf which g s")

  Type("{#} The new aliases and sub-aliases are available")
  Type("g --version")
  Type("g s")

  Type("{#} ... and accept arguments")
  Type("dir -1")

  Type("exit")
  ; Type("cat cast.json | svg-term --out cast.svg --window")
  Type("agg --font-size 20 cast.json cast.gif")
  Sleep 400
  Type("cd ..")
  Type("{#} Done")
return

^F12::
  Reload
return

F11::
  ExitApp
return
