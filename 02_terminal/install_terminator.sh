#!/bin/bash

sudo pacman -S --needed terminator
if ! grep -sq "cursor_blink" $HOME/.config/terminator/config ; then
    echo "[profiles]" >> $HOME/.config/terminator/config
    echo "  [[default]]" >> $HOME/.config/terminator/config
    echo "    cursor_blink = False" >> $HOME/.config/terminator/config
    echo "    scrollback_lines = 50000" >> $HOME/.config/terminator/config
fi
