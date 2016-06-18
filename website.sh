#!/bin/sh
set -eu
. ./config

# sets up everything to start hacking on Rigs of Rods' website (rigsofrods.org)
# Important: Create a fork of https://github.com/RigsOfRods/rigsofrods.org
# then change YOUR_GITHUB_USERNAME to your Github username
# For further information on how to hack on the website see README.adoc and CONTRIBUTING.adoc in the site's repository


YOUR_GITHUB_USERNAME="Hiradur"

sudo apt-get install build-essential git ruby ruby-dev po4a gettext zlib1g-dev nodejs
sudo gem install bundler

# Initialization
if [ ! -e "$ROR_SOURCE_DIR" ]; then
  mkdir -p "$ROR_SOURCE_DIR"
fi

cd $ROR_SOURCE_DIR
if [ ! -e "rigsofrods.org" ]; then
  git clone https://github.com/${YOUR_GITHUB_USERNAME}/rigsofrods.org
fi
cd rigsofrods.github.io
sudo bundle install

make build

echo "$(tput setaf 2)Success! You can now start working on the website in $ROR_SOURCE_DIR/rigsofrods.org(tput sgr 0)"
 