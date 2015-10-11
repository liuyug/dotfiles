#!/bin/bash

cut_dirs=$1
url=$2

if [ "x$url" = "x" ];then
    echo "$(basename $0) <cut_dirs> <url>"
    exit 1
fi
wget -c -m -nH -np --cut-dirs="$cut_dirs" -B "$url" "$url"

# vim: tabstop=4 shiftwidth=4 expandtab
