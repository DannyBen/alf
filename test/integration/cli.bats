#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
}

teardown() {
  teardown_test_environment
}

@test "alf --help renders properly" {
  run "$ALF_REPO_ROOT/alf" --help

  [ "$status" -eq 0 ]
  assert_output_contains "Commands:"
  assert_output_contains "connect"
  assert_output_contains "which"
  [[ "$output" != *"upgrade"* ]]
}

@test "alf which --help renders properly" {
  run "$ALF_REPO_ROOT/alf" which --help

  [ "$status" -eq 0 ]
  assert_output_contains "alf which - Show the alias command."
  assert_output_contains "Usage:"
  assert_output_contains "alf which CODE [SUBCODE]"
}
