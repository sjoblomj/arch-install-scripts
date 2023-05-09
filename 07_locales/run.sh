#!/bin/bash

title="Add more locales?"
selection=$(cat /etc/locale.gen | grep -Po "^#\K\S*" | fzf --multi --layout=reverse --margin=4 --border --border-label="Add more locales? (Select with Tab)")

if [ "$selection" != "" ]; then
    ./add_locales.sh "$selection"
fi
