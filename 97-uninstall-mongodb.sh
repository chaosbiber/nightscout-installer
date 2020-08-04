#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
  echo "Please run as root"
  exit
fi

systemctl stop mongod.service
systemctl disable mongod.service

apt purge -y mongodb-database-tools mongodb-org-database-tools-extra mongodb-org-mongos mongodb-org-server mongodb-org-shell mongodb-org-tools mongodb-org
rm /etc/apt/sources.list.d/mongodb-org-4.4.list
apt update
read -p "Remove database directory /var/lib/mongodb? Y/n" INPUT
case $INPUT in
	[Yy]* ) rm -r /var/lib/mongodb/ ;;
	[Nn]* ) ;;
	* ) rm -r /var/lib/mongodb/ ;;
esac

