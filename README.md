Candybox
========
### What is Candybox

<p>Candybox turns your Raspberry Pi into router. Just put RPi in your network, install latest Candybox release on SD card &mdash; and you are online.</p>

<p>One of great feature of Candybox router &mdash; it fully configured, with all components that you may need from router (dhcp, dns, ddns, pptp, l2tp kernel modules, etc) and all of they are ready to run out of the box.</p>

<p>In addition it supports Netflix and Pandora. As you know, you can't use those web services in case you are living outside the US. But we eliminated this problems in Candybox &mdash; no matter where you are living, you can use what you want and where you want it.</p>

<p>Another good thing &mdash; is a web control panel. We know how annoying to make small changes in router setup through command line. For those situations we created a simple web configurator that allow to configure many of features that people needed from router. </p>

<p>Want to add port forwarding to internal host? &mdash; No problem. Needed to setup DDNS hostname? &mdash; Just put your credential at DDNS section.</p>

<p>Simple, right?</p>

<h3>
<a name="how-its-looks" class="anchor" href="#how-its-looks"><span class="octicon octicon-link"></span></a>How it's looks</h3>

<p>
<a href="http://img-fotki.yandex.ru/get/9324/7694291.6b/0_8e3ab_71311ea1_XL.png"><img src="http://img-fotki.yandex.ru/get/9324/7694291.6b/0_8e3ab_71311ea1_M.png"></a>
<a href="http://img-fotki.yandex.ru/get/9313/7694291.6b/0_8e3ac_a72a8554_XL.png"><img src="http://img-fotki.yandex.ru/get/9313/7694291.6b/0_8e3ac_a72a8554_M.png"></a>
</p>

<h3>
<a name="what-do-you-need-to-run-it" class="anchor" href="#what-do-you-need-to-run-it"><span class="octicon octicon-link"></span></a>What do you need to run it</h3>

<ul>
<li>Raspberry Pi (model B)</li>
<li>WiFi router (of course you can use any of Raspbian compatible USB WiFi-dongle, but you will need to configure it manualy &mdash; currently we haven't support for them in default settings)</li>
<li>USB-Ethernet adapter (we use one from Apple)</li>
<li>SD card (minimum 2GB and class 10 recommended)</li>
<li>Beeline (ex. Corbina) ISP ethernet connection</li>
<li>Latest Candybox release builded for RPi</li>
</ul><h3>
<a name="how-to-use-it" class="anchor" href="#how-to-use-it"><span class="octicon octicon-link"></span></a>How to use it</h3>

<ul>
<li><a href="http://bearouter.org/beta/">Download</a> latest Candybox release</li>
<li>To use an image file, you will need to unzip it and write it to a suitable SD card using the UNIX tool dd. Windows users should use <a href="http://sourceforge.net/projects/win32diskimager/">Win32DiskImager</a>. Do not try to drag and drop or otherwise copy over the image without using dd or Win32DiskImager &mdash; it won’t work. If you’re still not clear on what to do, the community on the Raspberry Pi Wiki has written a guide for beginners on how to set up your SD card</li>
<li>Plug in your WAN cable to the ethernet port on RPi and LAN cable to the USB-Ethernet adapter which must be connected to one of USB port</li>
<li>Plug in into power source and wait while it booting up</li>
<li>Restart networking on your computer to optain new IP address from RPi</li>
<li>Point your browser to '192.168.0.1:8080', create a password for accessing configurator, enter your credentials for Beeline (ex. Corbina) ISP and click "Save and connect"</li>
</ul><h3>
<a name="technical-overview" class="anchor" href="#technical-overview"><span class="octicon octicon-link"></span></a>Technical overview</h3>

<p><strong>Supported ISPs</strong></p>

<ul>
<li>For now only Beeline (ex. Corbina) over L2TP supported</li>
</ul><p><strong>Web interface features</strong></p>

<ul>
<li>Setup internet connection, turn it on or off</li>
<li>Use Netflix and Pandora at any devices at your home</li>
<li>Use DDNS for accessing your home computer with dynamic IP</li>
<li>Manage port forwarding for any services in your home network (eg. torrents or web/ftp server) without manually entering iptables rules</li>
<li>Observe the state of the system and it main services </li>
</ul><p><strong>What in the box</strong></p>

<ul>
<li>raspbian 'wheezy' with 3.6 kernel and l2tp_* kernel modules</li>
<li>xl2tpd with kernel modules support for decrease CPU loading</li>
<li>dnsmasq as DHCP/DNS server with logging of DHCP leases</li>
<li>set of scripts for monitoring and repairing connection</li>
<li>fail2ban for intrusion prevention</li>
<li>ddclient for DynDNS support </li>
<li>web configurator</li>
</ul><h3>
<a name="authors" class="anchor" href="#authors"><span class="octicon octicon-link"></span></a>Authors</h3>

<p>Candybox was imagined and created by:</p>

<ul>
<li>Alexander Bykov (<a href="https://github.com/alardus" class="user-mention">@alardus</a>)</li>
<li>Grigory Bakunov (<a href="https://github.com/bobuk" class="user-mention">@bobuk</a>)</li>
<li>Danil Ivanov (<a href="https://github.com/imfo" class="user-mention">@imfo</a>)</li>
<li>Alexey Markin</li>
<li>Anatoly Lebedev </li>
</ul>

<h3>
<a name="contributors" class="anchor" href="#contributors"><span class="octicon octicon-link"></span></a>Contributors</h3>

<p>If you want to help make it better &mdash; you are welcome.<br>
Join project on GitHub and make a pull request.</p>
