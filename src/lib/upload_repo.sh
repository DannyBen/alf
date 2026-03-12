upload_repo() {
  find_config

  if [[ ! -f $rc_file ]]; then
    echo "Cannot find $rc_file"
    echo "Please connect alf to a repository first"
    return 1
  fi

  pushd "$repo_path" >/dev/null
  echo "Pushing $repo_path to repository"
  git add -A

  if git diff --cached --quiet; then
    echo "No local changes to commit"
  else
    git commit -m "automatic push"
  fi

  git push
  popd >/dev/null
}
