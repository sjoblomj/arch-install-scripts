#!/bin/bash
product_code="$1"
product_dir="$2"
if [ ! -d $HOME/bin/${product_dir}-* ]; then
    sudo pacman -S --needed curl tar
    curl -L "https://download.jetbrains.com/product?code=${product_code}&latest&distribution=linux" -o "${product_code}.tar.gz"

    mkdir -p $HOME/bin
    tar xvf "${product_code}.tar.gz" --directory=$HOME/bin
    rm "${product_code}.tar.gz"

    datadir=$HOME/.config/JetBrains/$(grep -Po "\"dataDirectoryName\": \"\K.+(?=\",)" $HOME/bin/${product_dir}-*/product-info.json)
    mkdir -p "$datadir/options/linux"
    mkdir -p "$datadir/keymaps"

    cp options_editor.xml "$datadir/options/editor.xml"
    cp options_editor-font.xml "$datadir/options/editor-font.xml"
    cp options_keymapFlags.xml "$datadir/options/keymapFlags.xml"
    cp options_linux_keymap.xml "$datadir/options/linux/keymap.xml"
    cp syzygy.xml "$datadir/keymaps"
fi
