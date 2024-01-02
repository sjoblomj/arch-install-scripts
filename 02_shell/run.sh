#!/bin/bash

title="Install zsh (Terminal shell) and config?"
alt1="Install zsh and configure oh-my-zsh (zsh config)"
esc="Cancel"
alts="${alt1}\n${esc}"

while true; do
	if [ "${alts}" = "${esc}" ]; then
		res="${esc}"
	else
		res=$(printf "${alts}" | fzf --tac --margin=4 --border --border-label="${title}")
	fi


	if [ "${res}" = "${alt1}" ]; then
		alts=$(echo "${alts}" | sed "s/\\${alt1}\\\\n//g")
		./install_oh-my-zsh.sh
	else
		exit 0
	fi
done
