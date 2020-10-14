find_config

if [[ -d "$repo_path/.git" ]]; then
  pushd "$repo_path" > /dev/null
  remote="$(git config --get remote.origin.url)"
  popd > /dev/null
else
  remote="unset"
fi

if [[ -f "$rc_file" ]]; then
  alfrc_content="$(<"$rc_file")"
else
  alfrc_content="does not exist"
fi

if [[ -f "$aliases_file" ]]; then
  bash_aliases_status="exists"
else
  bash_aliases_status="does not exist"
fi

echo "Executable:"
echo "  path:              $(which alf)"
echo 
echo "Environment:"
echo "  ALF_RC_FILE:       ${ALF_RC_FILE:-unset}"
echo "  ALF_ALIASES_FILE:  ${ALF_ALIASES_FILE:-unset}"
echo 
echo "Paths:"
echo "  alfrc path:        $rc_file"
echo "  aliases path:      $aliases_file"
echo "  repo path:         $repo_path"
echo "  config path:       $config_file"
echo 
echo "Files:"
echo "  alfrc:             $alfrc_content"
echo "  aliases:           $bash_aliases_status"
echo 
echo "GitHub:"
echo "  remote:            $remote"
echo 