#!/bin/bash

prevdir=$(pwd)
sudo pacman -S --needed git base-devel meson ninja
mkdir -p $HOME/code
cd $HOME/code
git clone https://github.com/sjoblomj/Viewnior.git
cd Viewnior
meson --prefix=/usr builddir
cd builddir
ninja
sudo ninja install
cd "${prevdir}"
