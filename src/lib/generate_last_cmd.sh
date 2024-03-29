generate_last_cmd() {
  if [[ -n $lastcmd ]]; then
    if [[ $lastcmd =~ ^! ]]; then
      fullcmd="echo this alias requires a subcommand"
    elif [[ $lastcmd =~ \$ ]]; then
      fullcmd=$lastcmd
    else
      fullcmd="$lastcmd \"\$@\""
    fi

    if [[ $state = "simple" ]]; then
      echo "  $fullcmd"
      echo "}"
    else
      echo "    *)"
      echo "      $fullcmd"
      echo "      ;;"
      echo "  esac"
      echo "}"
      state="simple"
      case_open="false"
    fi
  fi
}
