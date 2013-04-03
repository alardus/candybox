#!/bin/bash

# Check is all needed package are installed
function test_package {
	search=`/usr/bin/dpkg --get-selections | /bin/grep $1 | /usr/bin/head -n1 | /usr/bin/awk '{print $2}'`
	if [ "$search" != "install" ]; then
		echo "$1 package not found. Aborted."
    	exit 1
	fi
}

test_package "kpartx"

echo "Copying original iso..."
cp ./2013-02-09-wheezy-raspbian.img ./pi.img

echo "Copying partition table from SD..."
dd if=/dev/sdb1 of=./sdb1.img bs=4096 conv=notrunc,noerror
dd if=/dev/sdb2 of=./sdb2.img bs=4096 conv=notrunc,noerror

echo "Mount original iso..."
kpartx -av pi.img

echo "Copying partition table to original iso..."
dd if=./sdb1.img of=/dev/mapper/loop0p1 bs=4096 conv=notrunc,noerror
dd if=./sdb2.img of=/dev/mapper/loop0p2 bs=4096 conv=notrunc,noerror

echo "Unmount original iso..."
kpartx -dv pi.img
