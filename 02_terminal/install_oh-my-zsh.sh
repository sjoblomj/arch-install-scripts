#!/bin/bash

sudo pacman -S --needed zsh zsh-completions
sudo chsh -s $(which zsh) # Change default shell for root user
chsh -s $(which zsh)      # Change default shell for normal user

sudo pacman -S --needed curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Modify bgnotify plugin to take icon command
sed -i "s/notify-send \"\$1\" \"\$2\"$/notify-send \"\$1\" \"\$2\" --icon=\"\$3\"/g" $HOME/.oh-my-zsh/plugins/bgnotify/bgnotify.plugin.zsh
# Modify bgnotify plugin to not set bgnotify_termid
sed -i "s/^bgnotify_termid=/#bgnotify_termid=/" $HOME/.oh-my-zsh/plugins/bgnotify/bgnotify.plugin.zsh

if ! grep -sq "bgnotify_formatted" $HOME/.zshrc ; then
    plugins="git bgnotify sudo"
    # Set bgnotify custom command and enable more plugins
    sed -i "s/^plugins=(.*)/function bgnotify_formatted {\n  ## \$1=exit_status, \$2=command, \$3=elapsed_time\n  [ \$1 -eq 0 ] \&\& title=\"Great success\" || title=\"Command failed\"\n  [ \$1 -eq 0 ] \&\& icon=\"\$HOME\/code\/arch-install-scripts\/02_terminal\/success.png\" || icon=\"\$HOME\/code\/arch-install-scripts\/02_terminal\/fail.png\"\n  bgnotify \"\$title - took \${3}s\" \"\$2\" \"\$icon\";\n}\nplugins=($plugins)/g" $HOME/.zshrc
fi
