#!/bin/bash

sudo apt-get install openvpn tcpdump ntpdate -y
sudo /etc/init.d/openvpn stop

# Datetime configuration
sudo rm /etc/localtime
sudo ln -s /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
sudo /usr/sbin/ntpdate tempus1.gum.gov.pl

# OpenVPN configuration
sudo rm -r /etc/openvpn/
sudo mv /tmp/openvpn/ /etc/openvpn/
sudo chown -R root:root /etc/openvpn
sudo chmod -R 755 /etc/openvpn

if [ $1 = "II" ]; then
	sudo apt-get install bridge-utils -y
elif [ $1 = "III" ]; then
	# Firewall configuration
	INTERNAL_NETWORK=`echo $2 | cut -d"." -f1-3`".0/24"
	sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
	sudo /sbin/iptables -t nat -I POSTROUTING -s $INTERNAL_NETWORK -j MASQUERADE
	sudo /sbin/iptables -t nat -I POSTROUTING -s 10.10.10.0/24 -j MASQUERADE
fi

sudo /etc/init.d/openvpn start
