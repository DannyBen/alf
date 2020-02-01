#!/usr/bin/env bash
set -e
source 'approvals.bash'
cd ./fixtures/empty-dir

describe "alf --version"
  approve "alf --version"
