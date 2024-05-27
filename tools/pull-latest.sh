#!/bin/sh

# modified from
# https://gist.github.com/steinwaywhw/a4cd19cda655b8249d908261a62687f8

curl -s https://api.github.com/repos/nfisherman/debian-config/releases/latest | \
    grep "nfisherman-debian-config-*.sh" | \
    cut -d : -f 2,3 | \
    tr -d \" | \
    wget -O- -qi - | \
    sh