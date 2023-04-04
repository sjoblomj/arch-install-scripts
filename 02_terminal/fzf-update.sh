#!/bin/bash

olddir=$(pwd)

perform_update() {
    cd $HOME/bin/fzf
    ./install
}

write_config_file_data() {
    printf "%s\n" "$(date +%s)" > $HOME/.config/fzf/fzf.lastupdated
}
read_config_file_data() {
    if test -f "$HOME/.config/fzf/fzf.lastupdated"; then
        echo $(cat $HOME/.config/fzf/fzf.lastupdated)
    else
        echo 0
    fi
}
is_time_to_check_update() {
    last_check=$(read_config_file_data)
    seconds_in_day=86400
    next_update=$((last_check + seconds_in_day))
    if [ "$next_update" -gt "$(date +%s)" ]; then
        echo 1
    else
        echo 0
    fi
}
get_fzf_revision_number() {
    echo $(git rev-parse HEAD)
}

check_if_fzf_was_updated() {
    cd $HOME/bin/fzf
    oldref=$(get_fzf_revision_number)
    git pull 1>/dev/null
    ref=$(get_fzf_revision_number)
    if [ "$ref" != "$oldref" ]; then
        return 0
    fi
    return 1
}

if [ $(is_time_to_check_update) -eq 0 ]; then
    read -q "REPLY?Check for fzf updates and apply if present? (y/n)"
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        : # Do nothing
    else
        if $(check_if_fzf_was_updated) ; then
            $(perform_update)
            echo "Updated and applied fzf updates"
        else
            echo "No fzf updates available"
        fi
    fi
    $(write_config_file_data)
fi

cd "$olddir"
