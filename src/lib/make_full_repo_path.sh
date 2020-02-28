make_full_repo_path() {
  if [[ $repo =~ ':' ]]; then
    repo_url=$repo
  elif [[ $repo =~ '/' ]]; then
    partial_github_url=1
    repo_url="$repo.git"
  else
    partial_github_url=1
    repo_url="$repo/alf-conf.git"
  fi
}
