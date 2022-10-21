#!/usr/bin/env bash
source 'approvals.bash'
cd ./fixtures/empty-dir

describe "alf (usage)"
  approve "alf" || return 0
  expect_exit_code 1

describe "alf --help"
  approve "alf --help"
