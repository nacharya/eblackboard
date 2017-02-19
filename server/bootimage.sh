#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: `basename $0` [ drivename ]"
	echo "       `basename $0` [ getimage ] [ osmc/ubuntu/openelec/rasbian ]"
	echo "       `basename $0` [ burn ] [ drivename ]"
	exit
fi

if [ "$1" == "drivename" ]; then
	diskutil list
	exit
fi 

if [ "$1" == "getimage" ]; then
	if [ "$2" == "osmc" ]; then
		URL="http://download.osmc.tv/installers/diskimages/OSMC_TGT_rbp2_20170210.img.gz"
#IMG=OSMC_TGT_rbp2_20170129.img
	fi
	if [ "$2" == "raspbian" ]; then
		URL="https://downloads.raspberrypi.org/raspbian_latest"
#IMG=raspbian-jessie.img
	fi
	if [ "$2" == "openelec" ]; then
		URL="http://openelec.tv/get-openelec/category/57-raspberry-pi2-builds?download=101:raspberry-pi-2-and-pi3-model-b-512mb-diskimage"
#IMG=OpenELEC-RPi2.arm-7.0.1.img
	fi
	if [ "$2" == "ubuntu" ]; then
		URL="http://releases.ubuntu.com/ubuntu-core/16/ubuntu-core-16-pi3.img.xz"
#IMG=ubuntu-core-16-pi3.img
	fi
	wget -c $URL
	echo `basename $URL` > imagename
	exit
fi

if [ -f imagename ]; then
	export IMG=`cat imagename`
else
	echo "       `basename $0` [ getimage ] [ osmc/ubuntu/openelec/rasbian ]"
	exit
fi

if [ "$1" == "burn" ]; then
	if [ -z "$2" ]; then
		echo "       `basename $0` [ burn ] [ drivename ]"
		exit
	fi
	DISK=$2
	RDISK=r$2
	diskutil umountDisk /dev/$DISK
	echo "Burn .. $IMG ...$RDISK ..."
	sudo dd bs=1m if=$IMG of=/dev/$RDISK
fi

