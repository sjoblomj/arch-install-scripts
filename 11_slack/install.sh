#!/bin/bash

prev_dir=$(pwd)
sudo pacman -S --needed git base-devel
mkdir -p $HOME/bin
cd $HOME/bin
git clone https://aur.archlinux.org/slack-desktop.git
cd slack-desktop
makepkg -sir
cd "${prev_dir}"
