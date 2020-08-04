#!/bin/bash

if [[ $(id -u) -eq 0 ]]; then
  echo "Please don't run as root"
  exit
fi

rm -rf ${HOME}/nightscout-git
rm -r ${HOME}/.cache/node-gyp
rm -rf ${HOME}/.npm
