Candybox router
===============

### What is Candybox
Candybox turns your Raspberry Pi into router. Just put RPi in your network, install latest Candybox release on SD card &mdash; and you are online.

One of great feature of Candybox router &mdash; it fully configured, with all components that you may need from router (dhcp, dns, ddns, pptp, l2tp kernel modules, etc) and all of they are ready to run out of the box.

In addition it supports Netflix and Pandora. As you know, you can't use those web services in case you are living outside the US. But we eliminated this problems in Candybox - no matter where you are living, you can use what you want and where you want it.

Another good thing &mdash; is a web control panel. We know how annoying to make small changes in router setup through command line. For those situations we created a simple web configurator that allow to configure many of features that people needed from router. 

Want to add port forwarding to internal host? &mdash; No problem. Needed to setup DDNS hostname? &mdash; Just put your credential at DDNS section.

Simple, right?

### How it's looks
{screenshot section, TBD}

### What do you need to run it
- Raspberry Pi Model B
- WiFi router (of course you can use any of Raspbian compatible USB WiFi-dongle, but you will need to configure it manualy - currently we haven't support for them in default settings)
- USB-Ethernet adapter (we use one from Apple)
- Beeline (ex. Corbina) ISP ethernet connection
- Latest Candybox release builded for RPi


### How to use it
- Visit http://candyboxrouter.org/ and download latest release for RPi
- To use an image file, you will need to unzip it and write it to a suitable SD card using the UNIX tool dd. Windows users should use Win32DiskImager. Do not try to drag and drop or otherwise copy over the image without using dd or Win32DiskImager &mdash; it won’t work. If you’re still not clear on what to do, the community on the Raspberry Pi Wiki has written a guide for beginners on how to set up your SD card
- Plug in your WAN cable to the ethernet port on RPi and LAN cable to the USB-Ethernet adapter which must be connected to one of USB port
- Plug in into power source and wait while it booting up
- Restart networking on your computer to optain new IP address from RPi
- Point your browser to '192.168.0.1:8080', create a password for accessing configurator, enter your credentials for Beeline (ex. Corbina) ISP and click "Save and connect"


### Technical overview
**Supported ISPs**
- For now only Beeline (ex. Corbina) over L2TP supported

**Web interface features**
- Setup internet connection, turn it on or off
- Use Netflix and Pandora at any devices at your home
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


### Authors 
Candybox was imagined and created by:
- Alexander Bykov (@alardus)
- Grigory Bakunov (@bobuk)
- Danil Ivanov (@imfo)
- Alexey Markin
- Anatoly Lebedev 

If you want to help make it better &mdash; you are welcome.
Join project on GitHub and make a pull request.
