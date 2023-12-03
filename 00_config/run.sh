#!/bin/bash
mkdir -p $HOME/bin
mkdir -p $HOME/.config

# labwc
alt1="Yes, install Xwayland"
alt2="No, don't install Xwayland"
xwayland="-Dxwayland=disabled"
res=$(printf "${alt1}\n${alt2}" | fzf --tac --margin=4 --border --border-label="Install Xwayland?"  --header='
Wayland is the replacement of the X Window System, but not all applications are Wayland ready.
Xwayland acts as a workaround, allowing X programs to continue to work under Wayland.
Xwayland is a complete X11 server, just like Xorg is, but instead of driving the displays and
opening input devices, it acts as a Wayland client. Notable programs that do not work without
Xwayland are GIMP 2.x and the Jetbrains IDEs (https://youtrack.jetbrains.com/issue/JBR-3206)')
if [ "${res}" = "${alt1}" ]; then
    xwayland=""
    sudo pacman -S --needed xorg-xwayland
fi

sudo pacman -S --needed git jq
sudo pacman -S --needed wlroots wayland libinput libxkbcommon libxml2 cairo pango glib2
sudo pacman -S --needed meson ninja gcc wayland-protocols
sudo pacman -S --needed polkit

download_latest_release_from_github() {
    local githubrepo="$1"
    local extract_path="$2"
    local archive_directory_depth="$3"

    local path=""
    local latestreleasedata=""
    local latestreleasename=""
    local tmpfile=""

    latestreleasedata=$(curl -sL \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      "https://api.github.com/repos/$githubrepo/releases" | \
      jq '[.[] | select(.prerelease == false)][0] | {name, tarball_url}')

    tmpfile=$(mktemp)
    latestreleasename=$(echo "$latestreleasedata" | jq -r '.name')
    path="$extract_path/$latestreleasename"

    mkdir -p "$path"
    curl -L $(echo "$latestreleasedata" | jq -r '.tarball_url') -o "$tmpfile"
    tar xvf "$tmpfile" --directory="$path" --strip-components="$archive_directory_depth" &> /dev/null
    rm "$tmpfile"
    echo "$path"
}

labwc_path=$(download_latest_release_from_github "labwc/labwc" "$HOME/bin/labwc" 1)

cd "$labwc_path"
meson setup "${xwayland}" build/
meson compile -C build/
mkdir -p $HOME/.config/labwc
cd $HOME/code/arch-install-scripts/00_config
cp autostart environment menu.xml rc.xml themerc-override $HOME/.config/labwc
cp .zprofile $HOME/
sed -i "s|./bin/labwc/build/labwc|./bin/labwc/build/labwc|.$labwc_path/build/labwc" $HOME/.zprofile


# Status bar
sudo pacman -S --needed waybar
mkdir -p $HOME/.config/waybar
cp waybar_config $HOME/.config/waybar/config
cp waybar_style.css $HOME/.config/waybar/style.css


# Screen brightness control
sudo pacman -S --needed brightnessctl


# Volume settings
sudo pacman -S --needed curl
sudo pacman -S --needed pavucontrol
mkdir -p $HOME/.local/share/icons/hicolor/scalable/apps
curl https://upload.wikimedia.org/wikipedia/commons/4/44/Gnome-multimedia-volume-control.svg -o $HOME/.local/share/icons/hicolor/scalable/apps/multimedia-volume-control.svg


# Locale for calendar
./add_locales.sh


# Application launcher
sudo pacman -S --needed fuzzel
mkdir -p $HOME/.config/fuzzel
cp fuzzel_config $HOME/.config/fuzzel/fuzzel.ini


# Wallpaper
sudo pacman -S --needed swaybg
curl https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Expl0393_-_Flickr_-_NOAA_Photo_Library.jpg/800px-Expl0393_-_Flickr_-_NOAA_Photo_Library.jpg -o $HOME/.config/background.jpg


# Extra fonts
sudo pacman -S --needed otf-font-awesome cantarell-fonts adobe-source-code-pro-fonts ttf-dejavu ttf-liberation noto-fonts ttf-fira-code


# Terminal clipboard util
sudo pacman -S --needed wl-clipboard


# Screenshot tools
sudo pacman -S --needed grim slurp swappy


# Notifications
sudo pacman -S --needed mako
mkdir -p $HOME/.config/mako
cp mako_config $HOME/.config/mako/config


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


# Mouse speed
# Can be set **for all devices** by installing libinput-config
# from https://gitlab.com/warningnonpotablewater/libinput-config/
# and then setting
# echo "speed=2" | sudo tee /etc/libinput.conf
