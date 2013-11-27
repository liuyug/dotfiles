#!/bin/sh

IP=$1
rdesktop    \
    -g workarea  \
    -P  \
    -a 32 \
    -D \
    -x 0x80 \
    -r disk:host=$HOME  \
    -T "eClient - $IP"  \
    $IP &
