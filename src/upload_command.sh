find_config

if [[ ! -f $rc_file ]]; then
  echo "Cannot find $rc_file"
  echo "Please connect alf to a repository first"
  exit 1
fi

pushd "$repo_path" >/dev/null
echo "Pushing $repo_path to repository"
git commit -am "automatic push"
git push
popd >/dev/null