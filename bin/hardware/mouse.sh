#!/bin/zsh
# ,---- [ Mouse config ]
# | 
# | xinput list
# | 
# `----


CYAN='\033[0;36m'
NC='\033[0m' # No Color


#+----------------------------------------------+
#| ⚡ MX Ergo                                   |
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
xinput --set-prop 'pointer:Logitech MX Ergo' 'libinput Accel Speed' -0.2
# xinput set-prop "pointer:Logitech MX Ergo" "Device Accel Profile" -1
# xinput set-prop "pointer:Logitech MX Ergo" "Device Accel Velocity Scaling" 0.1


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



# declare -A arrSearch=(
#     [m570]='Logitech M570'
#     [mx_ergo]='Logitech MX Ergo'
#     [razer]='Razer DeathAdder'
#     # [Keyboard]=A4Tech
# )


# for i in ${!arrSearch[@]}
# do
    
#     ids=$(xinput --list | awk -v search="${arrSearch[$i]}" \
#         '$0 ~ search {match($0, /id=[0-9]+/);\
#                     if (RSTART) \
#                         print substr($0, RSTART+3, RLENGTH-3)\
#                     }'\
#         )

#     # id=$(xinput list --id-only 'Logitech M570') # ? only valid 4 single device match

#     printf "${CYAN}Setting mouse config for -> $i${NC}\n"

#     if [ "$i" = "m570" ]; then 
#         for j in $ids
#         do
#             xinput --set-prop $j 321 1.6
#         done
#     fi

#     if [ "$i" = "mx_ergo" ]; then 
#         for j in $ids
#         do
#             # xinput --set-prop $j 321 3
#             xinput set-prop $j "Device Accel Constant Deceleration" 3
#         done
#     fi

#     if [ "$i" = "razer" ]; then 
#         # para la busqueda de razer encuentra mil mierdas por eso puede dar
#         # error cuando aplicamos las propiedades por ejemplo a un teclado
#         for j in $ids
#         do
#             # xinput --set-prop $j 320 -1
#             # xinput --set-prop $j 321 2
#             # xinput --set-prop $j 322 1
#             # xinput --set-prop $j 323 1
#             xinput set-prop $j 'Device Accel Profile' -1
#             xinput set-prop $j 'Device Accel Constant Deceleration' 2
#             xinput set-prop $j 'Device Accel Adaptive Deceleration' 1
#             xinput set-prop $j 'Device Accel Velocity Scaling' 1
#         done
#     fi

# done





