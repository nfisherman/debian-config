#!/bin/sh

# Copyright 2024 Cedar Lehman <ca.lehman05@gmail.com>
# This file is part of nfisherman's debian config.
#
# nfisherman's debian config is free software. It comes without any 
# warranty, to the extent permitted by applicable law. You can 
# redistribute it and/or modify it under the terms of the Do What 
# The Fuck You Want To Public License, Version 2, as published by 
# Sam Hocevar. See http://www.wtfpl.net/ for more details.

# adapted from
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
