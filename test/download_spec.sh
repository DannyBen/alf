#!/usr/bin/env bash
source 'approvals.bash'

export ALF_RC_FILE="./alfrc"

describe "alf download --help"
  approve "alf download --help"

describe "alf download"
  pushd ./fixtures/connect > /dev/null
  [[ -d alf-conf ]] || alf connect DannyBen -y
  [[ -d alf-conf ]] || fail "Expected alf-conf directory to exist"
  approve "alf download"
  popd > /dev/null

describe "alf download (without repo connection)"
  pushd ./fixtures/empty-dir > /dev/null
  rm -rf ./alf-conf
  approve "alf download"
  expect_exit_code 1
  popd > /dev/null

