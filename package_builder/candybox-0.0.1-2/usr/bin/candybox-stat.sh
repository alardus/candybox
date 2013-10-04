#!/bin/bash

###
# This script collect some data about current installation

# Information available at project homepage:
# http://www.candyboxrouter.com

# Maintainer: Alexander Bykov <alardus@alardus.org>
###

# Check that the file with uuid exists
id="/var/log/uuid"

if [ -s "$id" -a -e "$id" ] ; then
	echo "" > /dev/null
else
	uuidgen -t > /var/log/uuid
fi

#Preparing data
uuid=`cat /var/log/uuid`
os_name=`cat /etc/issue | awk '{print $1}'`
os_ver=`cat /etc/issue | awk '{print $2}'`
package_ver=`dpkg -s candybox | grep Version | awk '{print $2}'`

#Sending data 
curl -X POST http://repo.candyboxrouter.com/stat?uuid=$uuid'&'os_name=$os_name'&'os_ver=$os_ver'&'package_ver=$package_ver
