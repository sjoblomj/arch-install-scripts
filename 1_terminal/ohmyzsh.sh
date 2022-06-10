#!/bin/bash
sudo pacman -S --needed curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Modify bgnotify plugin to take icon command
sed -i "s/notify-send \"\$1\" \"\$2\"/notify-send \"\$1\" \"\$2\" --icon=\"\$3\"/g" ~/.oh-my-zsh/plugins/bgnotify/bgnotify.plugin.zsh

plugins="git bgnotify sudo"
# Set bgnotify custom command and enable more plugins
sed -i "s/^plugins=(.*)/function bgnotify_formatted {\n  ## \$1=exit_status, \$2=command, \$3=elapsed_time\n  [ \$1 -eq 0 ] \&\& title=\"Great success\" || title=\"Command failed\"\n  [ \$1 -eq 0 ] \&\& icon=\"\~\/code\/arch-install-scripts\/2_terminal\/success.png\" || icon=\"\~\/code\/arch-install-scripts\/2_terminal\/fail.png\"\n  bgnotify \"\$title - took \${3}s\" \"\$2\" \"\$icon\";\n}\nplugins=($plugins)/g" ~/.zshrc
