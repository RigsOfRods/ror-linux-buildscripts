#!/bin/sh
set -eu
. ./config

# Install the newest version of cmake on ubuntu 16 and 18
setup_apt_kitware()
{
  sudo apt-get update
  sudo apt-get install apt-transport-https ca-certificates gnupg software-properties-common wget -y
  wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | sudo apt-key add -
}

if [ "$(grep -oP 'VERSION_ID="\K[\d]+' /etc/os-release)" = "16" ]
then
  setup_apt_kitware
  sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ xenial main'
elif [ "$(grep -oP 'VERSION_ID="\K[\d]+' /etc/os-release)" = "18" ]
then
  setup_apt_kitware
  sudo apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main' -y
fi


# Build dependencies
sudo apt-get update
sudo apt-get -q install build-essential git cmake ninja-build python3-pip

echo "$(tput setaf 2)All dependencies were installed and built successfully."
echo "You can now proceed with game.sh$(tput sgr 0)"