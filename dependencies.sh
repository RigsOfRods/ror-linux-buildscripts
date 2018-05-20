#!/bin/sh
set -eu
. ./config

# Precompiled dependencies
sudo apt-get update
sudo apt-get -q install build-essential git cmake pkg-config libboost-all-dev mercurial \
libfreetype6-dev libfreeimage-dev libzzip-dev libois-dev \
libgl1-mesa-dev libglu1-mesa-dev nvidia-cg-toolkit libopenal-dev  \
libx11-dev libxt-dev libxaw7-dev libxrandr-dev \
libssl-dev libcurl4-openssl-dev libgtk2.0-dev libwxgtk3.0-dev \
libasound2-dev libpulse-dev wget

# Initialization
if [ ! -e "$ROR_SOURCE_DIR" ]; then
  mkdir -p "$ROR_SOURCE_DIR"
fi

cd "$ROR_SOURCE_DIR"
if [ ! -e ror-dependencies ]; then
  git clone https://github.com/${YOUR_GITHUB_USERNAME}/ror-dependencies.git
fi
cd ror-dependencies
git pull

cmake -DBUILD_CAELUM=OFF .
make $ROR_MAKEOPTS

echo "$(tput setaf 2)All dependencies were installed and build successfully."
echo "You can now proceed with game.sh$(tput sgr 0)"
