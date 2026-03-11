connect_repo() {
  local repo="$1"
  local force="$2"
  local force_ssh="$3"
  local force_https="$4"
  local repo_url partial_github_url answer

  if [[ $repo =~ ':' ]]; then
    repo_url=$repo
  elif [[ $repo =~ '/' ]]; then
    partial_github_url=1
    repo_url="$repo.git"
  else
    partial_github_url=1
    repo_url="$repo/alf-conf.git"
  fi

  if [[ $force_ssh ]]; then
    answer=y
    [[ $partial_github_url ]] && repo_url="git@github.com:$repo_url"
    echo "Connecting to $repo_url"

  elif [[ $force_https ]]; then
    answer=y
    [[ $partial_github_url ]] && repo_url="https://github.com/$repo_url"
    echo "Connecting to $repo_url"

  elif [[ $force ]]; then
    if [[ $partial_github_url ]]; then
      echo "Error: Cannot determine the full URL for the repository"
      echo "To connect to GitHub use --ssh or --https"
      echo "To connect to another repository, provide the full URL"
      return 1
    fi
    answer=y
    echo "Connecting to $repo_url"

  else
    echo "This operation will:"
    echo ""
    if [[ ! -d ./alf-conf ]]; then
      echo "  clone  $repo_url"
      echo "     to  ./alf-conf"
      echo ""
    fi
    echo "  write  $PWD/alf-conf"
    echo "     to  $rc_file"
    echo ""

    if [[ -n "$partial_github_url" ]]; then
      answer="$(prompt_for_github_protocol)"

      if [[ $answer =~ [Ss] ]]; then
        repo_url="git@github.com:$repo_url"
        answer=y
        echo ""
        echo "Using $repo_url"
      elif [[ $answer =~ [Hh] ]]; then
        repo_url="https://github.com/$repo_url"
        answer=y
        echo ""
        echo "Using $repo_url"
      fi
    else
      answer="$(prompt_to_continue)"
    fi
  fi

  if [[ $answer =~ [Yy] ]]; then
    if [[ -d ./alf-conf ]]; then
      echo "Skipping clone, directory already exists"
    else
      git clone "$repo_url" ./alf-conf
    fi
    echo "$PWD/alf-conf" >"$rc_file"
    echo "Storing location in $rc_file"
  else
    echo "Aborting"
    return 0
  fi

  save_config
}
