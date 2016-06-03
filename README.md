# Rigs of Rods build scripts
These shell scripts build the vehicle simulator Rigs of Rods and its dependencies on systems using *apt* as package manager (e.g. Debian, Ubuntu, Mint).
With some minor adjustments they should work on Linux distributions not based on *apt* as well.

### Build and install Rigs of Rods:
Run these commands from console in this order and not simultaneously:
```sh
sh dependencies-apt.sh
sh dependencies.sh
sh core.sh
sh content.sh
# if you want to you can also install the community-map, but it's still WIP
sh community_map.sh
```
  
##### Notes:
* `RoRdepsapt.sh` will first ask for sudo password and will prompt you a bit later to confirm the installation of the packages. Make sure the packages don't conflict with something you need (usually doesn't happen).
* `RoRdeps.sh` and `RoRcore.sh` don't require user interaction.  
* `RoRcontent.sh` only requires you to choose the content you want to download in the beginning.
* To change default directories and *make* parameters edit the `config` file (optional).
* Depending on your hardware and internet speed this can take quite a while. As long as the scripts are running everything is fine. If an errors occurs they will stop and state the error.


### Update to current snapshot
simply re-run
```sh
sh RoRcore.sh
```

##### General notes: 
* Included is a script for profiling. If you don't know what that means then it is not for you!
* Scripts to build the RoR multiplayer server and set up a development environment for the RoR website named `RoRserver.sh` and `RoRwebsite.sh`  respecitvely are included as well (see the scripts for additional information).
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
# replace X Y Z with the packages installed by RoRdepsapt.sh
# note: make sure you only remove packages you don't need for something else
sudo apt-get purge X Y Z

# remove now unneeded dependencies of the dependencies of RoR
sudo apt-get autoremove
```

###### Links:
Official Rigs of Rods website: http://rigsofrods.org  
Git repository of these scripts: https://github.com/RigsOfRods/ror-linux-buildscripts  
Thread on RoR forums: http://rigsofrods.org/thread-21.html  
