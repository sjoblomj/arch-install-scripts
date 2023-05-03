#!/bin/bash

mkdir -p $HOME/.config/fzf
cp fzf-update.sh $HOME/.config/fzf

if ! grep -sq "fzf-update.sh" $HOME/.zshrc ; then
    echo 'source $HOME/.config/fzf/fzf-update.sh' >> $HOME/.zshrc
fi
