#!/bin/bash

firefox 03_browser/addons.html

sudo pacman -S --needed git
mkdir -p ~/bin/arkenfox
mkdir -p ~/.config/arkenfox
cd ~/bin/arkenfox
git clone https://github.com/arkenfox/user.js.git

cp ~/code/arch-install-scripts/03_browser/user-overrides.js ~/bin/arkenfox/user.js/user-overrides.js
cp ~/code/arch-install-scripts/03_browser/arkenfox-update.sh ~/.config/arkenfox/arkenfox-update.sh
chmod +x ~/.config/arkenfox/arkenfox-update.sh

echo "source $HOME/.config/arkenfox/arkenfox-update.sh" >> ~/.zshrc
