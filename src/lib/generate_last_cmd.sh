generate_last_cmd() {
  if [[ -n $lastcmd ]]; then
    if [[ $lastcmd =~ ^! ]]; then
      fullcmd="echo this alias requires a subcommand"
    elif [[ $lastcmd =~ \$ ]]; then
      fullcmd=$lastcmd
    else
      fullcmd="$lastcmd \"\$@\""
    fi

    if [[ $cond = "if" ]]; then
      echo "  $fullcmd"
      echo "}"
    else
      echo "  else"
      echo "    $fullcmd"
      echo "  fi"
      echo "}"
      cond="if"
    fi
  fi
}
