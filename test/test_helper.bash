setup_test_environment() {
  export ALF_REPO_ROOT
  ALF_REPO_ROOT="$(cd "$BATS_TEST_DIRNAME/../.." && pwd)"

  export TEST_ROOT
  TEST_ROOT="$(mktemp -d)"

  export HOME="$TEST_ROOT/home"
  mkdir -p "$HOME" "$TEST_ROOT/bin"

  export PATH="$TEST_ROOT/bin:$PATH"

  cat >"$TEST_ROOT/bin/alf" <<'EOF'
#!/usr/bin/env bash
echo stub-alf
EOF
  chmod +x "$TEST_ROOT/bin/alf"
}

teardown_test_environment() {
  rm -rf "$TEST_ROOT"
}

assert_output_contains() {
  local expected="$1"
  [[ "$output" == *"$expected"* ]]
}

fixture_path() {
  printf '%s/test/fixtures/%s\n' "$ALF_REPO_ROOT" "$1"
}

write_file() {
  local path="$1"
  shift
  printf '%s\n' "$@" >"$path"
}

unset_functions() {
  local fn

  for fn in "$@"; do
    unset -f "$fn" 2>/dev/null || true
  done
}

source_libs() {
  local lib

  source "$ALF_REPO_ROOT/src/initialize.sh"

  for lib in "$@"; do
    source "$ALF_REPO_ROOT/src/lib/${lib}.sh"
  done
}

source_command() {
  source "$ALF_REPO_ROOT/src/commands/${1}.sh"
}
