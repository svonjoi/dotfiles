#!/usr/bin/env bash
# Get current swap usage for all running processes
# Erik Ljungstrom 27/05/2011
# Modified by Mikko Rantalainen 2012-08-09
# Pipe the output to "sort -nk3" to get sorted output
# Modified by Marc Methot 2014-09-18
# removed the need for sudo

# original script: https://stackoverflow.com/questions/479953/how-to-find-out-which-processes-are-using-swap-space-in-linux#7180078
# ps aux --no-headers | awk '{print $2}' | ./swap-usage-shiny.sh | sort -nk3 | @c2
# ls /proc |wc -l
# ядро решает куда свапать; висит у тебя говно и память не юзает, значит в своп

# NOTE: full swap usage
#
# find /proc -maxdepth 1 -regex '^/proc/[0-9]+' -printf %f\n | ./swap-usage-shiny.sh > /tmp/swap_usage
# sort --numeric-sort -k 3 /tmp/swap_usage
# sort -k 3 /tmp/swap_usage | awk '{sum+=$3/1024;} END{print sum,"mb"}'

set -euo pipefail
SUM=0
OVERALL=0
# for DIR in `find /proc/ -maxdepth 1 -type d -regex "^/proc/[0-9]+"`
while read PID; do
	# PID=`echo $DIR | cut -d / -f 3`
	PROGNAME=$(ps -p $PID -o comm --no-headers)
	for SWAP in $(grep VmSwap /proc/$PID/status 2>/dev/null | awk '{ print $2 }'); do
		let SUM=$SUM+$SWAP
	done
	if (($SUM > 0)); then
		echo "PID=$PID swapped $SUM KB ($PROGNAME)"
	fi
	let OVERALL=$OVERALL+$SUM
	SUM=0
done
echo "Overall swap used: $OVERALL KB"
