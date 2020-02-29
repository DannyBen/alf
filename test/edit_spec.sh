#!/usr/bin/env bash
# set -e
source 'approvals.bash'
cd ./fixtures/sample

describe "alf edit --help"
  set +e  # expect non zero exit code 
  approve "alf edit --help"
  expect_exit_code 1
  set -e  

describe "alf edit"
  export EDITOR="echo stubbed editor with: "
  approve "alf edit"

