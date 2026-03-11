#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
}

teardown() {
  teardown_test_environment
}

@test "find_config uses alf.conf in the current directory" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path find_config/with-local-config/alfrc)"
  cd "$(fixture_path find_config/with-local-config)" || exit 1
  source_libs find_config

  find_config

  [ "$repo_path" = "$PWD/alf-conf" ]
  [ "$config_file" = "alf.conf" ]
}

@test "find_config uses the repository referenced by ALF_RC_FILE" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path find_config/with-alfrc/alfrc)"
  cd "$(fixture_path find_config/with-alfrc)" || exit 1
  source_libs find_config

  find_config

  [ "$repo_path" = "../remote-repo" ]
  [ "$config_file" = "../remote-repo/alf.conf" ]
}

@test "find_config fails with a clear message when no config is available" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path find_config/without-config/alfrc)"
  cd "$(fixture_path find_config/without-config)" || exit 1
  source_libs find_config

  run find_config

  [ "$status" -eq 1 ]
  assert_output_contains "ERROR: Cannot find config file"
  assert_output_contains "properly connect to a remote config"
}
