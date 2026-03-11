#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
}

teardown() {
  unset_functions find_config git save_config
  teardown_test_environment
}

@test "download_repo pulls the repo and saves aliases" {
  export ALF_RC_FILE="$TEST_ROOT/alfrc"
  repo_path="$TEST_ROOT/repo"
  mkdir -p "$repo_path"
  : >"$ALF_RC_FILE"
  cd "$TEST_ROOT" || exit 1
  source_libs download_repo

  find_config() {
    :
  }

  git() {
    [ "$1" = "pull" ] || return 1
    echo pull >>"$TEST_ROOT/git.log"
  }

  save_config() {
    echo save >>"$TEST_ROOT/save.log"
  }

  download_repo

  [ "$(cat "$TEST_ROOT/git.log")" = "pull" ]
  [ "$(cat "$TEST_ROOT/save.log")" = "save" ]
}

@test "download_repo fails when no rc file exists" {
  export ALF_RC_FILE="$TEST_ROOT/missing-alfrc"
  repo_path="$TEST_ROOT/repo"
  source_libs download_repo

  find_config() {
    :
  }

  run download_repo

  [ "$status" -eq 1 ]
  assert_output_contains "Cannot find $TEST_ROOT/missing-alfrc"
  assert_output_contains "Please connect alf to a repository first"
}
