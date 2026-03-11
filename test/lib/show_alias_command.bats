#!/usr/bin/env bats

load ../test_helper.bash

setup() {
  setup_test_environment
}

teardown() {
  teardown_test_environment
}

@test "show_alias_command prints the base command for a simple alias" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path show_alias_command/with-config/alfrc)"
  cd "$(fixture_path show_alias_command/with-config)" || exit 1
  source_libs find_config show_alias_command

  run show_alias_command g

  [ "$status" -eq 0 ]
  [ "$output" = "git" ]
}

@test "show_alias_command prints the full nested command" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path show_alias_command/with-config/alfrc)"
  cd "$(fixture_path show_alias_command/with-config)" || exit 1
  source_libs find_config show_alias_command

  run show_alias_command g l

  [ "$status" -eq 0 ]
  [ "$output" = "git log --all --graph --date=relative" ]
}

@test "show_alias_command respects escaped nested commands" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path show_alias_command/with-config/alfrc)"
  cd "$(fixture_path show_alias_command/with-config)" || exit 1
  source_libs find_config show_alias_command

  run show_alias_command dc deploy

  [ "$status" -eq 0 ]
  [ "$output" = "docker stack deploy -c docker-compose.yml" ]
}

@test "show_alias_command returns an error for an unknown alias" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path show_alias_command/with-config/alfrc)"
  cd "$(fixture_path show_alias_command/with-config)" || exit 1
  source_libs find_config show_alias_command

  run show_alias_command no

  [ "$status" -eq 1 ]
  [ "$output" = "Error: No such alias: no " ]
}

@test "show_alias_command returns an error for an unknown sub-alias" {
  export ALF_RC_FILE
  ALF_RC_FILE="$(fixture_path show_alias_command/with-config/alfrc)"
  cd "$(fixture_path show_alias_command/with-config)" || exit 1
  source_libs find_config show_alias_command

  run show_alias_command g no

  [ "$status" -eq 1 ]
  [ "$output" = "Error: No such alias: g no" ]
}
