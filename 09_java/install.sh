#!/bin/bash

programs="$@"

if [[ "$programs" =~ "mvntree" ]]; then
    prevdir=$(pwd)
    mkdir -p $HOME/code
    cd $HOME/code
    if [ ! -d mvntree ]; then
        git clone https://github.com/sjoblomj/mvntree.git
        echo 'source $HOME/code/mvntree/.mvntree' >> .zshrc
    fi
    cd "$prevdir"
    programs=$(echo "${programs}" | sed "s/mvntree//g")
fi

if [[ "$programs" =~ "maven" ]]; then
    alias="alias mci='mvn clean install'"
    if ! grep -sq "$alias" $HOME/.zshaliases ; then
        echo "${alias}" >> $HOME/.zshaliases
    fi
fi

sudo pacman -S --needed ${programs}
