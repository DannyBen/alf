#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
}

teardown() {
  unset_functions find_config git
  teardown_test_environment
}

@test "upload_repo commits and pushes the repo" {
  export ALF_RC_FILE="$TEST_ROOT/alfrc"
  repo_path="$TEST_ROOT/repo"
  mkdir -p "$repo_path"
  : >"$ALF_RC_FILE"
  cd "$TEST_ROOT" || exit 1
  source_libs upload_repo

  find_config() {
    :
  }

  git() {
    printf '%s\n' "$1" >>"$TEST_ROOT/git.log"
  }

  upload_repo

  [ "$(sed -n '1p' "$TEST_ROOT/git.log")" = "commit" ]
  [ "$(sed -n '2p' "$TEST_ROOT/git.log")" = "push" ]
}

@test "upload_repo fails when no rc file exists" {
  export ALF_RC_FILE="$TEST_ROOT/missing-alfrc"
  repo_path="$TEST_ROOT/repo"
  source_libs upload_repo

  find_config() {
    :
  }

  run upload_repo

  [ "$status" -eq 1 ]
  assert_output_contains "Cannot find $TEST_ROOT/missing-alfrc"
  assert_output_contains "Please connect alf to a repository first"
}
