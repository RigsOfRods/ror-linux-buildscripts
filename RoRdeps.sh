#!/bin/bash

#Precompiled dependencies
sudo apt-get update
sudo apt-get install subversion mercurial git automake cmake build-essential pkg-config doxygen \
 libfreetype6-dev libfreeimage-dev libzzip-dev scons libcurl4-openssl-dev \
 nvidia-cg-toolkit libgl1-mesa-dev libxrandr-dev libx11-dev libxt-dev libxaw7-dev \
 libglu1-mesa-dev libxxf86vm-dev uuid-dev libuuid1 libgtk2.0-dev libboost-all-dev \
 libopenal-dev libois-dev libssl-dev libwxgtk3.0-dev

#Initialization
cpucount=$(grep -c processor /proc/cpuinfo)

cd ~/
mkdir ~/ror-deps
mkdir ~/.rigsofrods 
cd ~/ror-deps

#OGRE
hg clone https://bitbucket.org/sinbad/ogre -b v1-8
cd ogre
cmake -DFREETYPE_INCLUDE_DIR=/usr/include/freetype2/ -DCMAKE_BUILD_TYPE:STRING=Release -DOGRE_BUILD_SAMPLES:BOOL=OFF .
make -j$cpucount
sudo make install
cd ..
#not needed on 32bit
sudo ln -s /usr/lib/x86_64-linux-gnu/OGRE-1.8.0/ /usr/local/lib/
sudo mv /usr/local/lib/OGRE-1.8.0 /usr/local/lib/OGRE

#MyGUI
svn co https://my-gui.svn.sourceforge.net/svnroot/my-gui/trunk my-gui -r 4344
cd my-gui
cmake -DFREETYPE_INCLUDE_DIR=/usr/include/freetype2/ -DCMAKE_BUILD_TYPE:STRING=Release -DMYGUI_BUILD_SAMPLES:BOOL=OFF -DMYGUI_INSTALL_SAMPLES:BOOL=OFF -DMYGUI_BUILD_TOOLS:BOOL=OFF -DMYGUI_BUILD_PLUGINS:BOOL=OFF .
#tell ld to use libboost_system library
cd Demos
for link in `find . -name 'link.txt'` 
do
	eval "sed '1 s/$/ -lboost_system/' -i $link"
done
cd ..
cd MyGUIEngine
for link in `find . -name 'link.txt'` 
do
	eval "sed '1 s/$/ -lboost_system/' -i $link"
done
cd ..
make -j$cpucount
sudo make install
cd ..

#Paged Geometry
git clone https://github.com/Hiradur/ogre-paged.git
cd ogre-paged
cmake -DCMAKE_BUILD_TYPE:STRING=Release -DPAGEDGEOMETRY_BUILD_SAMPLES:BOOL=OFF .
make -j$cpucount
sudo make install
cd ..

#Caelum (needs specific revision for OGRE-1.8)
hg clone -r 3b0f1afccf5cb75c65d812d0361cce61b0e82e52 https://caelum.googlecode.com/hg/ caelum 
cd caelum
cmake .
make -j$cpucount
sudo make install
cd .. 
# important step, so the plugin can load:
sudo ln -s /usr/local/lib/libCaelum.so /usr/local/lib/OGRE/

#MySocketW
git clone https://github.com/Hiradur/mysocketw.git
cd mysocketw
make -j$cpucount shared
sudo make install
cd ..

#Angelscript
mkdir angelscript
cd angelscript
wget http://www.angelcode.com/angelscript/sdk/files/angelscript_2.22.1.zip
unzip angelscript_*.zip
cd sdk/angelscript/projects/gnuc
SHARED=1 VERSION=2.22.1 make -j$cpucount --silent 
# sudo make install fails when making the symbolic link, this removes the existing versions
rm -f ../../lib/*
sudo SHARED=1 VERSION=2.22.1 make install 
#cleanup files made by root
rm -f ../../lib/*
cd ../../../../../

#Hydrax
wget http://modclub.rigsofrods.com/xavi/hydrax-0.5.2-ogre-17-patched.tar.bz2
tar xvfj hydrax*
cd hydrax-*
## Fix for errors running the make command: remove the # on the lines below up to the end
cp makefile makefile.orig
sed 's|PREFIX =/usr|PREFIX =/usr/local|g' makefile.orig > makefile
## end of fix
make -j$cpucount
sudo make install
cd ..
rm hydrax-0.5.2-ogre-17-patched.tar.bz2

echo "$(tput setaf 1)NOTE: This script does not check for errors. Please scroll up and check if something went wrong."
echo "INFO: To remove Caelum, MySocketW and Paged Geometry, see Wiki: http://www.rigsofrods.com/wiki/pages/Compiling_3rd_party_libraries$(tput sgr 0)"

