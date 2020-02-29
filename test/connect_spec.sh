#!/usr/bin/env bash
set -e
source 'approvals.bash'

cd ./fixtures/connect
export ALF_RC_FILE="./alfrc"
rm -rf alf-conf

describe "alf connect --help"
  set +e  # expect non zero exit code 
  approve "alf connect --help"
  expect_exit_code 1
  set -e  

describe "alf connect (no repo)"
  set +e  # expect failure
  approve "alf connect"
  expect_exit_code 1
  set -e

describe "alf connect <github username>"
  approve "echo a | alf connect JohnSnow"

describe "alf connect <github username>/<github repo>"
  approve "echo a | alf connect JohnSnow/winterfell"

describe "alf connect <git url>"
  approve "echo a | alf connect https://bitbucket.com/JohnSnow/winterfell"

describe "alf connect <anything> -y (non interactive)"
  rm -f ./alfrc
  approve "alf connect https://github.com/DannyBen/alf-conf.git -y"
  [[ -d alf-conf ]] || fail "Expected to have alf-conf directory"
  [[ -f alf-conf/alf.conf ]] || fail "Expected to have alf-conf/alf.conf file"
  approve "cat alfrc"
