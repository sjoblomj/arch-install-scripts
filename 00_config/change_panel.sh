#!/bin/bash

# Configure panel position to be at the top
sed -i "s/^panel_position = .*/panel_position = top center horizontal/" $HOME/.config/tint2/tint2rc

# Configure clock to use ISO format
sed -i "s/^time1_format = .*/time1_format = %a %Y-%m-%d %H:%M/" $HOME/.config/tint2/tint2rc

# Add battery to panel if not present
sed -i -r "s/^panel_items = ([AC-Z]+)/panel_items = \1B/" $HOME/.config/tint2/tint2rc

# Make selected task have a more visible background
sed -i -r "s/^background_color = #212121 100/background_color = #fa6607 100/" $HOME/.config/tint2/tint2rc

# Set application menu to be at the top
sed -i -r "s/^menu_valign( *)=.*/menu_valign\1= top/" $HOME/.config/jgmenu/jgmenurc

# Increase application menu font size if needed
sed -i -r "s/^font( *)=(.*) (12px)/font\1=\2 16px/" $HOME/.config/jgmenu/jgmenurc

echo "Restarting tint2 ..."
al-tint2restart 2>&1 /dev/null
echo "Restarted tint2"
sleep 5
