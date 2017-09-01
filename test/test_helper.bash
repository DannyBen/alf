#!/usr/bin/env bash
setup() {
  chmod +x ./alf
  if [[ -f ~/.alfrc ]]; then
    cp ~/.alfrc .alfrc
  fi
}

teardown() {
  if [[ -f ./.alfrc ]]; then
    mv .alfrc ~/.alfrc
  fi
}