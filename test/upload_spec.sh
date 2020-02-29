#!/usr/bin/env bash
set +e # all tests here exit with 1
source 'approvals.bash'

export ALF_RC_FILE="./alfrc"

describe "alf upload --help"
  approve "alf upload --help"
  expect_exit_code 1

describe "alf upload"
  cd ./fixtures/connect
  [[ -d alf-conf ]] || alf connect DannyBen -y
  [[ -d alf-conf ]] || fail "Expected alf-conf directory to exist"
  approve "alf upload"
  cd ../../

describe "alf upload (without repo connection)"
  cd ./fixtures/empty-dir
  rm -rf ./alf-conf
  approve "alf upload"
