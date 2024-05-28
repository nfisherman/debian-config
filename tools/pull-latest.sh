#!/bin/sh

# modified from
# https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8

if ! command -v curl > /dev/null; then
    echo "Fatal error. \"curl\" not found."
    exit 1
elif ! command -v wget > /dev/null; then
    echo "Fatal error. \"wget\" not found."
    exit 1
fi

curl -s https://api.github.com/repos/nfisherman/debian-config/releases/latest | \
    grep "nfisherman-debian-config-*" | \
    cut -d : -f 2,3 | \
    tr -d \" | \
    wget -qi - 

sha256sum --check nfisherman-debian-config-*.sh.DIGESTS || \
    { echo "Download failed. Try again."; rm nfisherman-debian-config-*; exit 1; }
sh nfisherman-debian-config-*.sh "$1"
