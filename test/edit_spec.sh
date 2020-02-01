#!/usr/bin/env bash
# set -e
source 'approvals.bash'
cd ./fixtures/sample

describe "alf edit"
  export EDITOR="echo stubbed editor with: "
  approve "alf edit"

