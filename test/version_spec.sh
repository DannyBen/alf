#!/usr/bin/env bash
source 'approvals.bash'
cd ./fixtures/empty-dir

describe "alf --version"
  approve "alf --version"
