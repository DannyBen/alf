#!/usr/bin/env bash
# Run this from the main repo directory

set -e
cd ./test
source "approvals.bash"

if [[ $TEST ]]; then
  ./${TEST}_spec.sh
else
  for file in *_spec.sh ; do
    magenta "\nFILE $file"
    ./$file
  done
fi