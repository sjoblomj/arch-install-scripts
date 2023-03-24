#!/bin/bash

sudo pacman -S --needed docker docker-compose
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo usermod -aG docker "${USER}"

alias="alias dc='docker-compose'"
if ! grep -sq "$alias" $HOME/.zshaliases ; then
    echo "${alias}" >> $HOME/.zshaliases
fi

alias="alias clean-docker='if [[ \$(docker ps -qa) ]]; then docker stop \$(docker ps -qa) ; docker rm \$(docker ps -qa) ; fi; if [[ \$(docker volume ls -qf dangling=true) ]]; then docker volume rm \$(docker volume ls -qf dangling=true); fi'"
if ! grep -sq "alias clean-docker=" $HOME/.zshaliases ; then
    echo "${alias}" >> $HOME/.zshaliases
fi
