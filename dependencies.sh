#!/bin/sh
set -eu
. ./config

# Precompiled dependencies
sudo apt-get update
sudo apt-get -q install build-essential git cmake pkg-config libboost-all-dev ninja-build \
libfreetype6-dev libfreeimage-dev libzzip-dev libois-dev \
libgl1-mesa-dev libglu1-mesa-dev nvidia-cg-toolkit libopenal-dev  \
libx11-dev libxt-dev libxaw7-dev libxrandr-dev \
libssl-dev libcurl4-openssl-dev libgtk2.0-dev libwxgtk3.0-dev \
libasound2-dev libpulse-dev wget python3-pip

# Conan
cd /tmp/
sudo wget -nv https://dl.bintray.com/conan/installers/conan-ubuntu-64_1_13_1.deb

sudo dpkg -i conan-ubuntu-64_1_13_1.deb

conan user

conan remote add ror-dependencies https://api.bintray.com/conan/anotherfoxguy/ror-dependencies
conan remote add bincrafters-public-conan https://api.bintray.com/conan/bincrafters/public-conan

echo "$(tput setaf 2)All dependencies were installed and built successfully."
echo "You can now proceed with game.sh$(tput sgr 0)"
