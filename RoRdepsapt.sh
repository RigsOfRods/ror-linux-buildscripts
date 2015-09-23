#!/bin/sh

#Precompiled dependencies
sudo apt-get update
sudo apt-get -q install build-essential git cmake pkg-config libboost-all-dev mercurial \
libfreetype6-dev libfreeimage-dev libzzip-dev libois-dev \
libgl1-mesa-dev libglu1-mesa-dev nvidia-cg-toolkit libopenal-dev  \
libx11-dev libxt-dev libxaw7-dev libxrandr-dev \
libssl-dev libcurl4-openssl-dev libgtk2.0-dev libwxgtk3.0-dev \
libasound2-dev libpulse-dev wget

echo "$(tput setaf 1)All apt dependencies installed."
echo "You can now proceed with RoRdeps.sh(tput sgr 0)"