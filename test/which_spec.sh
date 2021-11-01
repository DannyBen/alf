#!/usr/bin/env bash
source 'approvals.bash'

unset ALF_RC_FILE
cd ./fixtures/generate

describe "alf which --help"
  approve "alf which --help"

describe "Run alf which without parameters"
  approve "alf which"
  expect_exit_code 1

describe "Run alf which CODE"
  approve "alf which g"
  expect_exit_code 0

describe "Run alf which CODE SUBCODE"
  approve "alf which g l"
  expect_exit_code 0

describe "Run alf which CODE with invalid code"
  approve "alf which no"
  expect_exit_code 1

describe "Run alf which CODE SUBCODE with invalid code"
  approve "alf which g no"
  expect_exit_code 1

describe "Run alf which CODE SUBCODE with escaped code"
  approve "alf which dc deploy"
  expect_exit_code 0

describe "Run alf which CODE SUBCODE on a separated code"
  approve "alf which dc upd"
  expect_exit_code 0
