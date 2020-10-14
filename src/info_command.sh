inforow() {
  printf "%-30s %s\n" "$1:" "$(green "$2")"
}

find_config

inforow "executable / path" "$(which alf)"
inforow "env / ALF_RC_FILE" "${ALF_RC_FILE:-unset}"
inforow "env / ALF_ALIASES_FILE" "${ALF_ALIASES_FILE:-unset}"
inforow "repo / path" "$repo_path"
inforow "config / path" "$config_file"

