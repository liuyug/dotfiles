#!/bin/sh

dest_dir="$HOME/.local/bin"

cyg_setup_url="https://cygwin.com/setup-x86_64.exe"
cyg_setup="$dest_dir/setup-x86_64.exe"

url="https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg"
target="$HOME/.local/bin/apt-cyg"

echo "Download 'cygwin setup' from $cyg_setup_url"
curl $cyg_setup_url -o $cyg_setup

echo "Download 'apt-cyg' from $url"
curl $url -o $target
chmod +x $target

$target mirror http://mirrors.163.com/cygwin

# vim: tabstop=4 shiftwidth=4 expandtab
