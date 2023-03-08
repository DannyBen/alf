save_config() {
  find_config

  tilde='~'
  friendly_aliases_file="${aliases_file/#$HOME/$tilde}"

  echo "Saving to $aliases_file"
  generate_config >"$aliases_file"

  echo "To apply the new aliases to the current session, run:"
  echo "$ source $friendly_aliases_file"
}
