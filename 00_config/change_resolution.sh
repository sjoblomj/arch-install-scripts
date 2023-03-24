#!/bin/bash
sudo pacman -S --needed xrandr autorandr

arandr
autorandr --save resolution

if ! grep -sq "set screen resolution" $HOME/.config/openbox/autostart ; then
    sed -i '1 s/^/# set screen resolution\nautorandr --change\n\n/' $HOME/.config/openbox/autostart
fi
