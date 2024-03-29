#!/bin/bash

title="Install and configure vimrc (tweaked vim)?"
alt1="Yes, install vimrc"
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
	    ./install.sh
	else
	    exit 0
	fi
done
