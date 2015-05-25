# Rigs of Rods build scripts
These shell scripts build the vehicle simulator Rigs of Rods and its dependencies on systems using apt as package manager (e.g. Debian, Ubuntu, Mint).

### Build and install:
Run these commands from console in this order and not simultaneously:
```
sh RoRdepsapt.sh
sh RoRdeps.sh
sh RoRcore.sh
sh RoRcontent.sh
```

##### Notes:
* To change default directories and make options edit the "config" file (optional)
* RoRdepsapt.sh will prompt you to confirm the installation of packages. Make sure the packages don't conflict with something you need (usually doesn't happen)
* Depending on your hardware and internet speed this can take quite a while. As long as the scripts are running everything is fine. If an errors occurs they will stop and state the error


### Update to current snapshot
```
sh RoRcore.sh
```

##### General notes: 
* Included is a script for profiling. If you don't know what that means then it is not for you!
* If for whatever reason you copy parts of the script into the console make sure to set configuration
variables appropriately, either manually, or by sourcing the "config" file like this:

```
. ./config
```

###### Links:
Git repository: https://github.com/Hiradur/rigsofrods-linuxscripts  
Thread on RoR forums: http://www.rigsofrods.com/threads/114853-Install-scripts-for-latest-snapshot-for-Debian-Ubuntu-Mint  
