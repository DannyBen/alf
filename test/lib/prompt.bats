#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
}

teardown() {
  unset_functions read
  teardown_test_environment
}

@test "prompt_for_github_protocol prints the prompt and returns the typed answer" {
  source_libs prompt

  read() {
    printf -v "$2" '%s' "h"
  }

  run prompt_for_github_protocol

  [ "$status" -eq 0 ]
  assert_output_contains "Would you like to connect to GitHub via SSH or HTTPS?"
  assert_output_contains "[S]SH, [H]TTPS or [A]bort (default): h"
}

@test "prompt_to_continue prints the prompt and returns the typed answer" {
  source_libs prompt

  read() {
    printf -v "$2" '%s' "y"
  }

  run prompt_to_continue

  [ "$status" -eq 0 ]
  assert_output_contains "Continue? [yN] y"
}
