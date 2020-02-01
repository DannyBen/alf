#!/usr/bin/env bash
set -e
source 'approvals.bash'
cd ./fixtures/empty-dir

describe "Run alf --upgrade (answer no)"
  approve "echo n | alf --upgrade"

describe "Run alf --upgrade (answer yes)"
  approve "echo y | alf --upgrade"