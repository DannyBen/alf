download_repo() {
  find_config

  if [[ ! -f $rc_file ]]; then
    echo "Cannot find $rc_file"
    echo "Please connect alf to a repository first"
    return 1
  fi

  pushd "$repo_path" >/dev/null
  echo "Pulling from repository to $repo_path"
  git pull
  popd >/dev/null

  save_config
}
