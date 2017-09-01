#!/usr/bin/env bats
export ALF_SUPRESS_RUN=true
source ./alf

@test "alf.make_full_repo_path, withuser, returns valid path" {
  REPO='Bob'
  make_full_repo_path
  [ $REPO_URL = https://github.com/Bob/alf-conf.git ]
}

@test "alf.make_full_repo_path, with user/repo, returns valid path" {
  REPO='Bob/myrepo'
  make_full_repo_path
  [ $REPO_URL = https://github.com/Bob/myrepo.git ]
}

@test "alf.find_config, without .alfrc, returns default values" {
  REPO='https://bitbucket/user/reo'
  find_config
  [ $CONFIG_FILE = 'alf.conf' ]
  [ $REPO_PATH = "$PWD/alf-conf" ]
}
