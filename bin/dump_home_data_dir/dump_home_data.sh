#!/bin/bash
# ,---- [ Svonux home backup ]
# | 
# | 
# `----

# todo: backup dir specificos
# todo: exclude dev/assets/_db_data/

source ~/bin/lib/color_output.sh

USER=svonjoi

#? Help > Troubleshooting Information > Profile Directory: Open folder
#? THNPROFILE=/home/${USER}/snap/thunderbird/common/.thunderbird/dac42lsi.default
THNPROFILE=/home/${USER}/.thunderbird/8x7t9frb.default-release

TGT_THNPROFILE_DIRNAME=thunderbird_profile

SCRIPT=$(readlink -f "$0") # Absolute path to this script, e.g. /home/user/bin/foo.sh
SCRIPTPATH=$(dirname "$SCRIPT") # Absolute path this script is in, thus /home/user/bin
SRC_DIR=/home/${USER}
TGT_DIRNAME=home_backup_${USER}
EXCLUDE_FILE=${SCRIPTPATH}/exclude.list

DST_KLOUD=$KLOUD/svonux_home_data
DST_HOME=$HOME/Desktop


function script_usage() {
    cat << EOF
[⚡Usage]
     -h|--help                  Displays this help
     --dry-run                  Show size of files to be copied
     --home                     Backup home dir
     --thunderbird              Backup thunderbird profile
     --destination              (*) kloud|desktop
        
[⚡Examples]
     bash script.sh --dry-run --home --thunderbird              show size of each backup
     bash script.sh --home --thunderbird --destination=kloud    backup both to kloud

[⚡Analize files to be copied]
     ncdu --exclude-from ~/bin/dump_home_data_dir/exclude.list ~/

[⚡Cfg]
    user: $USER
    thunderbird profile: $THNPROFILE
    destination=kloud: $DST_KLOUD
    destination=desktop: $DST_HOME

EOF
}

# DESC: Parameter parser
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: Variables indicating command-line parameters and options
function parse_params() {
    
    dry_run=0
    backup_home=0
    backup_thunderbird=0
    
    local param
    while [[ $# -gt 0 ]]; do
        param="$1"
        shift
        case $param in

            -h | --help)
                script_usage
                exit 0
                ;;

            # destination of compressed file
            --destination=*)

                dst_value="${param#*=}"

                case "$dst_value" in
                    kloud)
                        DST_DIR=$DST_KLOUD
                        ;;
                    desktop)
                        DST_DIR=$DST_HOME
                        ;;
                    *)
                        echo "Invalid destination: $dst_value"
                        exit 1
                        ;;
                esac
                ;;

            --home)
                backup_home=1
                ;;

            --thunderbird)
                backup_thunderbird=1
                ;;

            --dry-run)
                dry_run=1
                ;;
            *)
                # script_exit "Invalid parameter was provided: $param" 1
                ;;
        esac
    done

    #? Parametros obligatorios (if --dry-run is not passed)
    if [[ -z $dst_value && $dry_run -eq 0 ]]; then
        echo "Error: the --destination parameter is obligatory."
        exit 1
    fi
}

# DESC: Main control flow
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: None
function main() {

    parse_params "$@"

    #+----------------------------------------------+
    #| 📦 Backup home with exclude.list             |
    #+----------------------------------------------+

    if [ $backup_home -eq 1 ]; then

        rm -rf /tmp/$TGT_DIRNAME

        printf "$(colorize red "Backup home with exclude.list..")\n"; sleep 1

        options=(
            "--archive"
            "--human-readable"
            "--stats"
        )

        if [ $dry_run -eq 1 ]; then
            options+=(
                "--dry-run"
                # "--verbose"
            )
        else
            options+=(
                "--itemize-changes"
                "--verbose"
                "--progress"
            )
        fi

        # Construct the rsync command with the options array
        rsync "${options[@]}" --exclude-from=$EXCLUDE_FILE $SRC_DIR/ /tmp/${TGT_DIRNAME}

        #? Compress & copy compressed file 2 dst
        if [ $dry_run -eq 0 ]; then

            printf "$(colorize red "Compressing home dump..")\n"; sleep 1
            zipped_file=$(date +%Y-%m-%d_%H%M%S)_${TGT_DIRNAME}.tar.gz
            tar -zcvf /tmp/${zipped_file} /tmp/${TGT_DIRNAME}

            printf "$(colorize red "Compressed home file: /tmp/${zipped_file}")\n"; sleep 1
            printf "$(colorize red "Copying compressed home file to destination.. ${DST_DIR}")\n"; sleep 1
            cp /tmp/${zipped_file} ${DST_DIR}

            # 💡 remove zipped file
            # rm -f /tmp/${zipped_file}
        fi

    fi

    #+----------------------------------------------+
    #| 📦 Thunderbird                               |
    #+----------------------------------------------+

    if [ $backup_thunderbird -eq 1 ]; then

        rm -rf /tmp/$TGT_THNPROFILE_DIRNAME

        printf "\n$(colorize red "Thunderbird profile..")\n"; sleep 1

        if [ $dry_run -eq 0 ]; then

            THNDSTDIR=/tmp/$TGT_THNPROFILE_DIRNAME

            mkdir -p $THNDSTDIR
            cp -r $THNPROFILE $THNDSTDIR

            #? Compress & copy compressed file 2 dst
            printf "$(colorize red "Compressing thunderbird profile..")\n"; sleep 1
            zipped_file=$(date +%Y-%m-%d_%H%M%S)_${TGT_THNPROFILE_DIRNAME}.tar.gz
            tar -zcvf /tmp/${zipped_file} /tmp/${TGT_THNPROFILE_DIRNAME}

            printf "$(colorize red "Copying compressed thunderbird profile file to destination.. ${DST_DIR}")\n"; sleep 1
            cp /tmp/${zipped_file} ${DST_DIR}

            rm -f /tmp/${zipped_file}
        else
            du -sh $THNPROFILE
        fi

    fi

}

main "$@"
