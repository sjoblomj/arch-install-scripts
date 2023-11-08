#!/bin/bash

firefox addons.html

sudo pacman -S --needed git

mkdir -p $HOME/bin/arkenfox
mkdir -p $HOME/.config/arkenfox
git clone https://github.com/arkenfox/user.js.git $HOME/bin/arkenfox

cp user-overrides.js $HOME/bin/arkenfox/user.js/user-overrides.js
cp arkenfox-update.sh $HOME/.config/arkenfox/arkenfox-update.sh
chmod +x $HOME/.config/arkenfox/arkenfox-update.sh

if ! grep -sq "arkenfox-update.sh" $HOME/.zshrc ; then
    echo 'source $HOME/.config/arkenfox/arkenfox-update.sh' >> $HOME/.zshrc
fi
