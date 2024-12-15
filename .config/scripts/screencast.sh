#!/bin/sh
set -x

# TODO: zvuk eba https://trac.ffmpeg.org/wiki/Capture/Desktop#Linux

PID_FILE="/tmp/screencast.pid"
SCREENCAST_FILE="/tmp/screencast"

if [ -e $PID_FILE ]; then
  kill -s INT "$(cat $PID_FILE)"
  dragon -x $SCREENCAST_FILE
  rm $PID_FILE
else
  # [telega mp4]
  ffmpeg -y \
    -thread_queue_size 65536 \
    -f lavfi -i aevalsrc=0 \
    -f x11grab -i "$DISPLAY" \
    -vcodec libx264 \
    -pix_fmt yuv420p \
    "$SCREENCAST_FILE.mp4" &
  echo $! >$PID_FILE

  # [telega gif]
  # ffmpeg -y \
  #   -thread_queue_size 65536 \
  #   -f x11grab -i "$DISPLAY" \
  #   -vcodec libx264 \
  #   -pix_fmt yuv420p \
  #   "$SCREENCAST_FILE.mp4" &
  # echo $! >$PID_FILE

  # [PAVEL]
  # ffmpeg -y -thread_queue_size 65536 \
  #   -hwaccel_output_format vaapi -hwaccel vaapi -vaapi_device /dev/dri/renderD128 \
  #   -f lavfi -i aevalsrc=0 \
  #   -f x11grab -i $DISPLAY \
  #   -vcodec libx264 \
  #   -pix_fmt yuv420p \
  #   -f mp4 \
  #   $SCREENCAST_FILE &
  # echo $! >$PID_FILE
fi
