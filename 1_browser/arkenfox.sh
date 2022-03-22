#!/bin/bash

firefox addons.html

sudo pacman -S git
mkdir -p ~/bin/arkenfox
cd ~/bin/arkenfox
git clone https://github.com/arkenfox/user.js.git

ln -s ~/bin/arkenfox/user.js/user.js ~/bin/arkenfox/user.js/prefsCleaner.sh ~/bin/arkenfox/user.js/updater.sh ~/.mozilla/firefox/*.default-release
cp ~/code/arch-install-scripts/1_browser/user-overrides.js ~/.mozilla/firefox/*.default-release/user-overrides.js

