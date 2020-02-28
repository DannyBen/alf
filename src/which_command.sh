code=${args[code]}
subcode=${args[subcode]}

find_config
regex_exact_code="^($code): *(.+)$"
regex_exact_subcode="^( +)($subcode): *(.+)$"
cmd1=""

while IFS= read -r line || [ -n "$line" ]; do
  if [[ $line =~ $regex_exact_code ]]; then
    cmd1="${BASH_REMATCH[2]}"
    if [[ -z $subcode ]]; then
      echo "$cmd1"
      exit 0
    fi
  elif [[ -n $cmd1 ]]; then
    if [[ $line =~ $regex_exact_subcode ]]; then
      cmd2="${BASH_REMATCH[3]}"
      if [[ $cmd2 =~ ^! ]]; then
        echo "${cmd2:1}"
      else
        echo "$cmd1 $cmd2"
      fi
      exit 0
    fi
  fi
done < "$config_file"

echo "Error: No such alias: $code $subcode"
exit 1
