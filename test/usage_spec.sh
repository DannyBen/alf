#!/usr/bin/env bash
set +e # all tests here exit with 1
source 'approvals.bash'
cd ./fixtures/empty-dir

describe "alf (usage)"
  approve "alf"
  expect_exit_code 1

describe "alf --help"
  approve "alf --help"
  expect_exit_code 1
