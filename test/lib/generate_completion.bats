#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
}

teardown() {
  teardown_test_environment
}

@test "generate_completions emits completion lines for aliases with subcommands" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path generate_completion/with-subcommands/alfrc)"
  cd "$(fixture_path generate_completion/with-subcommands)" || exit 1
  source_libs find_config generate_completion

  run generate_completions

  [ "$status" -eq 0 ]
  [ "$output" = "$(cat "$(fixture_path generate_completion/with-subcommands/expected.txt)")" ]
}

@test "generate_completions preserves uppercase aliases and subcommands" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path generate_completion/with-uppercase-subcommands/alfrc)"
  cd "$(fixture_path generate_completion/with-uppercase-subcommands)" || exit 1
  source_libs find_config generate_completion

  run generate_completions

  [ "$status" -eq 0 ]
  [ "$output" = "$(cat "$(fixture_path generate_completion/with-uppercase-subcommands/expected.txt)")" ]
}

@test "generate_completions emits only the wrapper when there are no subcommands" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path generate_completion/without-subcommands/alfrc)"
  cd "$(fixture_path generate_completion/without-subcommands)" || exit 1
  source_libs find_config generate_completion

  run generate_completions

  [ "$status" -eq 0 ]
  [ "$output" = "$(cat "$(fixture_path generate_completion/without-subcommands/expected.txt)")" ]
}

@test "generate_completions fails when no config can be found" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path generate_completion/without-config/alfrc)"
  cd "$(fixture_path generate_completion/without-config)" || exit 1
  source_libs find_config generate_completion

  run generate_completions

  [ "$status" -eq 1 ]
  assert_output_contains "ERROR: Cannot find config file"
}
