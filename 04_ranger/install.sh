#!/bin/bash

sudo pacman --needed -S ranger ffmpegthumbnailer curl

sudo pacman --needed -S ueberzug # For previewing images
# Use faster libraries for previewing images
pip3 uninstall -y pillow
CC="cc -mavx2" pip3 install -U --force-reinstall pillow-simd

ranger --copy-config=rc
sed -i "s|set show_hidden false|set show_hidden true|g" $HOME/.config/ranger/rc.conf
sed -i "s|set preview_images false|set preview_images true|g" $HOME/.config/ranger/rc.conf
sed -i "s|set preview_images_method .*|set preview_images_method ueberzug|g" $HOME/.config/ranger/rc.conf
sed -i "s|#set preview_script |set preview_script |g" $HOME/.config/ranger/rc.conf

# Download latest Rifle config. In Ranger <= 1.9.3, viewnior is not configured, but it is in the upstream source.
curl -so $HOME/.config/ranger/rifle.conf https://raw.githubusercontent.com/ranger/ranger/master/ranger/config/rifle.conf

# Enable video previewing
ranger --copy-config=scope
awk 'BEGIN{found_video = 0} {if ($0 ~ " *## Video$") found_video = 1; else if ($0 !~ ".*#.*") found_video = 0; if (found_video) sub("# ", "", $0); print $0;}' $HOME/.config/ranger/scope.sh > $HOME/.config/ranger/tmp.sh && mv $HOME/.config/ranger/tmp.sh $HOME/.config/ranger/scope.sh && chmod +x $HOME/.config/ranger/scope.sh
