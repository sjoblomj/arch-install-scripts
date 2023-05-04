#!/bin/bash
restartob=0
targetfile="$HOME/.config/openbox/rc.xml"
if [ -f $targetfile ] && ! grep -q "keybind key=\"S-A-Tab\"" $targetfile ; then
	awk -i inplace '
	{
		if ($0 ~ "keybind key=\"S-A-Return\"") {
			gsub("C-space", "W-Return", $0);
		}
		 if ($0 ~ "keybind key=\"C-space\"") {
			gsub("C-space", "C-A-space", $0);
		}
		if ($0 ~ "keybind key=\"A-Tab\"") {
			print "    <keybind key=\"S-A-Tab\">";
			print "      <action name=\"PreviousWindow\">";
			print "        <allDesktops>yes</allDesktops>";
			print "        <raise>yes</raise>";
			print "        <finalactions>";
			print "          <action name=\"Focus\"/>";
			print "          <action name=\"UnshadeRaise\"/>";
			print "        </finalactions>";
			print "      </action>";
			print "    </keybind>";
		}
		print $0;
	}' $targetfile

	restartob=1
fi

targetfile="$HOME/.config/openbox/menu.xml"
if [ -f $targetfile ] && ! grep -q "Run program..." $targetfile ; then
	awk -i inplace '
	{
		if ($0 ~ "<separator label=\"ArchLabs\"/>") {
			print "    <separator label=\"ArchLabs\"/>";
			print "    <item label=\"Run program...\">";
			print "      <action name=\"Execute\">";
			print "        <command>rofi -show drun</command>";
			print "      </action>";
			print "    </item>";
		} else {
			print $0;
		}
	}' $targetfile

	restartob=1
fi

if [ $restartob == 1 ]; then
	openbox --restart
fi
