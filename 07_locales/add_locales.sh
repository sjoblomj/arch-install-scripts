#!/bin/bash

title="Configure locale for gsimplecal (Calendar app)?"
locales="$@"

for l in $locales; do
    sudo sed -i "s/#$l/$l/" /etc/locale.gen
done

sudo locale-gen

if [ -f $HOME/.config/gsimplecal/config ]; then
    if ! grep -sq "force_lang" $HOME/.config/gsimplecal/config ; then
        selection=$(cat /etc/locale.gen | grep -Po "^[^#]\S*" | fzf --tac --margin=4 --border --border-label="$title")
        if [ "$selection" != "" ]; then
            echo "force_lang = $selection" >> $HOME/.config/gsimplecal/config
        fi
    fi
fi
