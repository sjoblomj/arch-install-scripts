#!/bin/bash
sudo pacman -S --needed git vim
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
cp 05_vim/my_configs ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

