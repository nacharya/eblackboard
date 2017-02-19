#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: `basename $0` [ cdrive ]"
	echo "       `basename $0` [ upgrade ]"
	echo "       `basename $0` [ content ]"
	echo "       `basename $0` [ samba ]"
	exit
fi

if [ "$1" == "cdrive" ]; then
	blkid
	echo ""
	echo "Now copy the UUID listed above for  your drive"
	mkdir -p /cdrive
	echo ""
	echo ""
	echo "if the contentdrive is /dev/sda1 .."
	echo "add the folowing to /etc/fstab"
	echo "Add the following to the /etc/fstab"
	echo "UUID=D6502B30502B1731   /cdrive  ntfs    defaults,errors=remount-ro 0       1"
	echo ""
	echo "Use the UUID that you copied earlier"	
	exit
fi

if [ "$1" == "upgrade" ]; then
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


if [ "$1" == "content" ]; then
	echo "Retrieve EPaath ... "
	URL="http://download.olenepal.org/EPaath.tar"
	# sudo wget --continue http://download.olenepal.org/EPaath.tar
	FILE=`dirname $URL`
	if [ -f /cdrive ]; then
		cp $FILE /cdrive
		cd /cdrive; tar xvf $FILE
	fi
	if [ -d /cdrive/EPaath ]; then
		ln -s /cdrive/EPaath /var/www/html/EPaath
		sudo service restart apache2
	fi
fi

