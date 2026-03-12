#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
}

teardown() {
  teardown_test_environment
}

@test "has_subcommands returns success when nested aliases exist" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path has_subcommands/with-subcommands/alfrc)"
  cd "$(fixture_path has_subcommands/with-subcommands)" || exit 1
  source_libs find_config has_subcommands

  has_subcommands

  [ "$?" -eq 0 ]
}

@test "has_subcommands returns success when nested aliases use uppercase codes" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path has_subcommands/with-uppercase-subcommands/alfrc)"
  cd "$(fixture_path has_subcommands/with-uppercase-subcommands)" || exit 1
  source_libs find_config has_subcommands

  has_subcommands

  [ "$?" -eq 0 ]
}

@test "has_subcommands returns failure when aliases are flat" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path has_subcommands/without-subcommands/alfrc)"
  cd "$(fixture_path has_subcommands/without-subcommands)" || exit 1
  source_libs find_config has_subcommands

  run has_subcommands

  [ "$status" -eq 1 ]
  [ -z "$output" ]
}

@test "has_subcommands fails with the config error when no config is available" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path has_subcommands/without-config/alfrc)"
  cd "$(fixture_path has_subcommands/without-config)" || exit 1
  source_libs find_config has_subcommands

  run has_subcommands

  [ "$status" -eq 1 ]
  assert_output_contains "ERROR: Cannot find config file"
}
