#!/bin/bash
dpkg -b candybox-3.6.11-0.0.1
#dpkg -b xl2tpd-kernel_1.3.1+dfsg-2_armhf

mv candybox-3.6.11-0.0.1.deb ubuntu
#mv xl2tpd-kernel_1.3.1+dfsg-2_armhf.deb ubuntu

dpkg-scanpackages ubuntu /dev/null | gzip -9c > ubuntu/Packages.gz
