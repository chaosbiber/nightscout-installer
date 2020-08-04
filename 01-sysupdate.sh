#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
  echo "Please run as root"
  exit
fi

apt update
apt upgrade -y
[ -f "/var/run/reboot-required" ]
REBOOT_REQUIRED=$?
if [ $REBOOT_REQUIRED ]; then
	echo "reboot required" # TODO: ask to execute after everything is finished
fi


PRE_INSTALL_PKGS=""

if [ ! -e /usr/lib/apt/methods/https ]; then
    PRE_INSTALL_PKGS="${PRE_INSTALL_PKGS} apt-transport-https"
fi

if [ ! -x /usr/bin/lsb_release ]; then
    PRE_INSTALL_PKGS="${PRE_INSTALL_PKGS} lsb-release"
fi

if [ ! -x /usr/bin/curl ] && [ ! -x /usr/bin/wget ]; then
    PRE_INSTALL_PKGS="${PRE_INSTALL_PKGS} curl"
fi

if [ ! -x /usr/bin/gpg ]; then
    PRE_INSTALL_PKGS="${PRE_INSTALL_PKGS} gnupg"
fi

if [ ! -x /usr/bin/git ]; then
    PRE_INSTALL_PKGS="${PRE_INSTALL_PKGS} git"
fi

if [ ! -x /usr/bin/make ]; then
    PRE_INSTALL_PKGS="${PRE_INSTALL_PKGS} build-essential"
fi

if [ "X${PRE_INSTALL_PKGS}" != "X" ]; then
    echo "Installing packages required for setup:${PRE_INSTALL_PKGS}..."
    apt install -y ${PRE_INSTALL_PKGS}
fi

# timezone selector
dpkg-reconfigure tzdata

# TODO: raspberry pi basic configuration, firewall?
