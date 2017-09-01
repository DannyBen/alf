#!/usr/bin/env bats
ALF_SUPRESS_RUN=1 source ./alf

@test "alf.make_full_repo_path, withuser, returns valid path" {
  REPO='Bob'
  make_full_repo_path
  [[ $REPO_URL = https://github.com/Bob/alf-conf.git ]]
}

@test "alf.make_full_repo_path, with user/repo, returns valid path" {
  REPO='Bob/myrepo'
  make_full_repo_path
  [[ $REPO_URL = https://github.com/Bob/myrepo.git ]]
}

@test "alf.find_config, without .alfrc, returns default values" {
  if [[ -f ~/.alfrc ]]; then rm ~/.alfrc; fi
  find_config
  [[ $REPO_PATH = "$PWD/alf-conf" ]]
  [[ $CONFIG_FILE = "alf.conf" ]]
}

@test "alf.find_config, with .alfrc, returns default values" {
  echo /path/to/repo > ~/.alfrc
  [[ $(<~/.alfrc) =~ path/to/repo ]]
  find_config
  [[ $REPO_PATH = "/path/to/repo" ]]
  [[ $CONFIG_FILE = "$REPO_PATH/alf.conf" ]]
}
