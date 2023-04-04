#!/bin/bash

title="Install Games and configure them?"
alt1="Install Zelda and Gamepad config"
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
	    ./zelda.sh
	else
	    exit 0
	fi
done
