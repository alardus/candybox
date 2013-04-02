#!/bin/bash

###
# bearouter project / 2012-2013
# bearouter.org

# This script collect some data about current installation

# Maintainer: Alexander Bykov <alardus@alardus.org>
###

# Check that the file with uuid exists
function test_error {
    if [ $? != 0 ]; then 
        uuidgen -t > /var/log/uuid
    elif [ "$id" == "" ]; then
    	uuidgen -t > /var/log/uuid
    fi
}

cat /var/log/uuid 2> /dev/null
	test_error

id=`/bin/cat /var/log/uuid`
    test_error

#Preparing data
uuid=`cat /var/log/uuid`
os_name=`cat /etc/issue | awk '{print $1}'`
os_ver=`cat /etc/issue | awk '{print $2}'`
package_ver=`dpkg -s bearouter | grep Version | awk '{print $2}'`

#Sending data 
curl -X POST http://bearouter.org/stat?uuid=$uuid'&'os_name=$os_name'&'os_ver=$os_ver'&'package_ver=$package_ver
