#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
  source "$ALF_REPO_ROOT/src/initialize.sh"
  declare -g -A args=()
}

teardown() {
  unset_functions connect_repo download_repo generate_config save_config show_info upload_repo show_alias_command
  teardown_test_environment
}

@test "connect command calls connect_repo with parsed args" {
  args[repo]="DannyBen"
  args["--yes"]="1"
  args["--ssh"]=""
  args["--https"]="1"

  connect_repo() {
    printf '%s|%s|%s|%s\n' "$1" "$2" "$3" "$4" >"$TEST_ROOT/call"
  }

  source_command connect

  [ "$(cat "$TEST_ROOT/call")" = "DannyBen|1||1" ]
}

@test "download command calls download_repo" {
  download_repo() {
    echo called >"$TEST_ROOT/call"
  }

  source_command download

  [ "$(cat "$TEST_ROOT/call")" = "called" ]
}

@test "generate command calls generate_config" {
  generate_config() {
    echo called >"$TEST_ROOT/call"
  }

  source_command generate

  [ "$(cat "$TEST_ROOT/call")" = "called" ]
}

@test "info command calls show_info" {
  show_info() {
    echo called >"$TEST_ROOT/call"
  }

  source_command info

  [ "$(cat "$TEST_ROOT/call")" = "called" ]
}

@test "save command calls save_config" {
  save_config() {
    echo called >"$TEST_ROOT/call"
  }

  source_command save

  [ "$(cat "$TEST_ROOT/call")" = "called" ]
}

@test "upload command calls upload_repo" {
  upload_repo() {
    echo called >"$TEST_ROOT/call"
  }

  source_command upload

  [ "$(cat "$TEST_ROOT/call")" = "called" ]
}

@test "which command calls show_alias_command with code and subcode" {
  args[code]="g"
  args[subcode]="l"

  show_alias_command() {
    printf '%s|%s\n' "$1" "$2" >"$TEST_ROOT/call"
  }

  source_command which

  [ "$(cat "$TEST_ROOT/call")" = "g|l" ]
}
