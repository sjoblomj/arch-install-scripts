#!/bin/zsh

sudo pacman -S --needed python python-pip cmake sdl2 sdl2_mixer sdl2_image lua51 tolua++ libtheora libvorbis libogg libmng libpng zlib lldb gdb
prevdir=$(pwd)
mkdir -p $HOME/games
cd $HOME/games
if [ ! -d stratagus ]; then
    git clone https://github.com/Wargus/stratagus.git
    cd stratagus
    cmake CMakeLists.txt
    make
fi

cd $HOME/games
if [ ! -d wargus ]; then
    git clone https://github.com/Wargus/wargus.git
    cd wargus
    cmake CMakeLists.txt -DSTRATAGUS=../stratagus -DSTRATAGUS_INCLUDE_DIR="../stratagus/gameheaders"
    make
fi

if [ ! -d $HOME/.local/share/stratagus/data.Wargus ]; then
    read -q "REPLY?Do you have your WarCraft II files ready to be extracted by Wargus? (y/n)"
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Just rerun this script when you want to extract the WarCraft data files"
        exit 0
    else
        cd $HOME/games/wargus
        ./wargus
    fi
fi


# Convert MIDI files to WAV manually
sudo pacman -S --needed timidity++ fluidsynth
if ! grep -sq "soundfont /usr/share/soundfonts/FluidR3_GM.sf2" /etc/timidity/timidity.cfg ; then
    sudo sed -i -r "s|^# soundfont (.*)|# soundfont \1\nsoundfont /usr/share/soundfonts/FluidR3_GM.sf2|" /etc/timidity/timidity.cfg
fi

if ! ls $HOME/.local/share/stratagus/data.Wargus/music/*.wav &> /dev/null ; then
    echo "Converting MIDI files to WAV"
    cd $HOME/.local/share/stratagus/data.Wargus/music
    find . -exec timidity --output-mode=w --output-file={}.wav {} \;
    for file in *.mid.wav; do
        mv -- "$file" "${file%.mid.wav}.wav"
    done
fi

cd $prevdir
