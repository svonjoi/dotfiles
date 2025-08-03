#!/bin/zsh
# ,---- [ Mouse config ]
# |
# | xinput list
# |
# `----

CYAN='\033[0;36m'
NC='\033[0m' # No Color

#+----------------------------------------------+
#| ⚡ TRACKBALL                                 |
#+----------------------------------------------+
# https://leahneukirchen.org/blog/archive/2020/06/5-days-with-the-mx-ergo.html
# http://www.x.org/wiki/Development/Documentation/PointerAcceleration/

# printf "${CYAN}Setting mouse config for -> Logitech MX Ergo${NC}\n"

# notify-send "Configuring Logitech MX Ergo"

setopt shwordsplit

#? evdev
# xinput --set-prop "Logitech MX Ergo" "Device Accel Constant Deceleration" 2
# xinput --set-prop 18 "Device Accel Constant Deceleration" 2
# xinput set-prop "${mouse_}" "Device Accel Profile" 7
# xinput set-prop "${mouse_}" "Device Accel Constant Deceleration" 1.05
# xinput set-prop "${mouse_}" "Device Accel Adaptive Deceleration" 1.05
# xinput set-prop "${mouse_}" "Device Accel Constant Deceleration" 0.8
# xinput set-prop "${mouse_}" "Device Accel Adaptive Deceleration" 1.5
# xinput set-prop "${mouse_}" "Device Accel Profile" 2
# xinput set-prop "${mouse_}" "Device Accel Constant Deceleration" 1.7
# xinput set-prop "${mouse_}" "Device Accel Adaptive Deceleration" 1.5

#? libinput
xinput --set-prop 'pointer:Logitech MX Ergo' 'libinput Accel Profile Enabled' 0, 1
xinput --set-prop 'pointer:Logitech MX Ergo' 'libinput Accel Speed' 0.1
# xinput set-prop "pointer:Logitech MX Ergo" "Device Accel Profile" -1
# xinput set-prop "pointer:Logitech MX Ergo" "Device Accel Velocity Scaling" 0.1

xinput --set-prop 'pointer:ELECOM TrackBall Mouse EX-G Pro TrackBall' 'libinput Accel Profile Enabled' 0, 1
xinput --set-prop 'pointer:ELECOM TrackBall Mouse EX-G Pro TrackBall' 'libinput Accel Speed' -0.2

#+----------------------------------------------+
#| ⚡ Razer                                     |
#+----------------------------------------------+
# printf "${CYAN}Setting mouse config for -> Razer Razer DeathAdder Essential${NC}\n"

#? evdev
# xinput set-prop "pointer:Razer Razer DeathAdder Essential" "Device Accel Profile" -1
# xinput set-prop "pointer:Razer Razer DeathAdder Essential" "Device Accel Constant Deceleration" 2
# xinput set-prop "pointer:Razer Razer DeathAdder Essential" "Device Accel Adaptive Deceleration" 1
# xinput set-prop "pointer:Razer Razer DeathAdder Essential" "Device Accel Velocity Scaling" 1

#? libinput
xinput --set-prop 'pointer:Razer Razer DeathAdder Essential' 'libinput Accel Profile Enabled' 0, 1
xinput --set-prop 'pointer:Razer Razer DeathAdder Essential' 'libinput Accel Speed' -0.6
