generate_completions() {
  ali1_regex="^([a-z0-9\-]+):"
  ali2_regex="^ +([a-z0-9\-]+):"
  find_config

  # shellcheck disable=SC2016
  echo '
# Enable bash completions in zsh
if [[ -n ${ZSH_VERSION-} ]]; then
  autoload -U +X bashcompinit && bashcompinit
  if ! command -v compinit > /dev/null; then
    autoload -U +X compinit && if [[ ${ZSH_DISABLE_COMPFIX-} = true ]]; then
      compinit -u
    else
      compinit
    fi
  fi
fi
'
  echo '# Completions'

  while IFS= read -r line || [ -n "$line" ]; do
    if [[ $line =~ $ali1_regex ]]; then
      ali="${BASH_REMATCH[1]}"
      [[ -n $comp ]] && echo "complete -W $comp"
      comps=""
      comp=""
    elif [[ $line =~ $ali2_regex ]]; then
      if [[ -n $comps ]] ; then
        comps="$comps ${BASH_REMATCH[1]}"
      else
        comps="${BASH_REMATCH[1]}"
      fi
      comp="\"$comps\" $ali"
    fi
  done < "$config_file"
  
  if [[ -n $comp ]] && [[ -n $comps ]] ; then
    echo "complete -W $comp"
  fi
}

