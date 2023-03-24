#!/bin/bash

sudo pacman-key --init
sudo pacman-key --populate archlinux

sudo pacman -Suy
sudo pacman -S --needed git fzf

mkdir -p ~/code/arch-install-scripts
git clone https://github.com/sjoblomj/arch-install-scripts ~/code/arch-install-scripts
cd ~/code/arch-install-scripts

./find_scripts.sh
