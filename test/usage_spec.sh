#!/usr/bin/env bash
source 'approvals.bash'
cd ./fixtures/empty-dir

describe "alf (usage)"
  approve "alf"
  expect_exit_code 1

describe "alf --help"
  approve "alf --help"
  expect_exit_code 1
