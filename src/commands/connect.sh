repo=${args[repo]}
force=${args[--yes]}
force_ssh=${args[--ssh]}
force_https=${args[--https]}

connect_repo "$repo" "$force" "$force_ssh" "$force_https"
