#!/bin/zsh

#todo: NE RABOTAET

#amixer = Mixer for ALSA soundcard driver.

# With icon indicating the state of the mic
#*sudo apt install gawk

state=`amixer set Capture toggle | gawk 'match($0, /Front Left.*\[(.*)\]/, a) {print a[1]}'`
if [ $state = "off" ]; then
    icon="audio-input-microphone-muted-symbolic"
else
    icon="audio-input-microphone-symbolic"
fi
notify-send --hint=int:transient:1 -i $icon "Mic switched: $state"