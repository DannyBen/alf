#!/usr/bin/env bash
source 'approvals.bash'

unset ALF_RC_FILE

describe "alf generate --help"
  approve "alf generate --help"
  expect_exit_code 1

describe "alf generate (when alf.conf is present)"
  cd ./fixtures/generate
  approve "alf generate"
  cd ../../

describe "alf generate (when alf.conf is not present)"
  cd "fixtures/empty-dir"
  approve "alf generate"
  expect_exit_code 1
