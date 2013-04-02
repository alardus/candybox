#!/bin/bash

###
# bearouter project / 2012-2013
# bearouter.org

# This script build l2tp modules for current kernel 

# Maintainer: Alexander Bykov <alardus@alardus.org>
###


# Check is all needed package are installed
function test_package {
	search=`/usr/bin/dpkg --get-selections | /bin/grep $1 | /usr/bin/head -n1 | /usr/bin/awk '{print $2}'`
	if [ "$search" != "install" ]; then
		echo "$1 package not found. Aborted."
    	exit 1
	fi
}

test_package "git"
test_package "wget"
test_package "libpcap-dev"

# Downloading source for CURRENT kernel branch at github/raspberrypi
cd /usr/src
git clone --depth 1 https://github.com/raspberrypi/linux.git
ln -s linux linux-`uname -r`

# Prepare environment for building needed kernel modules
cd linux 
zcat /proc/config.gz > .config
ln -s /usr/src/linux /lib/modules/`uname -r`/build
make oldconfig
make modules_prepare
wget https://github.com/raspberrypi/firmware/raw/master/extra/Module.symvers

# Building l2tp modules
cd /usr/src/linux/net/l2tp
path Makefile < /home/pi/pi/kernel/Makefile.patch
make -C /lib/modules/`uname -r`/build SUBDIRS=$PWD modules

echo "l2tp_ppp.ko was builded. Take it."
