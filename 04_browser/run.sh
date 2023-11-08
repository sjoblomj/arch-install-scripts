#!/bin/bash
title="Install web browsers? (Select with Tab, Esc to quit)"
selections=$(printf "firefox\nchromium\ntorbrowser-launcher" | fzf --multi --tac --margin=4 --border --border-label="${title}")

add_icons_to_system() {
    added=0
    for s in $1; do
        filename=${s%-*}
        if [ ! -f "/usr/share/icons/hicolor/scalable/apps/${filename}.svg" ]; then
            sudo cp "${filename}.svg" "/usr/share/icons/hicolor/scalable/apps/${filename}.svg"
            added=1
        fi
    done
    if [ $added -eq 1 ]; then
        sudo gtk-update-icon-cache /usr/share/icons/hicolor/
    fi
}

if [ "$selections" != "" ]; then
    sudo pacman -S --needed $selections
    if [[ "$selections" =~ "firefox" ]]; then
        ./arkenfox.sh
    fi
    add_icons_to_system "$selections"
fi
