# Nightscout Installer (for Raspberry Pi & Linux in general)

## Status
proof-of-concept / early alpha: first scripts that led to a successful installation. Multiple script files for simpler testing.

## Objectives

Tutorial and all-in-one script to install and update [Nightscout](https://github.com/nightscout/cgm-remote-monitor) on a Raspberry Pi 3 or 4 as well as Ubuntu and Debian Linux distributions on web servers. Full instructions and functionality for home installations (Pi) and partially for web hosts. To access the local Pi from the internet or at least to renew letsencrypt certificates regularly, port forwarding or firewall rule adjustments in the home router are required.

## Difficulties

### MongoDB Versions
MongoDB 3+ packages are only available for 64bit systems and especially on arm64 for Ubuntu 18.04 and 20.04 only. TODO: check if it installs somehow on Debian as well. https://www.mongodb.com/try/download/community

### Raspberry Pi 64bit
Raspbian, the default Debian based Raspberry Pi images, have no 64 bit release up until today. This might change because of the 8gb RAM model and a beta version is already there.

Raspbian Beta: https://www.raspberrypi.org/forums/viewtopic.php?t=275370
(Debian based -> no mongodb packages for arm64 yet)

Ubuntu: https://ubuntu.com/download/raspberry-pi :arrow_left: **main focus**

More possibilities: Gentoo, Arch Linux

### DynDNS for hosting@home
Good providers (both global and German origin because of privacy)?

### Router configurations for hosting@home
* ondemand for cert renewals: https://www.oshelp.co.uk/?p=163
* for permanent access we should link to instructions for the most common routers or at least key words to find them

## Sources

[Variables (Nightscout-docs, german)](https://nightscout.gitbooks.io/user_guide/content/de/nightscout/azure_plugins.html#plugins)
