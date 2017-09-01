#!/usr/bin/env bats
export ALF_SUPRESS_RUN=0

alf=./alf

@test "cli without args, shows usage" {
  run $alf
  [[ "$status" = 0 ]]
  [[ ${lines[0]} = "Usage:" ]]
}

@test "cli --help, shows detailed usage" {
  run $alf --help
  [[ "$status" = 0 ]]
  [[ "${lines[0]}" =~ 'Your Little Bash Alias Friend' ]]
}

@test "cli generate, converts config to bash functions" {
  [[ -f ~/.alfrc ]] && rm ~/.alfrc
  run $alf generate
  [[ "$status" = 0 ]]
  [[ "$output" = "$(<test/fixtures/alf_generate.txt)" ]]
}

@test "cli save, saves functions to .bash_aliases" {
  [[ -f ~/.alfrc ]] && rm ~/.alfrc
  run $alf generate
  [[ "$status" = 0 ]]
  [[ "$output" = "$(<test/fixtures/alf_generate.txt)" ]]
}
