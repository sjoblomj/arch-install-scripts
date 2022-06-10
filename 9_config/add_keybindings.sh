#!/bin/bash
targetfile="$HOME/.config/openbox/rc.xml"
if [ -f $targetfile ] && ! grep -q "keybind key=\"S-A-Tab\"" $targetfile ; then
	awk -i inplace '
	{
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

	openbox --restart
fi

