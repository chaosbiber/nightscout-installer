#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
  echo "Please run as root"
  exit
fi

. ./000_helper_lsb.sh
if [ ! -f "/etc/apt/sources.list.d/nodesource.list" ]; then
	echo "deb https://deb.nodesource.com/${NODEREPO} ${DISTRO} main" > /etc/apt/sources.list.d/nodesource.list
	echo "deb-src https://deb.nodesource.com/${NODEREPO} ${DISTRO} main" >> /etc/apt/sources.list.d/nodesource.list
	curl -s https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
	apt update
fi
NODEINSTALLED=$(dpkg-query -W -f='${Status}' nodejs 2>/dev/null | grep -c "ok installed")
if [ "${NODEINSTALLED}" -ne "1" ]; then
	apt install -y nodejs
else
	echo "nodejs already installed"
fi
