#!/bin/bash
dpkg -b bearouter-3.6.11-0.1.1
dpkg -b xl2tpd-kernel_1.3.1+dfsg-2_armhf

mv bearouter-3.6.11-0.1.1.deb ubuntu
mv xl2tpd-kernel_1.3.1+dfsg-2_armhf ubuntu

dpkg-scanpackages ubuntu /dev/null | gzip -9c > ubuntu/Packages.gz
