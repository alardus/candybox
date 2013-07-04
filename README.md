Candybox router
===============

### What is Candybox
Candybox turns your Raspberry Pi into router. Just put it in your network, install latest release on SD card - and you are connected.

One of great Candybox feature - is a integrated support for Netflix and Pandora. The problem with those services are simple - if you are living outside the US you can't use they in normal way. With Candybox you use them as if you are  located inside US.

Another good thing - is a web panel. We know how annoying sometimes making small changes in router via command line. For those situations we created a simple web configurator that allow to configure many of those features that people needed from router. Want to add port forwarding to internal host? - No problem. Needed to setup DDNS hostname? - Just put your credential at DDNS section.

Simple, right?


### What do you need to run it
- Raspberry Pi Model B
- Externel WiFi module (you can use internal too, but now we haven't support for them in Candybox preconfigured settings)
- USB-Ethernet adapter (we use one from Apple)
- Beeline (ex. Corbina) ISP ethernet connection
- Latest Candybox release builded for RPi


### How to use it
- Visit http://candyboxrouter.org/ and download latest release for RPi
- To use an image file, you will need to unzip it and write it to a suitable SD card using the UNIX tool dd. Windows users should use Win32DiskImager. Do not try to drag and drop or otherwise copy over the image without using dd or Win32DiskImager – it won’t work. If you’re still not clear on what to do, the community on the Raspberry Pi Wiki has written a guide for beginners on how to set up your SD card
- Plug in your WAN cable to the ethernet port on RPi and LAN cable to the USB-Ethernet adapter which must be connected to one of USB port
- Plug in into power source and wait while it booting up
- Restart networking on your computer to optain new IP address from RPi
- Open your browser to '192.168.0.1:8080', create a password for accessing configurator, enter your credentials for Beeline (ex. Corbina) ISP and click "Save and connect"


### Technical overview
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


### Authors and Contributors
Candybox was imagined and created by:
- Alexander Bykov (@alardus)
- Grigory Bakunov (@bobuk)
- Danil Ivanov (@mash)
- Alexey Markin
- Anatoly Lebedev 

If you want to help make it better - you are welcome!
Please join our project and do a pull request on GitHub.


Copyright (c) 2013, Alexander Bykov.