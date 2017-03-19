#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: `basename $0` [ setup ]"
	echo "       `basename $0` [ show ]"
	echo "       `basename $0` [ samba ]"
	exit
fi


if [ "$1" == "setup" ]; then
	sudo apt-get update -y
	sudo apt-get dist-upgrade -y
	sudo apt-get install -y samba samba-common-bin
	sudo apt-get install apache2 -y
fi

if [ "$1" == "samba" ]; then
	echo "[drive]" >> /etc/samba/smb-shares.conf
	echo "browsable = yes" >> /etc/samba/smb-shares.conf
	echo "read only = no" >> /etc/samba/smb-shares.conf
	echo "valid users = osmc" >> /etc/samba/smb-shares.conf
	echo "path = /cdrive" >> /etc/samba/smb-shares.conf
	echo "comment = My Home Drive" >> /etc/samba/smb-shares.conf
	sudo service restart smb
fi


if [ "$1" == "samba" ]; then
	echo "Not Yet!"
fi

