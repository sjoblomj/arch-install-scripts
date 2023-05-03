#!/bin/bash

sudo pacman-key --init
sudo pacman-key --populate archlinux

sudo pacman -Suy
sudo pacman -S --needed git

mkdir -p $HOME/bin/fzf
git clone https://github.com/junegunn/fzf.git $HOME/bin/fzf
cd $HOME/bin/fzf
./install
source $HOME/.fzf.zsh

mkdir -p $HOME/code/arch-install-scripts
git clone https://github.com/sjoblomj/arch-install-scripts $HOME/code/arch-install-scripts
cd $HOME/code/arch-install-scripts

./find_scripts.sh
