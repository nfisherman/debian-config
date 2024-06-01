#!/usr/bin/env bash

# Copyright 2024 Cedar Lehman <ca.lehman05@gmail.com>
# This file is part of nfisherman's debian config.
#
# nfisherman's debian config is free software. It comes without any 
# warranty, to the extent permitted by applicable law. You can 
# redistribute it and/or modify it under the terms of the Do What 
# The Fuck You Want To Public License, Version 2, as published by 
# Sam Hocevar. See http://www.wtfpl.net/ for more details.

# default args
DIR='/opt/nfisherman-debian-config'
while getopts d:v: flag; do
    case "${flag}" in
        d) DIR=${OPTARG};;
        v) VERSION=${OPTARG};;
        *)
            printf "Unknown argument: \'%s\'" "$OPTARG"
            exit 1
            ;;
    esac
done

if [[ $DIR != '' && test -e $DIR ]]; then
    echo
fi

if [[ $VERSION == '' ]]; then
    echo "Argument '-v' is required."
    exit 1
# this regex is for semver (holy shit this is so long)
elif [[ ! $VERSION =~ ^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)(-((0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*)(\.(0|[1-9][0-9]*|[0-9]*[a-zA-Z-][0-9a-zA-Z-]*))*))?(\+([0-9a-zA-Z-]+(\.[0-9a-zA-Z-]+)*))?$ ]]; then
    echo "Version number ('-v') must comply with Semantic Versioning (https://semver.org/)."
    exit 1
fi