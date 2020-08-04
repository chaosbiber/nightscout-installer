#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
  echo "Please run as root"
  exit
fi

apt purge -y nodejs
rm /etc/apt/sources.list.d/nodesource.list
apt update
