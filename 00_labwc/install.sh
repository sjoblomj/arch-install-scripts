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
mkdir -p $HOME/.config/labwc
cd $HOME/code/arch-install-scripts/00_labwc
cp autostart environment menu.xml rc.xml $HOME/.config/labwc


# Status bar
sudo pacman -S --needed otf-font-awesome waybar
mkdir -p $HOME/.config/waybar


# Screen brightness control
sudo pacman -S --needed brightnessctl


# Volume settings
sudo pacman -S --needed pavucontrol


# Locale for calendar
./add_locales.sh


# Application launcher
sudo pacman -S --needed fuzzel


# Wallpaper
sudo pacman -S --needed curl
sudo pacman -S --needed swaybg
curl https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Expl0393_-_Flickr_-_NOAA_Photo_Library.jpg/800px-Expl0393_-_Flickr_-_NOAA_Photo_Library.jpg -o $HOME/.config/background.jpg


# Extra fonts
sudo pacman -S --needed ttf-fira-code


# Terminal clipboard util
sudo pacman -S --needed wl-clipboard


# Screenshot tools
sudo pacman -S --needed grim slurp swappy


# Screen locking
sudo pacman -S --needed swaylock swayidle
git clone https://git.sr.ht/\~emersion/chayang $HOME/bin/chayang
cd $HOME/bin/chayang
meson setup build/
ninja -C build/
sudo cp build/chayang /usr/local/bin/
git clone https://git.sr.ht/\~leon_plickat/wlopm $HOME/bin/wlopm
cd $HOME/bin/wlopm
make
sudo make install


# Notifications
sudo pacman -S --needed mako
mkdir -p $HOME/.config/mako
cp mako_config $HOME/.config/mako/config
