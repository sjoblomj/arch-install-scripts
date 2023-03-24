#!/bin/bash

firefox addons.html

sudo pacman -S --needed git
mkdir -p ~/bin/arkenfox
mkdir -p ~/.config/arkenfox
cd ~/bin/arkenfox
git clone https://github.com/arkenfox/user.js.git

cp ~/code/arch-install-scripts/04_browser/user-overrides.js ~/bin/arkenfox/user.js/user-overrides.js
cp ~/code/arch-install-scripts/04_browser/arkenfox-update.sh ~/.config/arkenfox/arkenfox-update.sh
chmod +x ~/.config/arkenfox/arkenfox-update.sh

if ! grep -sq "arkenfox-update.sh" ~/.zshrc ; then
    echo 'source $HOME/.config/arkenfox/arkenfox-update.sh' >> ~/.zshrc
fi
