#!/bin/bash

NODEREPO="node_12.x"
DISTRO=$(lsb_release -c -s)
FLAVOR=""
ARCH=""
case $(uname -m) in
    i386)   ARCH="386" ;;
    i686)   ARCH="386" ;;
    x86_64) ARCH="amd64" ;;
    armv6l) ARCH="arm" ;; # raspi 32bit
    arm)    dpkg --print-architecture | grep -q "arm64" && ARCH="arm64" || ARCH="arm" ;;
esac
echo $ARCH

# allowed: focal, buster, bionic, stretch?
case $DISTRO in
	focal|bionic) FLAVOR="ubuntu"; echo "valid ubuntu distro";;
	buster|stretch) FLAVOR="debian"; echo "valid debian distro";;
	*) echo "nonvalid distro";;
esac

