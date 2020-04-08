save_config() {
  find_config

  echo "Saving to $aliases_file"
  generate_config > "$aliases_file"

  echo "To apply the new aliases to the current session, run:"
  echo "$ source ~/.bash_aliases"
}
