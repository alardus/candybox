#!/bin/bash

###
# Script prepare logs for showing system info at our web configuration tool

# Information available at project homepage:
# http://www.candyboxrouter.com

# Maintainer: Alexander Bykov <alardus@alardus.org>
###

mkdir /var/log/ 
connect=/var/log/candybox/connect
uptime=/var/log/candybox/uptime
ifaces=/var/log/candybox/ifaces
issue=/var/log/candybox/issue
ddns=/var/log/candybox/ddns
ddns_status=/var/log/candybox/ddns_status
dhcp_lease=/var/log/candybox/dhcp_lease

os=`cat /etc/issue | head -n1 |awk '{print $1, $2}'`
kernel=`/bin/uname -r`
pkg=`/usr/bin/dpkg -s candybox | grep Version: | awk '{print $2}'`
	if [ "$pkg" == "" ]; then 
		pkg="not installed"
	fi


`curl http://ya.ru -m 3 > /dev/null`
if [ "$?" != 0 ]; then
	echo "Disconnected" > $connect
    else
    echo "Connected" > $connect
fi


echo "System uptime:" > $uptime
`uptime >> $uptime`


echo "Active network interfaces:" > $ifaces
eth_list=`/sbin/ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d'`
for i in $eth_list; do 
	iface=`/sbin/ifconfig $i | grep addr: | head -n 1 | awk '{print $2}'`
	if [ "$iface" == "" ]; then 
		echo "" > /dev/null
	else
		echo "$i: $iface" >> $ifaces
	fi
	done 

echo "$os, kernel $kernel, candybox configs $pkg." > $issue

echo "DynDNS client status:" > $ddns
cat /var/log/syslog | grep ddclient | grep SUCCESS | tail -n1 | awk {'print $8, $10, $11, $12, $13, $14'} >> $ddns

# And again with minimal info for /password template
cat /var/log/syslog | grep ddclient | grep SUCCESS | tail -n1 | awk {'print $8, $10, $11, $12, $13, $14'} > $ddns_status

echo "DHCP leases:" > $dhcp_lease
cat /var/log/dhcp-lease | awk '{print $3, "", $4, "", $5}' >> $dhcp_lease