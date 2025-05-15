#!/bin/zsh

if pgrep -x "crow" >/dev/null; then
	# echo "Running"
else
	crow &
fi

qdbus org.kde.CrowTranslate /org/kde/CrowTranslate/MainWindow translateSelection
