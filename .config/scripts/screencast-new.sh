#!/usr/bin/env bash

PID_FILE="/tmp/screencast.pid"
SCREENCAST_FILE="/tmp/screencast.mp4"
set -x

if [ -e $PID_FILE ]; then
    kill -s INT "$(cat $PID_FILE)"
    dragon -x $SCREENCAST_FILE
    rm $PID_FILE
else
    xrandr=$(jc xrandr)
    : ${JQ:=jq}
    mons=$($JQ '.screens[0].devices[]|select(.is_connected)' <<<$xrandr)
    nmons=$($JQ -s length <<<$mons)
    x=
    y=
    w=
    h=
    if [[ $nmons -gt 1 ]]; then
        xywh=$($JQ -r '[.device_name, .offset_width, .offset_height, .resolution_width, .resolution_height]|@tsv' <<<$mons |
            rofi -dmenu -display-columns 1 -display-columns-separator '\t' |
            cut -f 2-)
        read x y w h <<<$xywh
    else
        xywh=$($JQ -r 'select(.is_primary)|[.offset_width, .offset_height, .resolution_width, .resolution_height]|@tsv' <<<$mons)
        read x y w h <<<$xywh
    fi

    ffmpeg -y -thread_queue_size 65536 \
        -f lavfi -i aevalsrc=0 \
        -video_size ${w}x${h} \
        -f x11grab -i $DISPLAY+$x,$y \
        -vcodec libx264 \
        -pix_fmt yuv420p \
        -f mp4 \
        $SCREENCAST_FILE &
    echo $! >$PID_FILE
    # -hwaccel_output_format vaapi -hwaccel vaapi -vaapi_device /dev/dri/renderD128 \
fi
