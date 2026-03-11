#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
}

teardown() {
  teardown_test_environment
}

@test "generate_config emits functions for flat aliases without completions" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path generate_config/flat/alfrc)"
  cd "$(fixture_path generate_config/flat)" || exit 1
  source_libs find_config generate_last_cmd has_subcommands generate_completion generate_config

  run generate_config

  [ "$status" -eq 0 ]
  [ "$output" = "$(cat "$(fixture_path generate_config/flat/expected.sh)")" ]
}

@test "generate_config emits nested alias functions and completions" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path generate_config/with-subcommands/alfrc)"
  cd "$(fixture_path generate_config/with-subcommands)" || exit 1
  source_libs find_config generate_last_cmd has_subcommands generate_completion generate_config

  run generate_config

  [ "$status" -eq 0 ]
  [ "$output" = "$(cat "$(fixture_path generate_config/with-subcommands/expected.sh)")" ]
}

@test "generate_config fails when no config can be found" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path generate_config/without-config/alfrc)"
  cd "$(fixture_path generate_config/without-config)" || exit 1
  source_libs find_config generate_last_cmd has_subcommands generate_completion generate_config

  run generate_config

  [ "$status" -eq 1 ]
  assert_output_contains "ERROR: Cannot find config file"
}
