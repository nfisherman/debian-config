#!/bin/sh

# modified from
# https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8

if ! command -v curl > /dev/null; then
    echo "Fatal error. \"curl\" not found."
    exit 1
fi

curl -s https://api.github.com/repos/nfisherman/debian-config/releases/latest | \
    grep "nfisherman-debian-config-*.sh" | \
    cut -d : -f 2,3 | \
    tr -d \" | \
    wget -qi - 

sh nfisherman-debian-config-*.sh "$1"