#!/usr/bin/env bash
set -e
source 'approvals.bash'

unset ALF_RC_FILE

describe "alf generate --help"
  set +e  # expect non zero exit code 
  approve "alf generate --help"
  expect_exit_code 1
  set -e  

describe "alf generate (when alf.conf is present)"
  cd ./fixtures/generate
  approve "alf generate"
  cd ../../

describe "alf generate (when alf.conf is not present)"
  cd "fixtures/empty-dir"
  set +e   # allow non zero exit
  approve "alf generate"
  expect_exit_code 1
  set -e
