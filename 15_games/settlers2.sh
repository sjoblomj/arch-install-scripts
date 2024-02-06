#!/bin/bash

if [ ! -d $HOME/games/settlers2 ]; then
    mkdir -p $HOME/games/settlers2

    sudo pacman -S --needed unzip
    sudo pacman -S --needed sdl2 sdl2_mixer
    url=$(curl -s https://www.siedler25.org/index.php\?com\=dynamic\&mod\=2\&lang\=en\&PHPSESSID\=li5ljhjjcqeu02md0k5a1ivqhm | awk 'BEGIN{Found_stable = 0}{if ($0 ~ "Current Stable Version") Found_stable = 1; if ($0 ~ "a href=\"https" && $0 ~ "linux") { gsub(/.*a href="/, "", $0); gsub(/".*/, "", $0); print $0; exit 0;}}')
    if [ -z "$url" ]; then
        echo "Failed to fetch URL to download from!"
        return 1
    fi
    curl "$url" -o /tmp/rttr.tar.bz2
    tar xf /tmp/rttr.tar.bz2 --strip-components=1 --directory=$HOME/games/settlers2
    rm /tmp/rttr.tar.bz2
    echo ""
    echo "Enter password to unzip Settlers II"
    unzip s2g.zip -d $HOME/games/settlers2/share/s25rttr/S2
fi
