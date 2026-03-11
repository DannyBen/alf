#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
}

teardown() {
  teardown_test_environment
}

@test "info reports local config details when no git repo is connected" {
  fixture_dir="$TEST_ROOT/with-config"
  mkdir -p "$fixture_dir"
  write_file "$fixture_dir/alf.conf" "g: git"
  export ALF_RC_FILE="$TEST_ROOT/missing-alfrc"
  export ALF_ALIASES_FILE="$TEST_ROOT/aliases.txt"

  run env ALF_RC_FILE="$ALF_RC_FILE" ALF_ALIASES_FILE="$ALF_ALIASES_FILE" ALF_REPO_ROOT="$ALF_REPO_ROOT" PATH="$PATH" bash -lc "source '$ALF_REPO_ROOT/src/initialize.sh'; source '$ALF_REPO_ROOT/src/lib/find_config.sh'; cd '$fixture_dir' || exit 1; source '$ALF_REPO_ROOT/src/info_command.sh'"

  [ "$status" -eq 0 ]
  assert_output_contains "path:              $TEST_ROOT/bin/alf"
  assert_output_contains "alfrc path:        $TEST_ROOT/missing-alfrc"
  assert_output_contains "aliases path:      $TEST_ROOT/aliases.txt"
  assert_output_contains "config path:       alf.conf"
  assert_output_contains "alfrc:             does not exist"
  assert_output_contains "aliases:           does not exist"
  assert_output_contains "remote:            unset"
}

@test "info reports connected repo details from ALF_RC_FILE" {
  repo_path="$TEST_ROOT/connected-alf"
  mkdir -p "$repo_path"
  write_file "$repo_path/alf.conf" "g: git"
  git -C "$repo_path" init -q
  write_file "$TEST_ROOT/alfrc" "$repo_path"
  export ALF_RC_FILE="$TEST_ROOT/alfrc"
  export ALF_ALIASES_FILE="$TEST_ROOT/aliases.txt"
  touch "$TEST_ROOT/aliases.txt"
  git -C "$repo_path" remote add origin https://example.com/acme/alf-conf.git

  run env ALF_RC_FILE="$ALF_RC_FILE" ALF_ALIASES_FILE="$ALF_ALIASES_FILE" ALF_REPO_ROOT="$ALF_REPO_ROOT" PATH="$PATH" HOME="$HOME" bash -lc "source '$ALF_REPO_ROOT/src/initialize.sh'; source '$ALF_REPO_ROOT/src/lib/find_config.sh'; cd '$HOME' || exit 1; source '$ALF_REPO_ROOT/src/info_command.sh'"

  [ "$status" -eq 0 ]
  assert_output_contains "ALF_RC_FILE:       $TEST_ROOT/alfrc"
  assert_output_contains "ALF_ALIASES_FILE:  $TEST_ROOT/aliases.txt"
  assert_output_contains "repo path:         $repo_path"
  assert_output_contains "config path:       $repo_path/alf.conf"
  assert_output_contains "alfrc:             exists with '$repo_path'"
  assert_output_contains "aliases:           exists"
  assert_output_contains "remote:            https://example.com/acme/alf-conf.git"
}
