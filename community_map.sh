#!/bin/sh

# This scripts downloads and updates the Community Map for RoR

set -eu
. ./config

# Change this to your GitHub username _if_ you want to help developing the map.
# Make sure you forked the RigsOfRods-Community/community-map repo before.
YOUR_GITHUB_USERNAME="RigsOfRods-Community"

# Clone repository
cd "$ROR_SOURCE_DIR"
if [ ! -e community-map ]; then
  git clone --depth 1 https://github.com/{$YOUR_GITHUB_USERNAME}/community-map
fi
cd community-map

# update map
git pull

# zip map
zip -r ../community-map.zip *

# move map to mod folder of RoR
mv ../community-map.zip ~/.rigsofrods/packs
