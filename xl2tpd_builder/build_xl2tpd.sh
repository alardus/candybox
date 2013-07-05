#!/bin/bash

###
# Build xl2tpd with l2tp_* kernel modules support 

# Information available at project homepage:
# http://www.candyboxrouter.com

# Maintainer: Alexander Bykov <alardus@alardus.org>
###

wget http://ftp.de.debian.org/debian/pool/main/x/xl2tpd/xl2tpd_1.3.1+dfsg.orig.tar.gz
wget http://ftp.de.debian.org/debian/pool/main/x/xl2tpd/xl2tpd_1.3.1+dfsg-1.debian.tar.gz
#wget xl2tpd_1.3.1+dfsg.patch.tar

tar -xf xl2tpd_1.3.1+dfsg.orig.tar.gz
tar -xf xl2tpd_1.3.1+dfsg-1.debian.tar.gz
tar -xf xl2tpd_1.3.1+dfsg.patch.tar

mv debian xl2tpd-1.3.1+dfsg.orig
cd ./xl2tpd-1.3.1+dfsg.orig
rm -rf ./linux

patch -p1 < ../xl2tpd-1.3.1+dfsg.patch/Makefile.patch
patch -p1 < ../xl2tpd-1.3.1+dfsg.patch/call.c.patch
patch -p1 < ../xl2tpd-1.3.1+dfsg.patch/control.c.patch
patch -p1 < ../xl2tpd-1.3.1+dfsg.patch/l2tp.h.patch
patch -p1 < ../xl2tpd-1.3.1+dfsg.patch/network.c.patch
patch -p1 < ../xl2tpd-1.3.1+dfsg.patch/xl2tpd.c.patch
patch -p1 < ../xl2tpd-1.3.1+dfsg.patch/changelog.patch

cd ..

tar -cf xl2tpd_1.3.1+dfsg.orig.tar xl2tpd-1.3.1+dfsg.orig
gzip -1 xl2tpd_1.3.1+dfsg.orig.tar
cd xl2tpd-1.3.1+dfsg.orig

LC_ALL=C dpkg-buildpackage -rfakeroot -us -uc
