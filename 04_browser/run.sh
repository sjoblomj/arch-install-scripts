#!/bin/bash
title="Install web browsers? (Select with Tab, Esc to quit)"
selections=$(printf "firefox\nchromium\ntorbrowser-launcher" | fzf --multi --tac --margin=4 --border --border-label="${title}")

if [ "$selections" != "" ]; then
    sudo pacman -S --needed $selections
    if [[ "$selections" =~ "firefox" ]]; then
        ./arkenfox.sh
    fi
fi
