#!/bin/bash

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
