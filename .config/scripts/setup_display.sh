#!/bin/bash
# ,---- [ display setup ]
# | [V]ertical
# | [M]ain
# | [L]aptop
# `----

# todo: микс тире и подчеркиваний
# todo: поделить на маленькие скрипты
# set -x

#? [polybar]
# there are 3 types of bar configured: main|secondary|third; https://github.com/polybar/polybar/issues/763
# environment variables for use within polybar-config and polybar-scripts
export COLOR_PRIMARY="#8d95ff"

# the same vars defined in i3wm as here
out_DP_1="DP-1"
out_DP_2="DP-2"
outLaptop="eDP-1"
outHDMI="HDMI-1"

#* si en VML/ML hay algun bug de visualizacion o de polybar, primero switch to laptop and then to 3 mon
#* caso: left inverted mon not working after sleep laptop: restart docking

# DESC: Parameter parser
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: Variables indicating command-line parameters and options
function parse_params() {

	setup_vml=0
	setup_m=0
	setup_l=0
	setup_ml=0
	apply_xrandr=0
	disable_laptop=0
	enable_laptop=0
	apply_polybar=0
	setup_polybar_all_mon=0

	if [ $# -eq 0 ]; then
		echo "No parameter was provided" >&2
		exit 1
	fi

	local param
	while [[ $# -gt 0 ]]; do

		param="$1"
		shift
		case $param in
		-h | --help)
			# script_usage
			exit 0
			;;
		--setup_vm)
			setup_vm=1
			;;
		--setup_mv)
			setup_mv=1
			;;
		--setup_vml)
			setup_vml=1
			;;
		--setup_m)
			setup_m=1
			;;
		--setup_l)
			setup_l=1
			;;
		--setup_ml)
			setup_ml=1
			;;
		--apply_xrandr)
			apply_xrandr=1
			;;
		--apply_polybar)
			apply_polybar=1
			;;
		--disable_laptop)
			disable_laptop=1
			;;
		--enable_laptop)
			enable_laptop=1
			;;
		--setup_polybar_all_mon)
			setup_polybar_all_mon=1
			;;
		*)
			echo "Invalid parameter was provided" >&2 # Print error message to standard error
			exit 1
			;;
		esac
	done
}

function is_monitor_connected() {
	xrandr | grep "$1" | grep " connected " >/dev/null
}

# DESC: Main control flow
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: None
function main() {

	parse_params "$@"

	# Terminate already running bar instances
	killall -q -9 polybar

	# Wait until the processes have been shut down
	while pgrep -x polybar >/dev/null; do sleep 1; done

	#? setup:VM
	if [ $setup_vm -eq 1 ]; then

		# [V] connected via docking (60hz)
		# [M] connected via HDMI port (144hz)

		if ! is_monitor_connected "$outHDMI"; then
			notify-send "$outHDMI is not fucking pluged"
		fi

		if ! is_monitor_connected "$out_DP_2"; then
			notify-send "$out_DP_2 is not fucking pluged"
		fi

		if [ $apply_xrandr -eq 1 ]; then

			xrandr --output $outHDMI --primary --mode 1920x1080 --rate 144 --pos 1080x548 --rotate normal \
				--output $out_DP_2 --mode 1920x1080 --pos 0x0 --rotate left \
				--output $out_DP_1 --off \
				--output $outLaptop --off
		fi

		if [ $apply_polybar -eq 1 ]; then
			MONITOR=$outHDMI polybar --reload main 2>/tmp/polybar.log &
			MONITOR=$out_DP_2 polybar --reload secondary &
		fi
		xmodmap ~/.Xmodmap
	fi

	#? setup:MV
	if [ $setup_mv -eq 1 ]; then

		# [M] (left-positioned) connected via HDMI port (144hz)
		# [V] (right-positioned) connected dp-2 (?hz)

		if ! is_monitor_connected "$outHDMI"; then
			notify-send "$outHDMI is not fucking pluged"
		fi

		if ! is_monitor_connected "$out_DP_1"; then
			notify-send "$out_DP_1 is not fucking pluged"
		fi

		if [ $apply_xrandr -eq 1 ]; then

			xrandr \
				--output $outHDMI --primary --mode 1920x1080 --rate 144 --pos 0x420 --rotate normal \
				--output $out_DP_1 --mode 1920x1080 --pos 1920x0 --rotate right \
				--output $out_DP_2 --off \
				--output $outLaptop --off

		fi

		if [ $apply_polybar -eq 1 ]; then
			MONITOR=$outHDMI polybar --reload main 2>/tmp/polybar.log &
			MONITOR=$out_DP_1 polybar --reload secondary &
		fi
		xmodmap ~/.Xmodmap
	fi

	#? setup:ML
	if [ $setup_ml -eq 1 ]; then

		if ! is_monitor_connected "$outHDMI"; then
			notify-send "$outHDMI is not fucking pluged"
		fi

		if [ $apply_xrandr -eq 1 ]; then
			#* rate 144
			xrandr --output $outLaptop --mode 1368x768 --pos 1920x0 --rotate normal \
				--output $outHDMI --primary --mode 1920x1080 --rate 144 --pos 0x0 --rotate normal \
				--output $out_DP_2 --off \
				--output $out_DP_1 --off
		fi

		if [ $apply_polybar -eq 1 ]; then
			MONITOR=$outHDMI polybar --reload main &
			MONITOR=$outLaptop polybar --reload secondary &
		fi
		xmodmap ~/.Xmodmap
	fi

	#? setup:L
	if [ $setup_l -eq 1 ]; then

		if [ $apply_xrandr -eq 1 ]; then
			xrandr --output $outLaptop --mode 1920x1080 --pos 0x0 --rotate normal \
				--output $out_DP_1 --off \
				--output $out_DP_2 --off \
				--output $outHDMI --off
		fi

		if [ $apply_polybar -eq 1 ]; then
			MONITOR=$outLaptop polybar --reload main &
		fi
		xmodmap ~/.Xmodmap
	fi

	#? setup:VML
	if [ $setup_vml -eq 1 ]; then
		# [V] connected via docking (60hz)
		# [M] connected via HDMI port (144hz)

		if ! is_monitor_connected "$outHDMI"; then
			notify-send "$outHDMI is not fucking plugged"
		fi

		if ! is_monitor_connected "$out_DP_2"; then
			notify-send "$out_DP_2 is not fucking plugged"
		fi

		if [ $apply_xrandr -eq 1 ]; then
			xrandr --output $outLaptop --mode 1368x768 --pos 3000x664 --rotate normal \
				--output $outHDMI --primary --mode 1920x1080 --rate 144 --pos 1080x548 --rotate normal \
				--output $out_DP_2 --mode 1920x1080 --pos 0x0 --rotate left \
				--output $out_DP_1 --off
		fi

		if [ $apply_polybar -eq 1 ]; then
			MONITOR=$outHDMI polybar --reload main &
			MONITOR=$out_DP_2 polybar --reload secondary &
			MONITOR=$outLaptop polybar --reload third &
		fi
		xmodmap ~/.Xmodmap
	fi

	#? setup:M
	if [ $setup_m -eq 1 ]; then

		if ! is_monitor_connected "$outHDMI"; then
			notify-send "$outHDMI is not fucking plugged"
		fi

		if [ $apply_xrandr -eq 1 ]; then
			xrandr --output $outHDMI --primary --mode 1920x1080 --rate 144 --pos 0x0 --rotate normal \
				--output $outLaptop --off \
				--output $out_DP_2 --off \
				--output $out_DP_1 --off
		fi

		if [ $apply_polybar -eq 1 ]; then
			MONITOR=$outHDMI polybar --reload main &
		fi
		xmodmap ~/.Xmodmap
	fi

	#? set main bar on all monitors
	if [ $setup_polybar_all_mon -eq 1 ]; then
		if type "xrandr"; then
			for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
				MONITOR=$m polybar --reload main &
			done
		else
			polybar --reload main &
		fi
	fi

}

main "$@"
