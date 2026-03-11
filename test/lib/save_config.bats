#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
}

teardown() {
  teardown_test_environment
}

@test "save_config writes generated aliases and prints a home-relative source path" {
  export ALF_ALIASES_FILE
  ALF_ALIASES_FILE="$HOME/aliases.sh"
  source_libs save_config

  find_config() {
    config_file="alf.conf"
  }

  generate_config() {
    printf '%s\n' '# generated aliases'
    printf '%s\n' 'g() { git "$@"; }'
  }

  run save_config

  [ "$status" -eq 0 ]
  [ -f "$ALF_ALIASES_FILE" ]
  assert_output_contains "Saving to $ALF_ALIASES_FILE"
  assert_output_contains "source ~/aliases.sh"
  grep -Fq '# generated aliases' "$ALF_ALIASES_FILE"
  grep -Fq 'g() { git "$@"; }' "$ALF_ALIASES_FILE"
}

@test "save_config keeps the full path when aliases_file is outside HOME" {
  export ALF_ALIASES_FILE
  ALF_ALIASES_FILE="$TEST_ROOT/aliases.sh"
  source_libs save_config

  find_config() {
    config_file="alf.conf"
  }

  generate_config() {
    printf '%s\n' 'echo outside-home'
  }

  run save_config

  [ "$status" -eq 0 ]
  assert_output_contains "Saving to $TEST_ROOT/aliases.sh"
  assert_output_contains "source $TEST_ROOT/aliases.sh"
  grep -Fq 'echo outside-home' "$ALF_ALIASES_FILE"
}

@test "save_config stops when find_config fails" {
  export ALF_ALIASES_FILE
  ALF_ALIASES_FILE="$HOME/aliases.sh"
  source_libs save_config

  find_config() {
    echo "ERROR: Cannot find config file"
    exit 1
  }

  generate_config() {
    echo "should not run"
  }

  run save_config

  [ "$status" -eq 1 ]
  [ ! -e "$ALF_ALIASES_FILE" ]
  assert_output_contains "ERROR: Cannot find config file"
}
