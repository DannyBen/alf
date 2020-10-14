#!/usr/bin/env bash
source 'approvals.bash'

export ALF_RC_FILE="./alfrc"

describe "alf upload --help"
  approve "alf upload --help"
  expect_exit_code 1

describe "alf upload"
  pushd ./fixtures/connect > /dev/null
  [[ -d alf-conf ]] || alf connect DannyBen -y
  [[ -d alf-conf ]] || fail "Expected alf-conf directory to exist"
  approve "alf upload"
  popd > /dev/null

describe "alf upload (without repo connection)"
  pushd ./fixtures/empty-dir > /dev/null
  rm -rf ./alf-conf
  approve "alf upload"
  popd > /dev/null
