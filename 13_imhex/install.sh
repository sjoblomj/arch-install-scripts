#!/bin/bash

mkdir -p $HOME/bin
prevdir=$(pwd)
cd $HOME/bin
if [ ! -d ImHex ]; then
    git clone https://github.com/WerWolv/ImHex --recurse-submodules
    cd ImHex

    sudo pacman -S ccache
    sudo ./dist/get_deps_archlinux.sh

    mkdir -p build
    cd build
    CC=gcc CXX=g++ cmake                          \
        -DCMAKE_BUILD_TYPE=Release                \
        -DCMAKE_INSTALL_PREFIX="/usr" 	          \
        -DCMAKE_C_COMPILER_LAUNCHER=ccache        \
        -DCMAKE_CXX_COMPILER_LAUNCHER=ccache      \
        -DCMAKE_C_FLAGS="-fuse-ld=lld"            \
        -DCMAKE_CXX_FLAGS="-fuse-ld=lld"          \
        -DCMAKE_OBJC_COMPILER_LAUNCHER=ccache     \
        -DCMAKE_OBJCXX_COMPILER_LAUNCHER=ccache   \
        ..
    sudo make -j 4 install
fi
cd $prevdir
