#!/bin/bash

olddir=$(pwd)

perform_update() {
    cd $HOME/bin/arkenfox/user.js
    cp user-overrides.js prefsCleaner.sh updater.sh $HOME/.mozilla/firefox/*.default-release
    cd $HOME/.mozilla/firefox/*.default-release
    ./updater.sh -s 1>/dev/null
    ./prefsCleaner.sh -s 1>/dev/null
    rm updater.sh prefsCleaner.sh user-overrides.js
}

write_config_file_data() {
    cd $HOME/bin/arkenfox/user.js
    printf "%s;%s\n" "$(get_firefox_version_number)" "$(get_arkenfox_version_number)" > $HOME/.config/arkenfox/arkenfox.lastupdated
}
read_config_file_data() {
    if test -f "$HOME/.config/arkenfox/arkenfox.lastupdated"; then
        echo $(cat $HOME/.config/arkenfox/arkenfox.lastupdated)
    fi
    echo ""
}
get_last_updated_firefox_version() {
    update_info=$(read_config_file_data)
    echo ${update_info%%;*}
}
get_last_updated_arkenfox_version() {
    update_info=$(read_config_file_data)
    echo ${update_info##*;}
}
get_firefox_version_number() {
    echo $(firefox --version)
}
get_arkenfox_version_number() {
    echo $(git rev-parse HEAD)
}
is_firefox_running() {
    ps -e | grep firefox 1>/dev/null
    echo $?
}

check_if_arkenfox_was_updated() {
    cd $HOME/bin/arkenfox/user.js
    git pull 1>/dev/null
    prev_arkenfox_update=$(get_last_updated_arkenfox_version)
    ref=$(get_arkenfox_version_number)
    if [ "$ref" != "$prev_arkenfox_update" ]; then
        return 0
    fi
    return 1
}

if [ $(is_firefox_running) -eq 1 ]; then
    if [ "$(get_last_updated_firefox_version)" != "$(get_firefox_version_number)" ]; then
        read -q "REPLY?Check for Arkenfox updates and apply if present? (y/n)"
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            : # Do nothing
        else
            if $(check_if_arkenfox_was_updated) ; then
                $(perform_update)
                $(write_config_file_data)
                echo "Updated and applied Arkenfox updates"
            else
                echo "No Arkenfox updates available"
            fi
        fi
    fi
fi

cd "$olddir"
