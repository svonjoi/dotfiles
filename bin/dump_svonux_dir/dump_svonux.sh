#!/bin/bash
# ,---- [ Svonux config backup ]
# | 
# | Why? Collect all important cfg files across system and sync with repo, following directory structure
# | Template ref https://github.com/ralish/bash-script-template/blob/main/script.sh
# | 
# | How it works? Rsync files included in home_filter.list to [~/data/svonux/rsync_svonux_backup]
# | and then push to repo with --sync-repo option
# |
# | Changes in this script (and all ~/bin folder) will be sync with this script
# | 
# `----

#todo: restore man
# | ### HOW TO RESTORE
# | --delete option will remove all target directory before sync

source ~/bin/lib/color_output.sh

# stop script if error code
set -e
# set -x

REPO_DIR=$HOME/repo/svonux
DST_DIR=$REPO_DIR/rsync_svonux_backup

SCRIPT=$(readlink -f "$0") # Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPTPATH=$(dirname "$SCRIPT") # Absolute path this script is in, thus /home/user/bin

# DESC: Usage help
# ARGS: None
# OUTS: None
function script_usage() {
    cat << EOF
Usage:
     -h|--help                  Displays this help
     --sync-repo                commit & push to repo. Only will work without --dry-run option
     --dry-run                  Show files to be copied and size

All other options are mapped to [rsync]. Si pasamos --dry-run, ademas hace pausas (para visualizar el resumen de cada rsync)

Examples:

    bash script.sh --sync-repo

EOF
}


# DESC: Parameter parser
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: Variables indicating command-line parameters and options
function parse_params() {
    
    sync_repo=0
    dry_run=0
    
    local param
    while [[ $# -gt 0 ]]; do
        param="$1"
        shift
        case $param in
            -h | --help)
                script_usage
                exit 0
                ;;
            --sync-repo)
                sync_repo=1
                ;;
            --dry-run)
                dry_run=1
                ;;
            *)
                # script_exit "Invalid parameter was provided: $param" 1
                ;;
        esac
    done
}

# DESC: Main control flow
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: None
function main() {

    targetdir_home=$DST_DIR/$HOME
    # targetdir_root=$DST_DIR/root

    parse_params "$@"

    if [ ! -d "$REPO_DIR" ]; then
        echo "target dir does not exist [$REPO_DIR]";
        exit 0;
    fi

    # si no es --dry-run, crear target dirs
    if [ $dry_run -eq 0 ]; then
        mkdir -p $targetdir_home
        # mkdir -p $targetdir_root
    fi

    # common options
    options=(
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
        options+=(
            "--dry-run"
        )
    fi


    #? rsync home
    printf_color red "rsync home.."

    rsync "${options[@]}" \
        --filter="merge ${SCRIPTPATH}/home_filter.list" \
        $HOME/ $targetdir_home


    #? rsync root
    # printf_color red "rsync root.."

    # sudo rsync "${options[@]}" \
    #     --filter="merge ${SCRIPTPATH}/root_filter.list" \
    #     / $targetdir_root

    #+--------------------------+
    #| .git configs             |
    #+--------------------------+
    dirs_with_git=(
        "$DST_DIR/home/svonjoi/dev"
        "$DST_DIR/home/svonjoi/repo"
    )
    if [ $dry_run -eq 0 ]; then
        for dir in "${dirs_with_git[@]}"; do
            # manualmente borrar lo q se a generado en la ejecuccion anterior
            # con --delete-excluded prefiero no hacerlo xq genera mensajes basura
            # para eso he creado reglas en filter.list
            # exclude the .git2/ directories from synchronization but not delete them at the destination when using --delete-excluded
            find $dir -depth -type d -name ".git2" -execdir bash -c 'rm -rf "$0"' {} \;
            #? rename folders .git->.git2 in order to push git project configs to repo
            find $dir -depth -type d -name ".git" -execdir bash -c 'cp -r "$0" "${0//.git/.git2}"' {} \;
        done
    fi

    #+--------------------------+
    #| push                     |
    #+--------------------------+

    #? git sync
    if [ $dry_run -eq 0 ] && [ $sync_repo -eq 1 ]; then
        printf_color red "git push.."
        cd $REPO_DIR
        # // sudo cuz we copy root files preserving permissions
        # sudo git add .
        git add .
        git commit -m "[autodump] by $SCRIPT"
        git push
    fi

}


main "$@"