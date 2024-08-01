#!/bin/zsh

# DESC: Parameter parser
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: Variables indicating command-line parameters and options
function parse_params() {
    
    local param
    while [[ $# -gt 0 ]]; do
        param="$1"
        shift
        case $param in
            -h | --help)
                script_usage
                exit 0
                ;;
            *)
                # script_exit "Invalid parameter was provided: $param" 1
                dpname=$param
                ;;
        esac
    done
}


# DESC: Main control flow
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: None
function main() {

    notify-send "$dpname"
	exit 0
    parse_params "$@"

    # Check if DP-1 is connected
    if xrandr | grep "$dpname connected"; then
        # Set DP-1 as primary monitor
        xrandr --output $dpname --primary
        notify-send "$dpname set as primary monitor."
   fi
}


main "$@"
