# Networking on Linux

{:.no_toc}

<h2 id="toc-header">Table of Contents <i class="fa fa-chevron-up" aria-hidden="true" id="toc-arrow"></i></h2>
* Will be replaced with the ToC, excluding the "Contents" header
{:toc}



- `ifconfig` get information about network interfaces
-  `dhclient` releases and renews the ip address
-  dont forget to restart the network service

### Configuration files (Ubuntu)
- `sudo vim /etc/network/interfaces`
	- file that controls ip address ect for the stream
	- `auto eth0`
		- eth0 is the first network interface (card)
		- auto decide the speed
	- `iface eth0 inet static`
		- interface eth0 inet is static
		- replace static with dhcp to use dhcp without the below config
	- `address 10.1.10.5`
	- `netmask 255.255.255.0`
	- `network 10.1.10.0`
	- `broadcast 10.1.10.255`
		- ip that all network attached hosts receive messages from
	- `gateway 10.1.10.1`
- `sudo vim /etc/resolv.conf`
	- dns server information
	- list dns address to use
- `sudo vim /bin/hostname`
	- echos hostname
- set hostname in `/etc/hostname` and `/etc/hosts`
	- sets hostname

### Ping
- useful for troubleshooting	
- `ping 10.1.10.1`
	- ping router
- `ping website.com`
	- check dns

### UFW firewall
- built in ubuntu firewall
- `sudo ufw status`
	- show the status of the firewall
- `sudo ufw default allow/deny`
	- default rule
- `sudo ufw enable/disable`
	- turn on or off the firewall
- `sudo ufw allow/deny port/protocal`
	- `sudo ufw allow 80/tcp`
	- allow or deny certain ports and protocols
- `sudo ufw delete allow/deny port/protocal`
	- delete rule
- `sudo ufw allow/deny from ip-address`
	- allow or deny traffics from an ip address
	- also supports wildcards
- `sudo ufw allow from 207.80.1.16 to 22`
	- allow ip access to port

		
		
		
		
		