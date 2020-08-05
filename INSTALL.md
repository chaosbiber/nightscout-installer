# Nightscout installation docs (WIP!)

## Needed hardware

* Raspberry Pi 3 or 4
* Power cable and adapter with 5V/2.5A to 3A. When unsure I'd recommend the original
* microSD card minimum 8GB, 16 or 32 recommended (e.g. Samsung Evo Plus or Sandisk Ultra)
* Card reader for computer or laptop
* Network access (ethernet cable recommended, but WiFi is onboard and possible)

Optional but useful:
* case for the Pi

Optional for direct access:
* HDMI (Pi 3) or micro HDMI (Pi 4) cable and available monitor with HDMI input
* USB keyboard

Recommendation is no to use the display but remote access instead because with that Ubuntu image all you see is a big "shell" on your screen for command inputs, installing a desktop environment is not part of this tutorial. Remote access makes it easier to copy the commands.

## Step 1: RPi preparations

### Option 1:

[Ubuntu Raspberry Pi downloads](https://ubuntu.com/download/raspberry-pi)

* Choose, depending on your model, the Raspberry Pi 3 or 4, Ubuntu 20.04 and 64bit version for download
* downloaded file is named `ubuntu-20.04-preinstalled-server-arm64+raspi.img.xz`
* flash image onto microSD card with TODO+extraction (Windows), balenaEtcher (OSX) or TODO (Linux)

### Option 2:
use
* https://downloads.raspberrypi.org/imager/imager.exe for Windows
* https://downloads.raspberrypi.org/imager/imager.dmg for OSX
* https://downloads.raspberrypi.org/imager/imager_amd64.deb for Ubuntu/Debian Linux

and follow the application's instructions to install Ubuntu 20.04 64bit for your Pi 3 or 4 onto the microSD card

Source: https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi#2-prepare-the-sd-card

### Preparations for wifi access
If you can use an ethernet cable, e.g. put the Pi via a short cable next to your internet router, you can skip this step.

TODO: https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi#3-wifi-or-ethernet

### Connection

Put the microSD card into the Raspberry Pi and connect power and ethernet if available.

## First contact

### Boot and identify IP or hostname

* via `arp`: https://ubuntu.com/tutorials/how-to-install-ubuntu-on-your-raspberry-pi#4-boot-ubuntu-server
* ping ubuntu
* Router DHCP leases

### connect

* `ssh ubuntu@ubuntu` or `ubuntu@<found ip>`
* password ubuntu
* forced to change password immediately

```
WARNING: Your password has expired.
You must change your password now and login again!
Changing password for ubuntu.
Current password: <enter ubuntu>
New password: <enter and write down a new password>
Retype new password: <repeat new password>
passwd: password updated successfully
Connection to 10.0.0.110 closed.
```

* connect again with new password
* `curl -s https://raw.githubusercontent.com/chaosbiber/nightscout-installer/master/01-sysupdate.sh | sudo bash`

TODO:
unattended upgrades - wait for them

(not working:) `pgrep -x "/usr/bin/python3 /usr/bin/unattended-upgrade"`

## to be continued...
* scripts 2-4 (single one in future)
* nginx
* DynDNS
* Router setttings

# Frequent problems

`sudo apt` commands fail: unattended upgrades in progress. wait till finished

When connecting via ssh:
```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
```
Can happen if you use different Raspberry Pi devices or your router gives the same IP address to different hosts. Important warning that you don't trust the wrong device, but often false alarm in dynamic environments. To allow it: `ssh-keygen -R <entered host>` e.g. when you entered `ssh ubuntu@192.168.1.101` then use `ssh-keygen -R 192.168.1.101`
