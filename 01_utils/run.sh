#!/bin/bash
preview_dir="programs/"
title="Choose programs to install (Select with Tab)"
selection=$(ls "$preview_dir" | fzf --multi --tac --margin=4 --border --border-label="${title}" --preview "cat ${preview_dir}{}" --preview-window right:wrap)

if [ "$selection" != "" ]; then
    sudo pacman -S --needed $selection
fi
