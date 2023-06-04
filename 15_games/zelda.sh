#!/bin/bash

prevdir=$(pwd)

cd $HOME/bin
if [ ! -d qjoypad ]; then
    git clone https://github.com/panzi/qjoypad
    mkdir -p qjoypad/build
    cd qjoypad/build
    sudo pacman -S --needed qt5-tools
    cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release
    make -j`nproc`
    sudo make install
    cd $prevdir
    mkdir -p $HOME/.config/qjoypad4
    cp snes.lyt $HOME/.config/qjoypad4
fi
cd $prevdir

if [ ! -d $HOME/games/zelda-a_link_to_the_past ]; then
    sudo pacman -S --needed unzip
    echo ""
    echo "Enter password to unzip the Zelda ROM"
    unzip zelda3.zip
    mkdir -p $HOME/games/zelda-a_link_to_the_past
    mv zelda3.sfc $HOME/games/zelda-a_link_to_the_past
    cd $HOME/games/zelda-a_link_to_the_past
    git clone https://github.com/snesrev/zelda3
    mv zelda3.sfc zelda3/tables
    cd zelda3
    python3 -m ensurepip
    python3 -m pip install -r requirements.txt
    sudo pacman -S --needed sdl2
    make

    sed -i "s/^Autosave = 0/Autosave = 1/" $HOME/games/zelda-a_link_to_the_past/zelda3/zelda3.ini
    sed -i "s/^Fullscreen = 0/Fullscreen = 1/" $HOME/games/zelda-a_link_to_the_past/zelda3/zelda3.ini
    sed -i "s/^TurnWhileDashing = 0/TurnWhileDashing = 1/" $HOME/games/zelda-a_link_to_the_past/zelda3/zelda3.ini
    sed -i "s/^SkipIntroOnKeypress = 0/SkipIntroOnKeypress = 1/" $HOME/games/zelda-a_link_to_the_past/zelda3/zelda3.ini
    sed -i "s/^MiscBugFixes = 0/MiscBugFixes = 1/" $HOME/games/zelda-a_link_to_the_past/zelda3/zelda3.ini
    sed -i "s/^GameChangingBugFixes = 0/GameChangingBugFixes = 1/" $HOME/games/zelda-a_link_to_the_past/zelda3/zelda3.ini
    sed -i "s/^CancelBirdTravel = 0/CancelBirdTravel = 1/" $HOME/games/zelda-a_link_to_the_past/zelda3/zelda3.ini
    sed -i "s/^Controls = /#Controls = /" $HOME/games/zelda-a_link_to_the_past/zelda3/zelda3.ini
    sed -i "s/^# This default is suitable for QWERTY keyboards/# This default is suitable for the joypad\r\nControls = Up, Down, Left, Right, c, s, a, b, x, y, l, r\r\n\r\n# This default is suitable for QWERTY keyboards/" $HOME/games/zelda-a_link_to_the_past/zelda3/zelda3.ini
fi
cd $prevdir
