#!/bin/sh
set -eu
. ./config

# Precompiled dependencies
sudo apt-get update
sudo apt-get -q install build-essential git cmake ninja-build python3-pip

echo "$(tput setaf 2)All dependencies were installed and built successfully."
echo "You can now proceed with game.sh$(tput sgr 0)"
