#!/usr/bin/env bash
source 'approvals.bash'

unset ALF_RC_FILE
export ALF_ALIASES_FILE="aliases.txt"

describe "alf save --help"
  approve "alf save --help"
  expect_exit_code 1

describe "alf save (when alf.conf is present)"
  cd ./fixtures/generate
  rm -f "aliases.txt"
  approve "alf save"
  cd ../../

describe "alf save (when alf.conf is not present)"
  cd ./fixtures/empty-dir
  rm -f "aliases.txt"
  approve "alf save"
  expect_exit_code 1
  if [[ -f aliases.txt ]] ; then
    fail "Expected file aliases.txt not to exist"
  fi
