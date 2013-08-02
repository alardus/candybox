#!/bin/bash

###
# This script perform everyday check for candybox package upgrade

# Information available at project homepage:
# http://www.candyboxrouter.com

# Maintainer: Alexander Bykov <alardus@alardus.org>
###

`apt-get update`
`apt-get -y --force-yes -o Dpkg::Options::="--force-overwrite" install candybox`
