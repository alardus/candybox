Candybox router
===============

Candybox - is an tuned variant of original Raspbian 'wheezy' disto for using on RPi to route network traffic (eg. web, online games, skype, torrents) between computers in home network and the Internet. 

Candybox is fully configured and ready to run from the box, settings may be changed using a web interface, or a command-line interface.


##What do you need to run it##
- Raspberry Pi Model B
- USB-Ethernet adapter (we use one from Apple)
- Beeline (ex. Corbina) ISP ethernet connection
- Latest Candybox release builded for RPi


##How to use it##
- Visit http://candyboxrouter.org/ and download latest release for RPi
- To use an image file, you will need to unzip it and write it to a suitable SD card using the UNIX tool dd. Windows users should use Win32DiskImager. Do not try to drag and drop or otherwise copy over the image without using dd or Win32DiskImager – it won’t work. If you’re still not clear on what to do, the community on the Raspberry Pi Wiki has written a guide for beginners on how to set up your SD card
- Plug in your WAN cable to the ethernet port on RPi and LAN cable to the USB-Ethernet adapter which must be connected to one of USB port
- Plug in into power source and wait while it booting up
- Restart networking on your computer to optain new IP address from RPi
- Open your browser to '192.168.0.1:8080', create a password for accessing configurator, enter your credentials for Beeline (ex. Corbina) ISP and click "Save and connect"


##Technical overview##

**Supported ISPs**
- For now only Beeline (ex. Corbina) over L2TP supported

**Web interface features**
- Setup internet connection, turn it on or off
- Use Netflix and Pandora at any devices at your house
- Use DDNS for accessing your home computer with dynamic IP
- Manage port forwarding for any services in your home network (eg. torrents or web/ftp server) without manually entering iptables rules
- Observe the state of the system and it main services 

**What in the box**
- raspbian 'wheezy' with 3.6 kernel and l2tp_* kernel modules
- xl2tpd with kernel modules support for decrease CPU loading
- dnsmasq as DHCP/DNS server with logging of DHCP leases
- set of scripts for monitoring and repairing connection
- fail2ban for intrusion prevention
- ddclient for DynDNS support 
- web configurator
