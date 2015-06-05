#!/bin/bash

# https://dl.bintray.com/mitchellh/vagrant/vagrant_1.7.2_x86_64.deb

start() {
	echo 'Starting OpenVPN Network';
	vagrant up
}

stop() {
	echo 'Stopping OpenVPN Network';
	vagrant halt
}

delete() {
	echo 'Deleteing OpenVPN Network';
	vagrant destroy -f
	VBoxManage hostonlyif remove vboxnet0 1>/dev/null 2>&1
}

case "$1" in 
	start)   start ;;
	stop)    stop ;;
	restart) stop; start ;;
	delete) stop; delete;;
	*) echo "usage: $0 start|stop|restart|delete" >&2
	exit 1
	;;
esac
