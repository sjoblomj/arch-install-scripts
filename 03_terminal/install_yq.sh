#!/bin/bash

sudo pacman -S --needed go jq

# Install
if [ ! -f $HOME/go/bin/yq ]; then
    go install github.com/mikefarah/yq/v4@latest
fi

# Add to PATH if not present
if grep -sq "^export PATH=.*go/bin.*" $HOME/.zshrc ; then
    : # Do nothing, already on the path
elif grep -sq "^export PATH=" $HOME/.zshrc ; then
    sed -i "s|^export PATH=|export PATH=$HOME/go/bin:|" $HOME/.zshrc
else
    echo "export PATH=$HOME/go/bin:\$PATH" >> $HOME/.zshrc
fi
