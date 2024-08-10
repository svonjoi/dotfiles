#!/bin/sh
set -x
#
# PID_FILE="/tmp/screencast.pid"
# SCREENCAST_FILE="/tmp/screencast.mp4"
#
# if [ -e $PID_FILE ]; then
#   kill -s INT "$(cat $PID_FILE)"
#   #kill -9 "$(cat $PID_FILE)"
#   dragon $SCREENCAST_FILE
#   rm $PID_FILE
# else
#   # -f x11grab -i $DISPLAY \
#   # X11 video input device
#   # https://ffmpeg.org/ffmpeg-devices.html#x11grab
#   # $DISPLAY cambia entre :0 y :1
#   ffmpeg -y -thread_queue_size 65536 \
#     -f x11grab -i :0 \
#     -vcodec libx264 \
#     $SCREENCAST_FILE &
#   echo $! >$PID_FILE
# fi

# TODO: new pavel script with mobile support
PID_FILE="/tmp/screencast.pid"
SCREENCAST_FILE="/tmp/screencast.mp4"

if [ -e $PID_FILE ]; then
  kill -s INT "$(cat $PID_FILE)"
  dragon -x $SCREENCAST_FILE
  rm $PID_FILE
else
  # -hwaccel_output_format vaapi -hwaccel vaapi -vaapi_device /dev/dri/renderD128 \
  # -f pulse -i default \
  ffmpeg -y -thread_queue_size 65536 \
    -f x11grab -i $DISPLAY \
    -vcodec libx264 \
    -pix_fmt yuv420p \
    -f mp4 \
    $SCREENCAST_FILE &
  echo $! >$PID_FILE
fi
