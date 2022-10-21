#!/usr/bin/env bash
source 'approvals.bash'

unset ALF_RC_FILE
export ALF_ALIASES_FILE="aliases.txt"

describe "alf save --help"
  approve "alf save --help"

describe "alf save (when alf.conf is present)"
  pushd ./fixtures/generate > /dev/null
  rm -f "aliases.txt"
  approve "alf save"
  popd > /dev/null

describe "alf save (when alf.conf is not present)"
  pushd ./fixtures/empty-dir > /dev/null
  rm -f "aliases.txt"
  approve "alf save" || return 0
  expect_exit_code 1
  if [[ -f aliases.txt ]] ; then
    fail "Expected file aliases.txt not to exist"
  fi
  popd > /dev/null
