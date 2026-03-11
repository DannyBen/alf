prompt_for_github_protocol() {
  local answer

  echo "Would you like to connect to GitHub via SSH or HTTPS?"
  echo ""
  printf "[S]SH, [H]TTPS or [A]bort (default): "
  read -r answer
  printf '%s\n' "$answer"
}

prompt_to_continue() {
  local answer

  printf "Continue? [yN] "
  read -r answer
  printf '%s\n' "$answer"
}
