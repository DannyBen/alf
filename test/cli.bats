#!/usr/bin/env bats
load test_helper
export ALF_SUPRESS_RUN=0

@test "cli without args, shows usage" {
  run ./alf
  [[ "$status" = 0 ]]
  [[ ${lines[0]} = "Usage:" ]]
}

@test "cli --help, shows detailed usage" {
  run ./alf --help
  [[ "$status" = 0 ]]
  [[ "${lines[0]}" =~ 'Your Little Bash Alias Friend' ]]
}
