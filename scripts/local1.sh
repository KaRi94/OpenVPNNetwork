#!/bin/bash

if [ $1 = "II" ]; then
	sudo apt-get install isc-dhcp-server -y
	sudo mv /tmp/dhcpd.conf /etc/dhcp/dhcpd.conf
	sudo mv /tmp/isc-dhcp-server /etc/default/isc-dhcp-server
	sudo service isc-dhcp-server restart
elif [ $1 = "III" ]; then
	sudo apt-get install apache2 -y
fi
