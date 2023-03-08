## Returns true if the config has subcommands
has_subcommands() {
  regex="^ +([a-z0-9\-]+):"
  find_config

  while IFS= read -r line || [ -n "$line" ]; do
    if [[ $line =~ $regex ]]; then
      return 0
    fi
  done <"$config_file"

  return 1
}