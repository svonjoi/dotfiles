#!/bin/bash
ls ~/.local/share/remmina/ | rofi -sep '\n' -dmenu | xargs -I {} remmina -c /home/$USER/.local/share/remmina/{}
