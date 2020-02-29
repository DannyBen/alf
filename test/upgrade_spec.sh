#!/usr/bin/env bash
set -e
source 'approvals.bash'
cd ./fixtures/empty-dir

describe "alf upgrade --help"
  set +e  # expect non zero exit code 
  approve "alf upgrade --help"
  expect_exit_code 1
  set -e  

describe "alf upgrade (answer no)"
  approve "echo n | alf upgrade"

# describe "alf upgrade (answer yes)"
#   curl() { echo "stubbed curl: $*"; }
#   approve "echo y | alf upgrade"
#   unset -f curl
