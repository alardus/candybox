Candybox
========
### What is Candybox

<p>Candybox turns your Raspberry Pi into router. Just connect RPi to your network, install latest Candybox release on SD card &mdash; and you are online.</p>

<p>The best feature of Candybox router &mdash; it is already fully configured, including all components you may need from your router (dhcp, dns, ddns, pptp, l2tp kernel modules, etc.), and all of them are ready for you to use.</p>

<p>In addition, Candybox supports Netflix and Pandora. As you know, you can't use those web services outside the US. But we eliminated this problem in Candybox: no matter where you are, you can use Netflix and/or Pandora whenever you feel like it.</p>

<p>Another good thing about Candybox is its web control panel. We know how annoying it is to make small changes in router setup through command line. For these situations we created a simple web configurator, which allows you to configure many features that you might need while using your router.</p>

<p>Want to add port forwarding to internal host? &mdash; No problem. Needed to setup DDNS hostname? &mdash; Just put your credential at DDNS section.</p>

<p>Simple, right?</p>

<h3>
<a name="how-its-looks" class="anchor" href="#how-its-looks"><span class="octicon octicon-link"></span></a>What it looks like</h3>

<p>
<a href="http://repo.candyboxrouter.com/img/candybox-setup.png"><img src="http://repo.candyboxrouter.com/img/candybox-setup.png" width="300" height="210"></a>
<a href="http://repo.candyboxrouter.com/img/candybox-info.png"><img src="http://repo.candyboxrouter.com/img/candybox-info.png" width="300" height="210"></a>
</p>

<h3>
<a name="what-do-you-need-to-run-it" class="anchor" href="#what-do-you-need-to-run-it"><span class="octicon octicon-link"></span></a>What you need to run it</h3>

<ul>
<li>Raspberry Pi (model B)</li>
<li>WiFi router (of course you can use any of Raspbian compatible USB WiFi-dongle, but you will need to configure it manually — currently we don’t support them in default settings)</li>
<li>USB-Ethernet adapter (we use one from Apple)</li>
<li>SD card (minimum 2GB and class 10 recommended)</li>
<li>Beeline (ex. Corbina) ISP Ethernet connection</li>
<li>Latest Candybox release build for RPi</li>
</ul><h3>
<a name="how-to-use-it" class="anchor" href="#how-to-use-it"><span class="octicon octicon-link"></span></a>How to use it</h3>

<ul>
<li><a href="http://bearouter.org/beta/">Download</a> latest Candybox release</li>
<li>To use an image file, you need to unzip it and write it on a suitable SD card, using the UNIX tool dd. Windows users should use <a href="http://sourceforge.net/projects/win32diskimager/">Win32DiskImager</a>. Do not try to drag and drop or copy the image without using dd or Win32DiskImager &mdash; it won’t work</li>
<li>Plug in your WAN cable to the RPi Ethernet port and LAN cable to the USB-Ethernet adapter, that is connected to one of the USB ports</li>
<li>Plug in into power source and wait while it’s booting up</li>
<li>Restart network on your computer to obtain new IP address from RPi</li>
<li>Point your browser to '192.168.0.1:8080', create a password for accessing Candybox configurator, enter your credentials for Beeline (ex. Corbina) ISP and click "Save and connect"</li>
</ul><h3>
<a name="technical-overview" class="anchor" href="#technical-overview"><span class="octicon octicon-link"></span></a>Technical overview</h3>

<p><strong>Supported ISPs</strong></p>

<ul>
<li>Beeline (ex. Corbina) over L2TP (for now)</li>

</ul><p><strong>Web interface features</strong></p>
<ul>
<li>Setup internet connection, turn it on or off</li>
<li>Use Netflix and Pandora at any devices at your home</li>
<li>Use DDNS for accessing your home computer with dynamic IP</li>
<li>Manage port forwarding for any services of your home network (eg. torrents or web/ftp server) without manually entering iptables rules</li>
<li>Observe system status and status of its main services</li>

</ul><p><strong>What’s in the box</strong></p>
<ul>
<li>raspbian 'wheezy' with 3.6 kernel and l2tp_* kernel modules</li>
<li>xl2tpd with kernel modules support for decrease CPU loading</li>
<li>dnsmasq as DHCP/DNS server with logging of DHCP leases</li>
<li>set of scripts for monitoring and repairing connection</li>
<li>fail2ban for intrusion prevention</li>
<li>ddclient for DynDNS support</li>
<li>web configurator</li>
</ul><h3>
<a name="authors" class="anchor" href="#authors"><span class="octicon octicon-link"></span></a>Authors</h3>

<p>Candybox was invented and created by:</p>
<ul>
<li>Alexander Bykov (<a href="https://github.com/alardus" class="user-mention">@alardus</a>)</li>
<li>Grigory Bakunov (<a href="https://github.com/bobuk" class="user-mention">@bobuk</a>)</li>
<li>Danil Ivanov (<a href="https://github.com/imfo" class="user-mention">@imfo</a>)</li>
<li>Alexey Markin</li>
<li>Anatoly Lebedev</li>
<li>Tatiana Bykova</li>
</ul>

<h3>
<a name="contributors" class="anchor" href="#contributors"><span class="octicon octicon-link"></span></a>Contributors</h3>

<p>If you want to help make Candybox better, feel free to do so.  Join project on GitHub and make a pull request.</p>