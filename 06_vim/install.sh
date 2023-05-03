#!/bin/bash
sudo pacman -S --needed git vim
git clone --depth=1 https://github.com/amix/vimrc.git $HOME/.vim_runtime
cp my_configs.vim $HOME/.vim_runtime
sh $HOME/.vim_runtime/install_awesome_vimrc.sh
