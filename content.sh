#!/bin/sh
set -e

cd ~/
mkdir -p ~/.rigsofrods/packs

while true; do
    read -p "Which Pack do you want to download? 
[1]Content Pack (200MB)
[2]High Quality Pack (includes Content Pack) >1GB
[3]none/exit
input: " input

case $input in
        [1]* ) wget http://downloadcdn.rigsofrods.org/pack_contentpack04.zip -O content-pack-0.4.zip; unzip content-pack-0.4.zip -d ~/.rigsofrods/packs/; mv ~/.rigsofrods/packs/ContentPack04/* -t ~/.rigsofrods/packs/; rmdir ~/.rigsofrods/packs/ContentPack04; rm content-pack-0.4.zip;;
        [2]* ) wget http://downloadcdn.rigsofrods.org/pack_highquality04.zip -O hq-pack-0.4.zip; unzip hq-pack-0.4.zip -d ~/.rigsofrods/packs/; mv ~/.rigsofrods/packs/HighQuality04/* -t ~/.rigsofrods/packs/; rmdir ~/.rigsofrods/packs/HighQuality04; rm hq-pack-0.4.zip;;
        [3]* ) exit;;
        * ) echo "Please answer 1,2 or 3";;
    esac
done

echo "$(tput setaf 2)Pack successfully installed."
echo "You can find more content at https://repofiles.avrintech.net/"
echo "Some content may only be found in the forum: rigsofrods.org/forum-16.html"
echo "Place new mods in ~/.rigsofrods/packs$(tput sgr 0)"
