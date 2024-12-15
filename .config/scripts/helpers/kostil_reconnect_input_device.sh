#!/bin/bash

# ,---- [ kostil_reconnect_input_device ]
# | run when connectiong input device
# `----
# set -euo pipefail

HOME=~

~/.config/scripts/hardware/mouse.sh
~/.config/scripts/hardware/layout.sh
~/.config/scripts/helpers/setup_remap.sh

notify-send "kostil_reconnect_input_device (done)"
