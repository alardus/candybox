RPi router
==========

Turn your RPi into router for Beeline (Corbina) ISP

**What do you need to run it**
  * Raspberry Pi Model B
  * USB-Ethernet adapter (we use one from Apple)
  * Beeline (ex. Corbina) ISP ethernet connection
  * Latest bearouter ISO builded for RPi

**How to use it**
If you just needed to use your RPi as a router:
  * Go to http://bearouter.org/ and download latest release of bearouter ISO for RPi;
  * To use an image file, you will need to unzip it and write it to a suitable SD card using the UNIX tool dd. Windows users should use Win32DiskImager. Do not try to drag and drop or otherwise copy over the image without using dd or Win32DiskImager – it won’t work. If you’re still not clear on what to do, the community on the Raspberry Pi Wiki has written a guide for beginners on how to set up your SD card;
  * Plug in your WAN cable to the ethernet port on RPi and LAN cable to the USB-Ethernet adapter which must be connected to one of USB port;
  * Plug it into power source and wait while it boot up;
  * Restart networking on your computer to optain new IP address from RPi;
  * Open your browser to '192.168.0.1:8080', create a password for accessing configurator, enter your credentials for Beeline (Corbina) ISP and click "Save and connect";
  * Enjoy.

**If you interested in latest beta**
  * Latest beta versions always available at http://bearouter.org/beta. Read section "How to use it" if you didn't know how to run it.
