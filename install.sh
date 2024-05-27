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

DIR="$(pwd)"

# Dependencies
sudo apt install -y bash curl coreutils git micro python3 sassc wget zoxide zsh

# Oh My Zsh
cp ./dotfiles/.zshrc ~/.zshrc
wget -O- "https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh" | \
	KEEP_ZSHRC=yes sh

# OSX El Capitan Cursors by XXMMTRTXX
# https://www.mate-look.org/p/1084939
sudo mkdir -p /usr/share/icons/OSX-ElCapitan || { echo "Fatal error. Root does not have root permissions?"; exit 1; }

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
mkdir -p ~/.themes || { echo "Fatal error. No permissions for your own home folder?"; exit 1; }

## download theme pack
curl -Lfs \
	"https://sourceforge.net/projects/novomente-themes/files/Metacity/Glazy_pack.tar.gz/download" | \
	### extract pack, extract each individual theme
	tar --to-command='tar -xzf - -C ~/.themes' -xzf - --exclude="README*" --strip-components=1

# Skewaita GTK Theme by NESTORT
# https://www.gnome-look.org/p/1768839
cd ~/.themes || { echo "\"~/.themes\" does not exist?"; exit 1; }
git clone https://git.disroot.org/eudaimon/Skewaita.git
cd Skewaita/source/templates || { echo "clone failed"; exit 1; }
bash use_scheme.sh colorscheme-light-blue
cd ..
bash compile.sh light

cd "$DIR" || { echo "Fatal error. Install directory does not exist."; exit 1; }

# Oxylite Icon Theme by MX-2
# https://www.gnome-look.org/p/2055724
sudo git clone https://github.com/mx-2/oxylite-icon-theme/ /usr/share/icons/Oxylite
sudo sed -ie "s/Name=Oxylite icons/Name=Oxylite/" /usr/share/icons/Oxylite/index.theme

# Mint-X Icons by the Linux Mint team
# https://github.com/linuxmint/mint-x-icons
## random number for temp file name
RANDTMP=$( zsh -c "echo $(( RANDOM*13*31*59 ))" )

# install, unzip, move to /usr/share/icons
wget -O "/tmp/mint-x-$RANDTMP.zip" https://github.com/linuxmint/mint-x-icons/archive/refs/heads/master.zip
unzip -qq "/tmp/mint-x-$RANDTMP.zip" "mint-x-icons-master/usr/share/icons/*" -d "/tmp/"
sudo mv -v /tmp/mint-x-icons-master/usr/share/icons/* /usr/share/icons/

## cleanup
rm -rf /tmp/mint-x-*

# combine icon themes
mkdir -p ~/.icons/MASTER
cp ./icons/index.theme ~/.icons/MASTER
