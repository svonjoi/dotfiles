#!/bin/bash
# ,---- [ Svonux config backup ]
# |
# | Why? Collect all important cfg files across system and sync with repo, following directory structure
# | Template ref https://github.com/ralish/bash-script-template/blob/main/script.sh
# |
# | How it works? Rsync files included in home_filter.list to [~/data/svonux/rsync_svonux_backup]
# | and then push to repo with --sync-repo option
# |
# | Changes in this script (and all ~/.config/scripts folder) will be sync with this script
# |
# `----

source ~/.config/scripts/lib/color_output.sh

# stop script if error code; set -x
set -e
# set -x

#? manual-assign variables
REPO_DIR=$HOME/dev/repo/svonux
DST_DIR=$REPO_DIR/rsync_svonux_backup

SCRIPT=$(readlink -f "$0")      # Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPTPATH=$(dirname "$SCRIPT") # Absolute path this script is in, thus /home/user/bin

# DESC: Usage help
# ARGS: None
# OUTS: None
function script_usage() {
  cat <<EOF
Usage:
     -h|--help                  Displays this help
     --dry-run                  Show files to be copied and size

     --sync-repo                commit & push to repo. Only will work without --dry-run option
     --make-restore             Compose script to change root file permissions and ownership (also if --dump-root)
     --dump-home                Dump home files
     --dump-root                Dump root files
     --dump-git                 Dump git configs
     --full                     Dump all shit

All other options are mapped to [rsync]. Si pasamos --dry-run, ademas hace pausas (para visualizar el resumen de cada rsync)

Examples:

    script.sh --dump-home --sync-repo

EOF
}

# DESC: Parameter parser
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: Variables indicating command-line parameters and options
function parse_params() {

  sync_repo=0
  dry_run=0

  dump_home_files=0
  dump_root_files=0
  dump_git_configs=0
  make_restore=0

  local param
  while [[ $# -gt 0 ]]; do
    param="$1"
    shift
    case $param in
    -h | --help)
      script_usage
      exit 0
      ;;
    --dry-run)
      dry_run=1
      ;;
    --sync-repo)
      sync_repo=1
      ;;
    --dump-home)
      dump_home_files=1
      ;;
    --dump-root)
      dump_root_files=1
      ;;
    --dump-git)
      dump_git_configs=1
      ;;
    --make-restore)
      make_restore=1
      ;;
    --full)
      sync_repo=1
      make_restore=1
      dump_git_configs=1
      dump_root_files=1
      dump_home_files=1
      ;;
    *)
      # script_exit "Invalid parameter was provided: $param" 1
      ;;
    esac
  done
}

# https://stackoverflow.com/questions/3685970/check-if-a-bash-array-contains-a-value
in_array() {
  local needle="$1"
  shift 1
  local haystack=("$@")

  local value
  for value in "${haystack[@]}"; do
    [ "$value" = "$needle" ] && return 0
  done
  return 1
}

# DESC: Main control flow
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: None
function main() {

  parse_params "$@"

  targetdir_home=$DST_DIR/$HOME
  targetdir_root=$DST_DIR/root
  script_restore_perm=$DST_DIR/script_restore_perm.sh

  if [ ! -d "$REPO_DIR" ]; then
    echo "target dir does not exist [$REPO_DIR]"
    exit 0
  fi

  # common options
  rsync_options=(
    "--archive"
    "--human-readable"
    # "--stats"
    "--progress"
    "--delete-excluded"
    # "--verbose"
    "-i" # [>f.st......] info about file (why it will be transferred)
    # "--color=auto"
    --out-format='%i[%n]%m'
  )

  if [ $dry_run -eq 1 ]; then
    rsync_options+=(
      "--dry-run"
    )
  fi

  # +--------------------------+
  # | rsync home               |
  # +--------------------------+
  if [ $dump_home_files -eq 1 ]; then

    printf_color red "rsync home.."

    [ $dry_run -eq 0 ] && mkdir -p $targetdir_home

    rsync "${rsync_options[@]}" \
      --filter="merge ${SCRIPTPATH}/home_filter.list" \
      $HOME/ $targetdir_home
  fi

  # +--------------------------+
  # | rsync root               |
  # +--------------------------+
  if [ $dump_root_files -eq 1 ]; then

    printf_color red "rsync root.."

    [ $dry_run -eq 0 ] && mkdir -p $targetdir_root

    sudo rsync "${rsync_options[@]}" \
      --filter="merge ${SCRIPTPATH}/root_filter.list" \
      / $targetdir_root
  fi

  # +------------------------------------------------+
  # |     compose script for restore root files      |
  # +------------------------------------------------+
  # restore permissions and ownership
  # run with sudo
  if [ $dump_root_files -eq 1 ] || [ $make_restore -eq 1 ]; then

    # the script is done with paths pointing dirs or files; Each chmod/chown statment is executed
    # NON recursively, so if this array is not done well it shouldn't be a problem
    excluded_real_paths=(
      '/etc'
      '/etc/systemd'
      '/etc/udev'
    )

    >$script_restore_perm || {
      echo "Error: Cannot write to $script_restore_perm"
      exit 1
    }

    # make array with dump paths from copied root files; ie:
    # /home/svonjoi/repo/svonux/rsync_svonux_backup/root/etc/keyd/default.conf
    readarray -t dump_filepaths < <(sudo find "$targetdir_root") || {
      echo "Error: Failed to read paths from $targetdir_root"
      exit 1
    }

    echo -e "# this shit is dynamically created by dump script\n" >>$script_restore_perm

    # generate array with real paths from dump paths. ie:
    # /etc/keyd/default.conf
    filepaths=()
    for dump_filepath in "${dump_filepaths[@]}"; do
      real_filepath=$(echo "$dump_filepath" | sed "s|^$targetdir_root||")
      [ -z "$real_filepath" ] && continue

      if in_array "${real_filepath}" "${excluded_real_paths[@]}"; then
        echo "# --- ${real_filepath} is excluded" >>$script_restore_perm
        continue
      fi

      filepaths+=("$real_filepath")
    done

    if [ "${#filepaths[@]}" -lt 1 ]; then
      echo "Error: No filepaths found. Exiting."
      exit 1
    fi

    # permissions and ownership
    for i in "${!filepaths[@]}"; do
      filepath=${filepaths[$i]}

      dump_filepath=${dump_filepaths[$i]}
      permissions=$(sudo stat -c %a "$filepath")
      owner=$(sudo stat -c '%U' "$filepath")
      group=$(sudo stat -c '%G' "$filepath")

      # TODO: add the fucking cp command; The following is not working cuz of incorrect indexes
      # echo "cp -r $dump_filepath $filepath" >>$script_restore_perm

      echo "chown -v $owner:$group $filepath" >>$script_restore_perm
      echo "chmod -v $permissions $filepath" >>$script_restore_perm
      echo "echo -e '\n'" >>$script_restore_perm
      echo -e '######' >>$script_restore_perm
    done
  fi

  # +--------------------------+
  # | .git configs             |
  # +--------------------------+
  if [ $dump_git_configs -eq 1 ]; then

    printf_color red "rsync git configs from initialized repo's.."

    dirs_with_initialized_git_repos=(
      "$DST_DIR/home/svonjoi/dev"
      # "$DST_DIR/home/svonjoi/repo"
    )
    if [ $dry_run -eq 0 ]; then
      for dir in "${dirs_with_initialized_git_repos[@]}"; do
        # manualmente borrar lo q se a generado en la ejecuccion anterior
        # con --delete-excluded prefiero no hacerlo xq genera mensajes basura
        # para eso he creado reglas en filter.list
        # exclude the .git2/ directories from synchronization but not delete them at the destination when using --delete-excluded
        find $dir -depth -type d -name ".git2" -execdir bash -c 'rm -rf "$0"' {} \;
        #? rename folders .git->.git2 in order to push git project configs to repo
        find $dir -depth -type d -name ".git" -execdir bash -c 'cp -r "$0" "${0//.git/.git2}"' {} \;
      done
    fi
  fi

  # +--------------------------+
  # | push remote              |
  # +--------------------------+
  if [ $dry_run -eq 0 ] && [ $sync_repo -eq 1 ]; then
    printf_color red "git push.."
    cd $REPO_DIR

    # sudo if we have to copy root files PRESERVING PERMISSIONS
    sudo git add .
    # git add .

    git commit -m "[autodump] by $SCRIPT"
    git push
  fi

}

main "$@"
