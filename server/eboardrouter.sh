#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: `basename $0` [ setup ]"
	echo "       `basename $0` [ hostad ]"
	echo "       `basename $0` [ show ]"
	exit
fi

if [ "$1" == "setup" ]; then
	echo ""
	sudo apt-get update
	sudo apt-get install hostapd isc-dhcp-server

fi

if [ "$1" == "hostad" ]; then
	wget https://github.com/jenssegers/RTL8188-hostapd/archive/v1.1.tar.gz
	tar -zxvf v1.1.tar.gz
	cd RTL8188-hostapd- 1.1/hostapd
	sudo make
	sudo make install
fi


if [ "$1" == "show" ]; then
	echo "Not Yet!"
fi
