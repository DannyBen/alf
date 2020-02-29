#!/usr/bin/env bash
source 'approvals.bash'
cd ./fixtures/empty-dir

describe "alf upgrade --help"
  approve "alf upgrade --help"
  expect_exit_code 1

describe "alf upgrade (answer no)"
  approve "echo n | alf upgrade"

# describe "alf upgrade (answer yes)"
#   curl() { echo "stubbed curl: $*"; }
#   approve "echo y | alf upgrade"
#   unset -f curl
