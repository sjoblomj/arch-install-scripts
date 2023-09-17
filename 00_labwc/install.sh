#!/bin/bash
mkdir -p $HOME/bin
mkdir -p $HOME/.config

# labwc
sudo pacman -S --needed git
sudo pacman -S --needed wlroots wayland libinput libxkbcommon libxml2 cairo pango glib2
sudo pacman -S --needed meson ninja gcc wayland-protocols
git clone https://github.com/labwc/labwc.git $HOME/bin/labwc
cd $HOME/bin/labwc
meson setup build/
meson compile -C build/

# Status bar
sudo pacman -S --needed otf-font-awesome waybar

# Application launcher
sudo pacman -S --needed fuzzel

# Volume settings
sudo pacman -S --needed pavucontrol

# Wallpaper
sudo pacman -S --needed curl
sudo pacman -S --needed swaybg
curl https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Expl0393_-_Flickr_-_NOAA_Photo_Library.jpg/800px-Expl0393_-_Flickr_-_NOAA_Photo_Library.jpg -o $HOME/.config/background.jpg
