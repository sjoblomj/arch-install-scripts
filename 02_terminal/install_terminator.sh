#!/bin/bash

sudo pacman -S --needed terminator
if ! grep -sq "cursor_blink" $HOME/.config/terminator/config ; then
    mkdir -p $HOME/.config/terminator
    echo "[profiles]" >> $HOME/.config/terminator/config
    echo "  [[default]]" >> $HOME/.config/terminator/config
    echo "    cursor_blink = False" >> $HOME/.config/terminator/config
    echo "    scrollback_lines = 50000" >> $HOME/.config/terminator/config
    echo "    use_system_font = False" >> $HOME/.config/terminator/config
    echo "    font = Source Code Pro 16" >> $HOME/.config/terminator/config
fi
mkdir -p $HOME/.local/share/icons/hicolor/scalable/apps
cp /usr/share/icons/hicolor/scalable/apps/terminator.svg $HOME/.local/share/icons/hicolor/scalable/apps
