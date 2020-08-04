#!/bin/bash

if [[ $(id -u) -eq 0 ]]; then
  echo "Please don't run as root"
  exit
fi

APISECRET=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)
MONGOPW=$(cat mongopw.txt)
echo $APISECRET > apipw.txt

cat starter.sh | sed "s/MYMONGOPW/${MONGOPW}/" | sed "s/MYAPISECRET/${APISECRET}/" > ${HOME}/start_nightscout.sh

if [ ! -d "${HOME}/nightscout-git" ]; then
	git clone https://github.com/nightscout/cgm-remote-monitor.git ${HOME}/nightscout-git
fi

# get latest release version https://gist.github.com/lukechilds/a83e1d7127b78fef38c2914c4ececc3c
#curl --silent "https://api.github.com/repos/nightscout/cgm-remote-monitor/releases/latest" | # Get latest release from GitHub api
#  grep '"tag_name":' |                                            # Get tag line
#  sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value

# TAG=$(curl --silent "https://api.github.com/repos/nightscout/cgm-remote-monitor/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

#TODO: let the user select a version - or only choose between master and dev?


cd ${HOME}/nightscout-git
git fetch --all
# latest tags
# git tag -l "[0-9]*" --sort=version:refname | tail -n 4

# git branch --contains tags/$TAG

git checkout master
npm install
# failed on test VM with 1gb of RAM, simply retry
RESULT=$?
if [ $RESULT -ne 0 ]; then
	npm install
fi

echo "Nightscout installation (alpha) finished. Try to run ${HOME}/start_nightscout.sh"
