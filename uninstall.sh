#!/bin/sh

# Copyright 2024 Cedar Lehman <ca.lehman05@gmail.com>
# This file is part of nfisherman's debian config.
#
# nfisherman's debian config is free software. It comes without any 
# warranty, to the extent permitted by applicable law. You can 
# redistribute it and/or modify it under the terms of the Do What 
# The Fuck You Want To Public License, Version 2, as published by 
# Sam Hocevar. See http://www.wtfpl.net/ for more details.

# Root check
if [ "$(id -u)" -eq 0 ]; then
	echo "Cannot be run as root. Run as a normal user with sudo privileges."
	exit
fi

response='RAHHHHH'
while [ "${1}" != '-y' ] && [ "${response}" != 'y' ] && \
  [ "${response}" != 'n' ] && [ "${response}" != '' ]; do
	printf "Are you sure you want to uninstall? [y/N] " >&2
	read -r response
	response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
done

if [ "${response}" = 'n' ] || [ "${response}" = '' ]; then
	echo "Aborting."
    exit
fi

echo "Uninstalling..."

sudo rm -rf /usr/share/icons/OSX-ElCapitan
sudo rm -rf /usr/share/icons/Oxylite
sudo rm -rf /usr/share/icons/Mint-X*
sudo rm -rf /usr/share/icons/dist-icons
sudo rm -rf /usr/share/Skewaita

rm -rf ~/.icons/MASTER
rm -rf ~/.themes/Glazy*

rm -f .installed

echo "Themes have been uninstalled."
