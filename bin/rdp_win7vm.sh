#!/bin/sh

IP=192.168.203.20
rdesktop    \
    -u Administrator    \
    -g workarea  \
    -P  \
    -a 32 \
    -D \
    -x l \
    -r disk:host=$HOME  \
    -T "Window 7 - $IP" \
    $IP &


