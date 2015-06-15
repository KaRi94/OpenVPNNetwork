#!/bin/bash

LINK_VAGRANT=https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb

start() {
	dpkg -s virtualbox | grep installed || sudo apt-get install virtualbox
	dpkg -s vagrant | grep installed || (wget -O vagrant.deb $LINK_VAGRANT && sudo dpkg -i vagrant.deb)
	echo 'Starting OpenVPN Network'
	/usr/bin/vagrant up
}

stop() {
	echo 'Stopping OpenVPN Network';
	/usr/bin/vagrant halt
}

delete() {
	echo 'Deleting OpenVPN Network'
	/usr/bin/vagrant destroy -f
	sleep 5
	VBoxManage hostonlyif remove vboxnet0 1>/dev/null 2>&1
	echo 'If you want to delete virtualbox type: sudo apt-get remove virtualbox'
	echo 'If you want to delete vagrant type: sudo apt-get remove vagrant'
}

case "$1" in 
	start)   start ;;
	stop)    stop ;;
	restart) stop; start ;;
	delete) stop; delete;;
	*) echo 'usage: $0 start|stop|restart|delete' >&2
	exit 1
	;;
esac
