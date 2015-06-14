#!/bin/bash

sudo apt-get install tcpdump ntpdate -y

sudo rm /etc/localtime
sudo ln -s /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
sudo /usr/sbin/ntpdate tempus1.gum.gov.pl

if [ $1 = "II" ]; then
	echo "-"
elif [ $1 = "III" ]; then
	sudo apt-get install nmap -y
	sudo ip ro del default
	sudo ip ro add default via $2
fi
