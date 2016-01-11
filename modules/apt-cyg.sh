#!/bin/sh

url="https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg"
target="$HOME/.local/bin/apt-cyg"

echo "Download 'apt-cyg' from $url"
curl $url -o $target
chmod +x $target

# vim: tabstop=4 shiftwidth=4 expandtab
