#!/bin/bash

mkdir -p $HOME/.config/fzf
cp fzf-update.sh $HOME/.config/fzf

if [ -f $HOME/.fzf.bash ] && [ ! -f $HOME/.fzf.zsh ]; then
    mv $HOME/.fzf.bash $HOME/.fzf.zsh
    sed -i 's/.bash"$/.zsh"/g' $HOME/.fzf.zsh
fi
if ! grep -sq ".fzf.zsh" $HOME/.zshrc ; then
    echo '[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh' >> $HOME/.zshrc
fi
if ! grep -sq "fzf-update.sh" $HOME/.zshrc ; then
    echo 'source $HOME/.config/fzf/fzf-update.sh' >> $HOME/.zshrc
fi
