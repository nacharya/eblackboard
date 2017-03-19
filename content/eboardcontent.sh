#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: `basename $0` [ cdrive ]"
	echo "       `basename $0` [ setup ]"
	echo "       `basename $0` [ show ]"
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

if [ "$1" == "setup" ]; then
	sudo apt-get update -y
	sudo apt-get dist-upgrade -y
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

if [ "$1" == "show" ]; then
	echo "Not Yet!"
fi
