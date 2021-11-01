#!/usr/bin/env bash
source 'approvals.bash'

cd ./fixtures/connect
export ALF_RC_FILE="./alfrc"
rm -rf alf-conf

describe "alf connect --help"
  approve "alf connect --help"

describe "alf connect (no repo)"
  approve "alf connect"
  expect_exit_code 1

describe "alf connect <github username>"
  approve "echo a | alf connect JohnSnow"

describe "alf connect <github username>/<github repo>"
  approve "echo a | alf connect JohnSnow/winterfell"

describe "alf connect <git url>"
  approve "echo a | alf connect https://bitbucket.com/JohnSnow/winterfell"

describe "alf connect <github username> --yes (disallowed)"
  rm -f ./alfrc
  approve "alf connect DannyBen --yes"

describe "alf connect <git url> --yes (non interactive)"
  rm -f ./alfrc
  approve "alf connect https://github.com/DannyBen/alf-conf.git --yes"
  [[ -d alf-conf ]] || fail "Expected to have alf-conf directory"
  [[ -f alf-conf/alf.conf ]] || fail "Expected to have alf-conf/alf.conf file"
  approve "cat alfrc"

describe "alf connect <github username> --https (non interactive)"
  rm -f ./alfrc
  approve "alf connect DannyBen --https"
  [[ -d alf-conf ]] || fail "Expected to have alf-conf directory"
  [[ -f alf-conf/alf.conf ]] || fail "Expected to have alf-conf/alf.conf file"
  approve "cat alfrc"

