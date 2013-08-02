#!/bin/bash

###
# Candybox for Raspberry Pi. Turn Pi into router. 

# Information available at project homepage:
# http://www.candyboxrouter.com

# Maintainer: Alexander Bykov <alardus@alardus.org>
# Copyright (c) 2013, Alexander Bykov
###

clear


# Error handling 
function test_error {
	if [ $? != 0 ]; then 
		echo "An error has occurred. Aborted."
    	exit 1
	fi
}

function test_package {
	search=`dpkg --get-selections | grep $1 | head -n1 | awk '{print $2}'`
	if [ "$search" != "install" ]; then
		echo "$1 package not found. Aborted."
    	exit 1
	fi
}


# Step 0. Checking for internet connectivity
echo "Checking for internet connection..."
echo `ping -c1 ya.ru > /dev/null`
	test_error


# Step 1. Adding repository
echo "Checking list of repositories..."
cat repo.list > /dev/null
	test_error

cat repo.list | while read i; do
	find_repo=`cat /etc/apt/sources.list | grep "$i"`
	if [ "$find_repo" == "" ]; then
		echo "Adding $i..."
		echo $i >> /etc/apt/sources.list
		test_error
	fi
done


# Step 2. Installing packages and configs

### Fix for DDNS client. We need to put ddclient config file BEFORE package will be installed
cp etc/ddclient.conf /etc/ddclient.conf
	test_error
#cp etc/default/ddclient	/etc/default/ddclient
#	test_error
###

echo "Updating apt cache and installing packages..."
sleep 5
apt-get update 
LC_ALL=C apt-get install dnsmasq xl2tpd-kernel xl2tpd-modules candybox fail2ban ddclient host uuid-runtime
	test_package "dnsmasq"
	test_package "xl2tpd-kernel"
	test_package "xl2tpd-modules"
	test_package "candybox"
	test_package "fail2ban"
	test_package "ddclient"
	test_package "host"
	test_package "uuid-runtime"

echo "Installing interfaces..."
cp etc/network/interfaces /etc/network/interfaces
	test_error

echo "Installing dhclient..."
cp etc/dhcp/dhclient.conf /etc/dhcp/dhclient.conf
	test_error

echo "Installing dhclient hooks..."
cp etc/dhcp/dhclient-exit-hooks.d/static-routes /etc/dhcp/dhclient-exit-hooks.d/static-routes
	test_error

echo "Configuring ip_forwarding..."
echo "1" > /proc/sys/net/ipv4/ip_forward
	test_error

echo "Configuring sysctl..."
cp etc/sysctl.conf /etc/sysctl.conf
	test_error

echo "Configuring dnsmasq..."
cp etc/dnsmasq.conf /etc/dnsmasq.conf
	test_error

echo "Configuring xl2tpd..."
cp etc/xl2tpd/xl2tpd.conf /etc/xl2tpd/xl2tpd.conf
	test_error
cp etc/ppp/chap-secrets /etc/ppp/chap-secrets
	test_error
cp etc/ppp/options.xl2tpd /etc/ppp/options.xl2tpd
	test_error

echo "Configuring fail2ban..."
cp etc/fail2ban/fail2ban.conf /etc/fail2ban/fail2ban.conf
	test_error
cp etc/fail2ban/jail.conf /etc/fail2ban/jail.conf
	test_error
cp etc/fail2ban/jail.local /etc/fail2ban/jail.local
	test_error

echo "Tune RPi config..."
python ./tune_pi.py
	test_error

echo "Enable RPi first run..."
cp etc/profile.d/raspi-config.sh /etc/profile.d/raspi-config.sh
	test_error

# Updating crontab for root
echo "0 04 * * * /usr/bin/candybox-stat.sh" > /tmp/cronjob
	test_error
echo "0 04 * * * /usr/bin/candybox-upgrade.sh" >> /tmp/cronjob
	test_error
echo "*/1 * * * * /usr/bin/candybox-logs.sh" >> /tmp/cronjob
	test_error
echo "*/5 * * * * /usr/bin/candybox-monitor.sh" >> /tmp/cronjob
	test_error
echo "*/5 * * * * /usr/sbin/ddclient" >> /tmp/cronjob
	test_error

crontab /tmp/cronjob
	test_error
rm /tmp/cronjob
	test_error
###

# Fix for candybox system section. Preparing for 'candybox-logs' script will not working
mkdir /var/log/candybox
echo "" > /var/log/candybox/connect
echo "" > /var/log/candybox/uptime
echo "" > /var/log/candybox/ifaces
echo "" > /var/log/candybox/issue
echo "" > /var/log/candybox/ddns
echo "" > /var/log/candybox/ddns_status
###

echo "Completed."
