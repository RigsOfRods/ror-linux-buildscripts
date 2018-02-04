# Rigs of Rods build scripts
These shell scripts build the vehicle simulator Rigs of Rods and its dependencies on systems using *apt* as package manager (e.g. Debian, Ubuntu, Mint).
With some minor adjustments, they should work on Linux distributions not based on *apt* as well.

### Build and install Rigs of Rods:
Run these commands from the console in this order and not simultaneously:

`sh dependencies-Ubuntu.sh` if your distro is based on Ubuntu xenial, yakkety or artful 
OR 
`sh dependencies.sh` if your distro is based on something else.

```sh
sh game.sh
sh content.sh
# if you want to you can also install the community-map, but it's still WIP
sh community_map.sh
```

##### Notes:
* `dependencies.sh` and `dependencies-Ubuntu.sh` will first ask for sudo password and will prompt you a bit later to confirm the installation of the packages. Make sure the packages don't conflict with something you need (usually doesn't happen).
* `game.sh` asks for sudo password to install the game.  
* `content.sh` only requires you to choose the content you want to download in the beginning.
* To change default directories and *make* parameters edit the `config` file (optional).
* Depending on your hardware and internet speed this can take quite a while. As long as the scripts are running everything is fine. If an error occurs they will stop and state the error.


### Update to current snapshot
simply re-run
```sh
sh game.sh
```

##### General notes:
* Included is a script for profiling. If you don't know what that means then it is not for you!
* Scripts to build the RoR multiplayer server and set up a development environment for the RoR website named `server.sh` and `website.sh`  respectively are included as well (see the scripts for additional information).
* If for whatever reason you copy parts of the script into the console make sure to set configuration
variables appropriately, either manually, or by *sourcing* the `config` file like this:
```
. ./config
```

### Uninstallation

Uninstalling RoR which was installed by these scripts consists of these steps:  

```sh
# remove sources and binaries
# note: adjust path if you changed it in the config file
rm -r ~/rigs-of-rods

# remove mods and settings
rm -r ~/.rigsofrods

# uninstall packages of dependencies
# replace X Y Z with the packages installed by dependencies.sh
# note: make sure you only remove packages you don't need for something else
sudo apt-get purge X Y Z

# remove now unneeded dependencies of the dependencies of RoR
sudo apt-get autoremove
```

###### Links:
Official Rigs of Rods website: http://rigsofrods.org  
Git repository of these scripts: https://github.com/RigsOfRods/ror-linux-buildscripts  
Thread on RoR forums: https://forum.rigsofrods.org/development-discussion/101-shell-scripts-build-rigs-rods-git-debian-ubuntu-mint.html 
