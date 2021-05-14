#!/usr/bin/env bash
source 'approvals.bash'
cd ./fixtures/empty-dir

describe "alf upgrade --help"
  approve "alf upgrade --help"
  expect_exit_code 1

describe "alf upgrade"
  cp /usr/local/bin/alf /usr/local/bin/alf-before-upgrade
  approve "alf upgrade"
  mv /usr/local/bin/alf-before-upgrade /usr/local/bin/alf
