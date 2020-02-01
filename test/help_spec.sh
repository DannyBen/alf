#!/usr/bin/env bash
set -e
source 'approvals.bash'
cd ./fixtures/empty-dir

describe "alf (usage)"
  approve "alf"

describe "alf --help"
  approve "alf --help"
