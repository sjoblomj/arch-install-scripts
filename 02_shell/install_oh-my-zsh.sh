#!/bin/bash

sudo pacman -S --needed zsh zsh-completions
if [[ -z $ZSH ]]; then
  sudo chsh -s $(which zsh) # Change default shell for root user
  chsh -s $(which zsh)      # Change default shell for normal user

  sudo pacman -S --needed curl
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

  iconpath='.local/share/icons/hicolor/64x64/actions'
  mkdir -p "$HOME/$iconpath"
  cp {success,fail}.png "$HOME/$iconpath"

  if ! grep -sq "bgnotify_formatted" $HOME/.zshrc ; then
    plugins="git bgnotify sudo"
    # Use the bgnotify custom command from the bgnotify readme, but modify it
    bgnotify_func=$(cat $HOME/.oh-my-zsh/plugins/bgnotify/README.md | awk 'BEGIN{In_function = 0}{if ($0 == "function bgnotify_formatted {") In_function = 1; if (In_function) print $0; if ($0 == "}") In_function = 0}' | sed "s|Holy Smokes Batman|Great success|; s|Holy Graf Zeppelin|Command failed|; s|\$HOME/icons|\$HOME/$iconpath|g")

    awk -v plugins="$plugins" -v bgnotify_func="${bgnotify_func}" -i inplace '{if ($0 ~ /^plugins=(.*)$/) print bgnotify_func "\nplugins=(" plugins ")"; else print $0}' $HOME/.zshrc
  fi

  if [! -f $HOME/.zshaliases ] ; then
    echo "alias l='ls -la'" >> $HOME/.zshaliases
    echo "alias ll='ls -la'" >> $HOME/.zshaliases
    echo "alias weather='curl wttr.in\?M'" >> $HOME/.zshaliases
    echo "alias distory='vim $HOME/.zsh_history'" >> $HOME/.zshaliases
  fi
  if ! grep -sq "source \$HOME/.zshaliases" $HOME/.zshrc ; then
    echo "source \$HOME/.zshaliases" >> $HOME/.zshrc
  fi
fi
