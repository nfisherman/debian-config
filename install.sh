#!/bin/sh

# Root check
if [ "$(id -u)" -eq 0 ]; then
	echo "Cannot be run as root. Run as a normal user with sudo priveleges."
	exit
fi

# Already installed check
if [ "${1}" != '--force-install' ] && [ -f ".installed" ]; then 
	echo "Config might've already been installed. Run again with \"--force-install\" to force the script to run."
	exit
fi
touch .installed

# Dependencies
sudo apt install -y curl coreutils micro python3 wget zoxide zsh

# Oh My Zsh
cp ./dotfiles/.zshrc ~/.zshrc
wget -O- "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh" | \
	KEEP_ZSHRC=yes sh

# OSX El Capitan Cursors by XXMMTRTXX
# https://www.mate-look.org/p/1084939
sudo mkdir -p /usr/share/icons/OSX-ElCapitan

## https://unix.stackexchange.com/a/743991
## this took me forever
### get JSON file that contains download info
curl -Lfs "https://www.mate-look.org/p/1084939/loadFiles" | \
	### parse that JSON, get the most recent version's download url (in this case, the last returned item)
	jq -r '.files | .[-1] | .url' | \
	### parse junk characters
	perl -pe 's/\%(\w\w)/chr hex $1/ge' | \
	### download the file
	xargs wget -O- | \
	### extract the cursors to the global icons folder
	sudo tar -xjf - -C /usr/share/icons/OSX-ElCapitan --strip-components=2

# Glazy Metacity Theme by NOVOMENTE
# https://www.mate-look.org/s/Mate/p/1007198
mkdir -p ~/.themes

# download theme pack
curl -Lfs \
	"https://sourceforge.net/projects/novomente-themes/files/Metacity/Glazy_pack.tar.gz/download" | \
	# extract pack, extract each individual theme
	tar --to-command='tar -xzf - -C ~/.themes' -xzf - --exclude="README*" --strip-components=1