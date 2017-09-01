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

@test "alf.make_full_repo_path, with full path, returns valid path" {
  REPO='https://bitbucket/user/reo'
  make_full_repo_path
  [ $REPO_URL = $REPO ]
}
