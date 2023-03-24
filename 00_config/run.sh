#!/bin/bash

title="Update system configuration?"
alt1="Add keybindings to Openbox (Will cause screen to flicker)"
alt2="Change screen resolution (Opening external program)"
esc="Cancel"
alts="${alt1}\n${alt2}\n${esc}"

while true; do
	if [ "${alts}" = "${esc}" ]; then
	    res="${esc}"
	else
	    res=$(printf "${alts}" | fzf --tac --margin=4 --border --border-label="${title}")
	fi


	if [ "${res}" = "${alt1}" ]; then
	    alts=$(echo "${alts}" | sed "s/\\${alt1}\\\\n//g")
	    ./add_keybindings.sh
	elif [ "${res}" = "${alt2}" ]; then
	    alts=$(echo "${alts}" | sed "s/\\${alt2}\\\\n//g")
	    ./change_resolution.sh
	else
	    exit 0
	fi
done
