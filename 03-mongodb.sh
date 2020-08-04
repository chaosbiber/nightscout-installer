#!/bin/bash

if [[ $(id -u) -ne 0 ]]; then
  echo "Please run as root"
  exit
fi

. ./000_helper_lsb.sh
if [ ! -f "/etc/apt/sources.list.d/mongodb-org-4.4.list" ]; then
	if [ "$FLAVOR" == "ubuntu" ]; then
		echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu ${DISTRO}/mongodb-org/4.4 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.4.list
	elif [ "$FLAVOR" == "debian" ]; then
		echo "deb http://repo.mongodb.org/apt/debian ${DISTRO}/mongodb-org/4.4 main" > /etc/apt/sources.list.d/mongodb-org-4.4.list
	fi
	curl -s https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add -
	apt update
fi
MONGOINSTALLED=$(dpkg-query -W -f='${Status}' mongodb-org 2>/dev/null | grep -c "ok installed")
if [ "${MONGOINSTALLED}" -ne "1" ]; then
	apt install -y mongodb-org
else
	echo "mongodb already installed"
fi

chown -R mongodb:mongodb /var/lib/mongodb
systemctl enable mongod.service
systemctl start mongod.service

sleep 5

MONGOPW=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)
echo "$MONGOPW" > mongopw.txt
chmod 777 mongopw.txt

mongo --eval "db.createUser({user: \"nightscoutuser\",pwd: \"$MONGOPW\",roles: [{role: \"readWrite\", db: \"nightscout\"}]})" nightscout
