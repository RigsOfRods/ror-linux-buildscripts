#!/bin/sh
set -eu

# Precompiled dependencies
sudo apt-get update
sudo apt-get install -y curl python
curl -sLf 'https://dl.cloudsmith.io/public/rigs-of-rods/rigs-of-rods/cfg/install/bash.deb.sh' | sudo bash
sudo apt-get -q install build-essential wget git wget cmake pkg-config python3 \
libogre-1.9-dev libmygui-dev libmygui.ogreplatform0debian1v5 libopenal-dev \
libcurl4-openssl-dev libgtk2.0-dev libois-dev libssl-dev libwxgtk3.0-dev \
libssl-dev libcurl4-openssl-dev libgtk2.0-dev libwxgtk3.0-dev \
angelscript pagedgeometry socketw


echo "$(tput setaf 2)All dependencies were installed successfully"
echo "You can now proceed with game.sh$(tput sgr 0)"
