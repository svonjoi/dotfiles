#!/bin/bash
set -x

# TODO: zvuk eba https://trac.ffmpeg.org/wiki/Capture/Desktop#Linux

# TODO: polybar: check if process is running, not the pid file existance.
# this way if ffmpeg failed to start, i will see

PID_FILE="/tmp/screencast.pid"
SCREENCAST_FILE="/tmp/screencast.mp4"
DEBUG=false

stop_recording() {
    if [ "$DEBUG" = "true" ]; then
        notify-send "Stopping recording..."
    fi

    if [ -f "$PID_FILE" ]; then
        PID=$(cat "$PID_FILE")

        if [ "$DEBUG" = "true" ]; then
            notify-send "pid writed in file: $PID"
        fi

        if kill -s INT "$PID" 2>/dev/null; then

            if [ "$DEBUG" = "true" ]; then
                notify-send "Process $PID killed"
            fi
        else
            notify-send "Failed to kill process $PID"
        fi

        rm "$PID_FILE"
        if [ "$DEBUG" = "true" ]; then
            notify-send "PID file removed"
        fi
    else
        notify-send "No PID file found. Nothing to stop."
    fi

    # if [ -f "$PID_FILE" ]; then
    # 	# kill -s SIGINT "$PID"
    # 	# wait "$PID" 2>/dev/null
    # 	kill -s INT "$(cat $PID_FILE)" && notify-send "proc: $(cat $PID_FILE) killed"
    # 	rm "$PID_FILE" && notify-send "pid file removed"
    # fi
}

if [ -e $PID_FILE ]; then
    stop_recording

    sleep 1

    capture_result_action=$(echo -e "copy-uri\nopen-in-player" | rofi -dmenu -i -auto-select -p "Choose result action:")
    case "$capture_result_action" in
    "copy-uri")
        ~/.config/scripts/helpers/yankuri.sh /tmp/screencast.mp4 && notify-send "screencast uri copied"
        ;;
    "open-in-player")
        ~/.config/scripts/helpers/yankuri.sh /tmp/screencast.mp4 && notify-send "screencast uri copied, opening in media player.."
        dragon $SCREENCAST_FILE
        ;;
    esac
else
    rm $SCREENCAST_FILE
    capture_type=$(echo -e "entire-screen\narea-selection" | rofi -dmenu -i -auto-select -p "Choose capture type:")
    case "$capture_type" in
    "entire-screen")
        # notify-send "entire screen selected"
        sleep 0.3
        ffmpeg -y \
            -thread_queue_size 65536 \
            -f lavfi -i aevalsrc=0 \
            -f x11grab -i "$DISPLAY" \
            -vcodec libx264 \
            -pix_fmt yuv420p \
            "$SCREENCAST_FILE" &
        echo $! >$PID_FILE
        exit 0
        ;;
    "area-selection")
        sleep 0.3
        # notify-send "area selection selected"
        slop=$(slop -f "%x %y %w %h %g %i") || {
            notify-send "Area selection cancelled"
            exit 1
        }

        read -r X Y W H G ID <<<"$slop"
        [[ "$W" -le 0 || "$H" -le 0 ]] && {
            notify-send "Invalid selection dimensions"
            exit 1
        }

        # ERROR:
        # [libx264 @ 0x559673ef0200] width not divisible by 2 (299x170)
        # FIX: Ensure width and height are even; Make dimensions even to satisfy libx264
        W=$((W - (W % 2)))
        H=$((H - (H % 2)))

        ffmpeg -y \
            -f lavfi -i aevalsrc=0 \
            -f x11grab \
            -s "${W}x${H}" \
            -i ":0.0+$X,$Y" \
            -vcodec libx264 \
            -pix_fmt yuv420p \
            "$SCREENCAST_FILE" &
        echo $! >$PID_FILE
        exit 0
        ;;

    *)
        notify-send "record cancelled"
        exit 0
        ;;
    esac
fi
