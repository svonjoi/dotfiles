#!/bin/bash

# ,---- [ kostil_reconnect_input_device ]
# | run when connectiong input device
# `----
# set -euo pipefail
# TODO: automatically run when connectiong an input device

~/.config/scripts/hardware/mouse.sh
~/.config/scripts/hardware/layout.sh
~/.config/scripts/helpers/setup_remap.sh

notify-send "fix_input_device_connection: done"
