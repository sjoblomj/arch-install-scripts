#!/bin/bash
preview_dir="programs/"
title="Choose programs to install (Select with Tab)"
selection=$(ls "$preview_dir" | fzf --multi --layout=reverse --margin=4 --border --border-label="${title}" --preview "cat ${preview_dir}{}" --preview-window right:wrap)

if [ "$selection" != "" ]; then
    sudo pacman -S --needed $selection
    if [[ "$selections" =~ "vlc" ]]; then
        sudo pacman -S --needed qt5-wayland
        mkdir -p $HOME.local/share/icons/hicolor/scalable/apps
        curl https://upload.wikimedia.org/wikipedia/commons/e/e6/VLC_Icon.svg -o $HOME/.local/share/icons/hicolor/scalable/apps/vlc.svg
    fi
    if [[ "$selections" =~ "evince" ]]; then
        sudo cp /usr/share/applications/org.gnome.Evince.desktop /usr/share/applications/evince.desktop
    fi
    if [[ "$selection" =~ "transmission-qt" ]]; then
        curl https://upload.wikimedia.org/wikipedia/commons/4/46/Transmission_Icon.svg -o /usr/share/icons/hicolor/scalable/apps/transmission.svg
        sudo curl https://upload.wikimedia.org/wikipedia/commons/thumb/4/46/Transmission_Icon.svg/48px-Transmission_Icon.svg.png -o /usr/share/icons/hicolor/48x48/apps/transmission.png
        sudo gtk-update-icon-cache /usr/share/icons/hicolor
    fi
fi
