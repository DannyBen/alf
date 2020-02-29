#!/usr/bin/env bash
set -e
source 'approvals.bash'

unset ALF_RC_FILE
export ALF_ALIASES_FILE="aliases.txt"

describe "alf save --help"
  set +e  # expect non zero exit code 
  approve "alf save --help"
  expect_exit_code 1
  set -e  

describe "alf save (when alf.conf is present)"
  cd ./fixtures/generate
  rm -f "aliases.txt"
  approve "alf save"
  cd ../../

describe "alf save (when alf.conf is not present)"
  cd ./fixtures/empty-dir
  rm -f "aliases.txt"
  set +e   # allow non zero exit
  approve "alf save"
  expect_exit_code 1
  [[ -f aliases.txt ]] && fail "Expected file aliases.txt not to exist"
  set -e
