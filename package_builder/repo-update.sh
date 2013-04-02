#!/bin/bash
dpkg -b bearouter-3.6.11-0.1.1
mv bearouter-3.6.11-0.1.1.deb ubuntu
dpkg-scanpackages ubuntu /dev/null | gzip -9c > ubuntu/Packages.gz
