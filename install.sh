#!/bin/sh

# Root check
if [ "$(id -u)" -eq 0 ]; then
	echo "Cannot be run as root. Run as a normal user with sudo priveleges."
	exit
fi

# Dependencies
sudo apt install -y coreutils micro python3 wget zoxide zsh

# Oh My Zsh
cp ./dotfiles/.zshrc ~/.zshrc
wget --directory-prefix=downloads --output-document=zsh-install.sh \
	"https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
KEEP_ZSHRC=yes sh downloads/zsh-install.sh
