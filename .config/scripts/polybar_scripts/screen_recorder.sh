#!/bin/sh

PID_FILE="/tmp/screencast.pid"
SCREENCAST_FILE="/tmp/screencast.mp4"

if [ -e $PID_FILE ]; then
    echo REC.
else
    echo ""
fi
