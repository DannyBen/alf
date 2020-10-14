#!/usr/bin/env bash
source 'approvals.bash'

unset ALF_RC_FILE
unset ALF_ALIASES_FILE
rm -f /root/.bash_aliases

describe "alf info --help"
  approve "alf info --help"
  expect_exit_code 1

describe "alf info (when files do not exist)"
  pushd ./fixtures/sample > /dev/null
  approve "alf info"
  popd > /dev/null

describe "alf info (when files exist)"
  pushd ./fixtures/info > /dev/null
  export ALF_RC_FILE="./alfrc"
  export ALF_ALIASES_FILE="./aliases.txt"
  approve "alf info"
  popd > /dev/null

