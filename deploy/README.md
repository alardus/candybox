deploy
======

##How to make a deploy##
**ATTN! Remember that you must build l2tp_* modules and xl2tpd binary files on a target machine with ARM arch.**

###Prepare packages###
* You need to build two packages - 'bearouter' and 'xl2tpd-kernel'. 
* Package folder 'bearouter' with kernel version in his name already contain everything needed for that kernel version. If currently we have not package with actual kernel version at github repository, you can build it yourself (see 'kernel_builder', you will need to install 'git', 'libpcap-dev', 'devscripts', 'fakeroot', 'debhelper' and 'kpartx'), create new package and make pull request.
* Copy latest 'cava' files to 'bearouter' package folder at path /usr/share/cava.
* Build latest 'xl2tpd' (see 'xl2tpd_builder'), then copy files from builded 'xl2tpd' package (excluding 'DEBIAN' folder) to the 'xl2tpd-kernel' package folder.
* Run 'repo_update.sh' (see 'package_builder', ckeck packages names at script) and copy files from 'ubuntu' folder to the repository URL.
* (optional) Change repository URL in 'repo.list' if you change it on previous step.

###Deploy to the target###
* Install original image of Raspbian on SD, boot RPi from it
* Git clone 'deploy' on a target machine and run 'sudo ./deploy_release.sh'

###Make new RPiR ISO###
* Run 'iso_builder.sh' (but first check for device name in 'dd' command)

###Content description###
- /etc - contain configs that need to be installed on a target computer
- repo.list - contain repository URL with custom packages 
- tune_pi.py - change parameters in /boot/config.txt without running raspi-config
- deploy_release.sh - install needed packages and put configs in a right place
- deploy_devel.sh - same as previous, but install a bit more packages to build xl2tpd or l2tp kernel modules

