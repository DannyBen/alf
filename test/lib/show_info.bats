#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
}

teardown() {
  teardown_test_environment
}

@test "show_info reports local config details when no git repo is connected" {
  fixture_dir="$TEST_ROOT/with-config"
  mkdir -p "$fixture_dir"
  write_file "$fixture_dir/alf.conf" "g: git"
  export ALF_RC_FILE="$TEST_ROOT/missing-alfrc"
  export ALF_ALIASES_FILE="$TEST_ROOT/aliases.txt"
  cd "$fixture_dir" || exit 1
  source_libs find_config show_info

  run show_info

  [ "$status" -eq 0 ]
  assert_output_contains "path:              $TEST_ROOT/bin/alf"
  assert_output_contains "alfrc path:        $TEST_ROOT/missing-alfrc"
  assert_output_contains "aliases path:      $TEST_ROOT/aliases.txt"
  assert_output_contains "config path:       alf.conf"
  assert_output_contains "alfrc:             does not exist"
  assert_output_contains "aliases:           does not exist"
  assert_output_contains "remote:            unset"
}

@test "show_info reports connected repo details from ALF_RC_FILE" {
  repo_path="$TEST_ROOT/connected-alf"
  mkdir -p "$repo_path"
  write_file "$repo_path/alf.conf" "g: git"
  git -C "$repo_path" init -q
  write_file "$TEST_ROOT/alfrc" "$repo_path"
  export ALF_RC_FILE="$TEST_ROOT/alfrc"
  export ALF_ALIASES_FILE="$TEST_ROOT/aliases.txt"
  touch "$TEST_ROOT/aliases.txt"
  git -C "$repo_path" remote add origin https://example.com/acme/alf-conf.git
  cd "$HOME" || exit 1
  source_libs find_config show_info

  run show_info

  [ "$status" -eq 0 ]
  assert_output_contains "ALF_RC_FILE:       $TEST_ROOT/alfrc"
  assert_output_contains "ALF_ALIASES_FILE:  $TEST_ROOT/aliases.txt"
  assert_output_contains "repo path:         $repo_path"
  assert_output_contains "config path:       $repo_path/alf.conf"
  assert_output_contains "alfrc:             exists with '$repo_path'"
  assert_output_contains "aliases:           exists"
  assert_output_contains "remote:            https://example.com/acme/alf-conf.git"
}
