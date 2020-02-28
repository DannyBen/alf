repo=${args[repo]}
force=${args[--yes]}

make_full_repo_path
if [[ ! $force ]]; then
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
    echo "Would you like to connect to GitHub via SSH or HTTPS?"
    echo ""
    printf "[S]SH, [H]TTPS or [A]bort (default): "
    read -r answer
    
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
    printf "Continue? [yN] "
    read -r answer
  fi
else
  answer=y
fi

if [[ $answer =~ [Yy] ]]; then
  if [[ -d ./alf-conf ]]; then
    echo "Skipping clone, directory already exists"
  else
    git clone "$repo_url" ./alf-conf
    echo ""
  fi
  echo ""
  echo "$PWD/alf-conf" > "$rc_file"
  echo "Storing location in $rc_file"
else
  echo "Aborting"
  exit
fi

save_config
