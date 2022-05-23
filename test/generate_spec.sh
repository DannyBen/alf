#!/usr/bin/env bash
source 'approvals.bash'

unset ALF_RC_FILE

describe "alf generate --help"
  approve "alf generate --help"

describe "alf generate (when alf.conf is present)"
  pushd ./fixtures/generate > /dev/nll
  approve "alf generate"
  popd > /dev/null

describe "alf generate (when alf.conf is not present)"
  pushd ./fixtures/empty-dir > /dev/null
  approve "alf generate"
  expect_exit_code 1
  popd > /dev/null

describe "alf generate (when alf.conf does not include subcommands)"
  pushd ./fixtures/no-subcommands > /dev/null
  approve "alf generate"
  popd > /dev/null
