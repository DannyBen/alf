#!/usr/bin/env bash
source 'approvals.bash'
cd ./fixtures/sample

describe "alf edit --help"
  approve "alf edit --help"

describe "alf edit"
  export EDITOR="echo stubbed editor with: "
  approve "alf edit"

