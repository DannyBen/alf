#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
}

teardown() {
  unset_functions git save_config prompt_for_github_protocol prompt_to_continue
  teardown_test_environment
}

@test "connect_repo rejects --yes for shorthand GitHub repos" {
  export ALF_RC_FILE="$TEST_ROOT/alfrc"
  source_libs prompt connect_repo

  run connect_repo "DannyBen" "1" "" ""

  [ "$status" -eq 1 ]
  assert_output_contains "Error: Cannot determine the full URL for the repository"
}

@test "connect_repo clones a full URL non-interactively and saves config" {
  export ALF_RC_FILE="$TEST_ROOT/alfrc"
  mkdir -p "$TEST_ROOT/work"
  cd "$TEST_ROOT/work" || exit 1
  source_libs prompt connect_repo

  git() {
    [ "$1" = "clone" ] || return 1
    printf 'git %s %s %s\n' "$1" "$2" "$3" >>"$TEST_ROOT/git.log"
    mkdir -p "$3"
  }

  save_config() {
    echo "save_config called" >>"$TEST_ROOT/save.log"
  }

  run connect_repo "https://example.com/acme/alf-conf.git" "1" "" ""

  [ "$status" -eq 0 ]
  assert_output_contains "Connecting to https://example.com/acme/alf-conf.git"
  assert_output_contains "Storing location in $TEST_ROOT/alfrc"
  [ "$(cat "$TEST_ROOT/alfrc")" = "$TEST_ROOT/work/alf-conf" ]
  grep -Fq 'git clone https://example.com/acme/alf-conf.git ./alf-conf' "$TEST_ROOT/git.log"
  grep -Fq 'save_config called' "$TEST_ROOT/save.log"
}

@test "connect_repo chooses https interactively for shorthand GitHub repos" {
  export ALF_RC_FILE="$TEST_ROOT/alfrc"
  mkdir -p "$TEST_ROOT/work"
  cd "$TEST_ROOT/work" || exit 1
  source_libs prompt connect_repo

  prompt_for_github_protocol() {
    echo "h"
  }

  git() {
    [ "$1" = "clone" ] || return 1
    printf '%s\n' "$2" >"$TEST_ROOT/cloned-url"
    mkdir -p "$3"
  }

  save_config() {
    :
  }

  run connect_repo "DannyBen" "" "" ""

  [ "$status" -eq 0 ]
  assert_output_contains "Using https://github.com/DannyBen/alf-conf.git"
  [ "$(cat "$TEST_ROOT/cloned-url")" = "https://github.com/DannyBen/alf-conf.git" ]
}

@test "connect_repo aborts when the interactive GitHub prompt declines the operation" {
  export ALF_RC_FILE="$TEST_ROOT/alfrc"
  source_libs prompt connect_repo

  prompt_for_github_protocol() {
    echo "a"
  }

  git() {
    echo "git should not be called"
    return 1
  }

  save_config() {
    echo "save_config should not be called"
    return 1
  }

  run connect_repo "DannyBen" "" "" ""

  [ "$status" -eq 0 ]
  assert_output_contains "Aborting"
  [ ! -e "$TEST_ROOT/alfrc" ]
}

@test "connect_repo skips clone when alf-conf already exists" {
  export ALF_RC_FILE="$TEST_ROOT/alfrc"
  mkdir -p "$TEST_ROOT/work/alf-conf"
  cd "$TEST_ROOT/work" || exit 1
  source_libs prompt connect_repo

  git() {
    echo "git should not be called"
    return 1
  }

  save_config() {
    echo called >"$TEST_ROOT/save.log"
  }

  run connect_repo "https://example.com/acme/alf-conf.git" "1" "" ""

  [ "$status" -eq 0 ]
  assert_output_contains "Skipping clone, directory already exists"
  [ "$(cat "$TEST_ROOT/alfrc")" = "$TEST_ROOT/work/alf-conf" ]
  [ "$(cat "$TEST_ROOT/save.log")" = "called" ]
}
