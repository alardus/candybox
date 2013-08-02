#!/bin/bash
dpkg -b candybox-0.0.1-2
dpkg -b xl2tpd-modules-3.6.11
#dpkg -b xl2tpd-kernel_1.3.1+dfsg-2_armhf

mv candybox-0.0.1-2.deb stable
mv xl2tpd-modules-3.6.11.deb stable
#mv xl2tpd-kernel_1.3.1+dfsg-2_armhf.deb stable

dpkg-scanpackages stable /dev/null | gzip -9c > stable/Packages.gz
