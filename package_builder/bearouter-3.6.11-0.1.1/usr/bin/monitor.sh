#!/bin/bash

###
# bearouter project / 2012-2013
# bearouter.org

# Monitoring existing xl2tpd process and ppp0 interface

# Maintainer: Alexander Bykov <alardus@alardus.org>
###

#we need to find pid and ppp0 interface
CONFIG=`/bin/cat /etc/xl2tpd/xl2tpd.conf | /bin/grep tp.internet.beeline.ru`
PID=`/bin/ps -A | /bin/grep xl2tpd | /bin/grep -v grep | /usr/bin/awk '{print $1}'`
PPP=`/sbin/ifconfig | /bin/grep ppp0 | /usr/bin/awk '{print $1}'`

if test "$CONFIG" == ""; then
	/usr/bin/logger "[CONFIG ERR] Configs not installed properly"
	exit 0

elif test "$PID" == ""; then
	/usr/bin/logger "[PID ERR] PID=$PID, PPP=$PPP"
	/etc/init.d/xl2tpd stop
	sleep 5
	/usr/bin/poff -a
	sleep 5
	/etc/init.d/networking stop
	sleep 5
	/etc/init.d/networking start
	sleep 5
	/etc/init.d/xl2tpd start
	sleep 20
	exit 0

elif test "$PPP" == ""; then 
	/usr/bin/logger "[PPP ERR] PID=$PID, PPP=$PPP"
	/etc/init.d/xl2tpd stop
	sleep 5
	/usr/bin/poff -a
	sleep 5
	/etc/init.d/networking stop
	sleep 5
	/etc/init.d/networking start
	sleep 5
	/etc/init.d/xl2tpd start
	sleep 20
	exit 0

else 
	/usr/bin/logger "[PASSED] PID=$PID, PPP=$PPP"
fi
