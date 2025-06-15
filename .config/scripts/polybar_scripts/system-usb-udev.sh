#!/bin/sh
# set -x


# fix: show part rm=false if is mounted in /run/media, workaround for motorhead as it is identified
# as rm=false by the system; but this only will work with udiskie..
jq_query_mounted='.blockdevices[] |
        select(.type == "part") |
        select(.mountpoint != null) |
        select(.rm == true or (.mountpoint | startswith("/run/media")))'

usb_print() {
    devices=$(lsblk -Jplno NAME,TYPE,RM,SIZE,MOUNTPOINT,VENDOR)
    output=""
    counter=0

    #? i dont give a fuck about unmounted devices cuz using udiskie
    # for unmounted in $(echo "$devices" | jq -r '.blockdevices[] | select(.type == "part") | select(.rm == true) | select(.mountpoint == null) | .name'); do
    #     unmounted=$(echo "$unmounted" | tr -d "[:digit:]")
    #     unmounted=$(echo "$devices" | jq -r '.blockdevices[] | select(.name == "'"$unmounted"'") | .vendor')
    #     unmounted=$(echo "$unmounted" | tr -d ' ')

    #     if [ $counter -eq 0 ]; then
    #         space=""
    #     else
    #         space=" | "
    #     fi
    #     counter=$((counter + 1))

    #     output="$output$space  $unmounted"
    # done

    mounted_devices=$(
        echo "$devices" | jq -r "${jq_query_mounted} | .size"
    )

    for mounted in $mounted_devices; do
        
        if [ $counter -eq 0 ]; then
            space=""
        else
            space=" | "
        fi
        counter=$((counter + 1))

        # v="#82aea9"
        v="${COLOR_SPECIAL_TEXT}"
        c=%{F${v}}
        nc=%{F-}

        output="$output$space${c}${nc}  $mounted"




    done

    echo "$output"
}

usb_update() {
    pid=$(cat "$path_pid")

    if [ "$pid" != "" ]; then
        kill -10 "$pid"
    fi
}

path_pid="/tmp/polybar-system-usb-udev.pid"

case "$1" in
    --update)
        usb_update
        ;;
    --unmount)
        devices=$(lsblk -Jplno NAME,TYPE,RM,MOUNTPOINT)

        mounted_devices=$(
            echo "$devices" | jq -r "${jq_query_mounted} | .name"
        )

        for mounted in $mounted_devices; do
            udisksctl unmount --no-user-interaction -b "$mounted"
            udisksctl power-off --no-user-interaction -b "$mounted"
        done

        usb_update
        ;;
    # --mount)
    #     devices=$(lsblk -Jplno NAME,TYPE,RM,MOUNTPOINT)

    #     for mount in $(echo "$devices" | jq -r '.blockdevices[] | select(.type == "part") | select(.rm == true) | select(.mountpoint == null) | .name'); do
    #         udisksctl mount --no-user-interaction -b "$mount"

    #         # mountpoint=$(udisksctl mount --no-user-interaction -b $mount)
    #         # mountpoint=$(echo $mountpoint | cut -d " " -f 4- | tr -d ".")
    #         # terminal -e "bash -lc 'filemanager $mountpoint'"
    #     done

    #     usb_update
    #     ;;
    *)
        echo $$ > $path_pid

        trap exit INT
        trap "echo" USR1

        while true; do
            usb_print

            # sleep 60 &
            sleep 5 &
            wait
        done
        ;;
esac
