# Rigs of Rods build scripts
These shell scripts build the vehicle simulator Rigs of Rods and its dependencies on systems using apt as package manager (e.g. Debian, Ubuntu, Mint).
With some minor adjustments they should work on Linux distributions not based on apt as well.

### Build and install Rigs of Rods:
Run these commands from console in this order and not simultaneously:
```
sh RoRdepsapt.sh
sh RoRdeps.sh
sh RoRcore.sh
sh RoRcontent.sh
```
  
##### Notes:
* ```RoRdepsapt.sh``` will first ask for sudo password and will prompt you a bit later to confirm the installation of the packages. Make sure the packages don't conflict with something you need (usually doesn't happen).
* ```RoRdeps.sh``` and ```RoRcore.sh``` don't require user interaction.  
* ```RoRcontent.sh``` only requires you to choose the content you want to download in the beginning.
* To change default directories and make parameters edit the ```config``` file (optional).
* Depending on your hardware and internet speed this can take quite a while. As long as the scripts are running everything is fine. If an errors occurs they will stop and state the error.


### Update to current snapshot
simply re-run
```
sh RoRcore.sh
```

##### General notes: 
* Included is a script for profiling. If you don't know what that means then it is not for you!
* Scripts to build the RoR multiplayer server and set up a development environment for the RoR website are included as well (see the scripts for additional information).
* If for whatever reason you copy parts of the script into the console make sure to set configuration
variables appropriately, either manually, or by sourcing the ```config``` file like this:

```
. ./config
```

###### Links:
Rigs of Rods main page: https://rigsofrods.github.io
Git repository: https://github.com/Hiradur/rigsofrods-linuxscripts  
Thread on RoR forums: http://www.rigsofrods.com/threads/114853-Install-scripts-for-latest-snapshot-for-Debian-Ubuntu-Mint  
