#!/usr/bin/env bash
source 'approvals.bash'

export ALF_RC_FILE="./alfrc"

describe "alf download --help"
  approve "alf download --help"
  expect_exit_code 1

describe "alf download"
  cd ./fixtures/connect
  [[ -d alf-conf ]] || alf connect DannyBen -y
  [[ -d alf-conf ]] || fail "Expected alf-conf directory to exist"
  approve "alf download"
  cd ../../

describe "alf download (without repo connection)"
  cd ./fixtures/empty-dir
  rm -rf ./alf-conf
  approve "alf download"
  expect_exit_code 1

