#!/bin/bash
targetfile="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml/displays.xml"
resolution="2047x1152"
if [ -f $targetfile ]; then
	sed -iE "s|<property name=\"Resolution\" type=\"string\" value=\".*\"/>|<property name=\"Resolution\" type=\"string\" value=\"$resolution\"/>|g" $targetfile
fi

