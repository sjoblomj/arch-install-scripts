#!/bin/bash

title="Install terminal and config?"
alt1="Install and configure Terminator (terminal)"
alt2="Configure fzf"
alt3="Install humanlog (log prettifier)"
esc="Cancel"
alts="${alt1}\n${alt2}\n${alt3}\n${esc}"

while true; do
	if [ "${alts}" = "${esc}" ]; then
		res="${esc}"
	else
		res=$(printf "${alts}" | fzf --tac --margin=4 --border --border-label="${title}")
	fi


	if [ "${res}" = "${alt1}" ]; then
		alts=$(echo "${alts}" | sed "s/\\${alt1}\\\\n//g")
		./install_terminator.sh
	elif [ "${res}" = "${alt2}" ]; then
		alts=$(echo "${alts}" | sed "s/\\${alt2}\\\\n//g")
		./configure_fzf.sh
	elif [ "${res}" = "${alt3}" ]; then
		alts=$(echo "${alts}" | sed "s/\\${alt3}\\\\n//g")
		./install_humanlog.sh
	else
		exit 0
	fi
done
