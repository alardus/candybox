deploy
======

##How to make a deployment##

###Prepare packages###
* You need to build 1 package - 'candybox'
* Copy latest 'candybox' files to 'candybox' package folder at path /usr/share/candybox
* Run 'repo_update.sh' (see 'package_builder', ckeck packages names at script) and copy files from 'ubuntu' folder to the repository URL
* (optional) Change repository URL in 'repo.list' if you change it on previous step

###Deploy to the target###
* Install original image of Raspbian on SD, boot RPi from it
* Copy 'deploy' folder on a target machine and run 'sudo ./deploy_release.sh'

###Make new Candybox ISO###
* Run 'iso_builder.sh' (but first check for device name in 'dd' command)

###Content description###
- /etc - contains configs that need to be installed on a target computer
- repo.list - contains repository URL with custom packages
- tune_pi.py - change parameters in /boot/config.txt without running raspi-config
- deploy_release.sh - install needed packages and put configs in a right place
- deploy_devel.sh - same as the one above, but installs a bit more packages to build xl2tpd or l2tp kernel modules

