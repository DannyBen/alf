find_config() {
  repo_path="$PWD/alf-conf"
  config_file="alf.conf"
  if [[ -f $rc_file ]]; then
    repo_path=$(<"$rc_file")
    config_file=$repo_path/alf.conf
  fi

  if [[ ! -f $config_file ]]; then
    printf "ERROR: Cannot find config file\n\n"
    echo "You should either:"
    echo "- Run this command in a folder with 'alf.conf' file, or"
    echo "- Run 'alf connect' to properly connect to a remote config"
    exit 1
  fi
}