#!/bin/bash

if [ -z "$1" ]; then
	echo "Usage: `basename $0` [ setup ]"
	echo "       `basename $0` [ show ]"
	exit
fi

if [ "$1" == "setup" ]; then
	echo ""

	# add the repo key first
	wget -qO - http://bintray.com/user/downloadSubjectPublicKey?username=bintray | sudo apt-key add -

	# add source to the source list
	echo "deb http://dl.bintray.com/kusti8/chromium-rpi jessie main" | sudo tee -a /etc/apt/sources.list

	# 
	sudo apt-get update

	# install chromium
	sudo apt-get install chromium-browser -y

	wget http://ports.ubuntu.com/pool/universe/c/chromium-browser/chromium-browser-l10n_48.0.2564.82-0ubuntu0.15.04.1.1193_all.deb
	wget http://ports.ubuntu.com/pool/universe/c/chromium-browser/chromium-browser_48.0.2564.82-0ubuntu0.15.04.1.1193_armhf.deb
	wget http://ports.ubuntu.com/pool/universe/c/chromium-browser/chromium-codecs-ffmpeg-extra_48.0.2564.82-0ubuntu0.15.04.1.1193_armhf.deb

	sudo dpkg -i chromium-codecs-ffmpeg-extra_48.0.2564.82-0ubuntu0.15.04.1.1193_armhf.deb
	sudo dpkg -i chromium-browser-l10n_48.0.2564.82-0ubuntu0.15.04.1.1193_all.deb chromium-browser_48.0.2564.82-0ubuntu0.15.04.1.1193_armhf.deb


	# install pepper flash 
	wget http://www.novaspirit.com/wp-content/uploads/2016/06/flash21.tar.xz

	tar -xJf flash21.tar.xz
	sudo cp pepper/*.so /usr/lib/chromium-browser/plugins
	sudo cp pepper/*.json /usr/lib/chromium-browser/plugins

	CHROMIUM_FLAGS="${CHROMIUM_FLAGS} -- ppapi-flash- path=/usr/lib/chromium-browser/plugins/libpepflashplayer.so -- ppapi-flash- version=21.0.0.182-r1 -password- store=detect -user- data-dir"

fi


if [ "$1" == "setup" ]; then
	echo "Not Yet!"

fi

