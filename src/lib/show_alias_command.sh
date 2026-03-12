show_alias_command() {
  local code="$1"
  local subcode="${2:-}"
  local regex_exact_code regex_exact_subcode cmd1 cmd2

  find_config || return 1
  regex_exact_code="^($code): *(.+)$"
  regex_exact_subcode="^( +)($subcode): *(.+)$"
  cmd1=""

  while IFS= read -r line || [ -n "$line" ]; do
    if [[ $line =~ $regex_exact_code ]]; then
      cmd1="${BASH_REMATCH[2]}"
      if [[ -z $subcode ]]; then
        echo "$cmd1"
        return 0
      fi
    elif [[ -n $cmd1 ]]; then
      if [[ $line =~ $regex_exact_subcode ]]; then
        cmd2="${BASH_REMATCH[3]}"
        if [[ $cmd2 =~ ^! ]]; then
          echo "${cmd2:1}"
        else
          echo "$cmd1 $cmd2"
        fi
        return 0
      fi
    fi
  done <"$config_file"

  echo "Error: No such alias: $code $subcode"
  return 1
}
