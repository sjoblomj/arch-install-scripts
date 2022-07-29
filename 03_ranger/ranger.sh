#!/bin/bash

sudo pacman --needed -S ranger ffmpegthumbnailer curl

pip3 install ueberzug # For previewing images
# Use faster libraries for previewing images
pip3 uninstall -y pillow
CC="cc -maxv2" pip3 install -U --force-reinstall pillow-simd

ranger --copy-config=rc
sed -i "s|set show_hidden false|set show_hidden true|g" ~/.config/ranger/rc.conf
sed -i "s|set preview_images false|set preview_images true|g" ~/.config/ranger/rc.conf
sed -i "s|set preview_images_method .*|set preview_images_method ueberzug|g" ~/.config/ranger/rc.conf
sed -i "s|#set preview_script |set preview_script |g" ~/.config/ranger/rc.conf

# Download latest Rifle config. In Ranger <= 1.9.3, viewnior is not configured, but it is in the upstream source.
curl -so ~/.config/ranger/rifle.conf https://raw.githubusercontent.com/ranger/ranger/master/ranger/config/rifle.conf

# Enable video previewing
ranger --copy-config=scope
awk 'BEGIN{found_video = 0} {if ($0 ~ " *## Video$") found_video = 1; else if ($0 !~ ".*#.*") found_video = 0; if (found_video) sub("# ", "", $0); print $0;}' ~/.config/ranger/scope.sh > ~/.config/ranger/tmp.sh && mv ~/.config/ranger/tmp.sh ~/.config/ranger/scope.sh && chmod +x ~/.config/ranger/scope.sh
