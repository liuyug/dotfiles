#!/bin/sh

usage()
{
    local prog=`basename $0`
    echo "$prog <ip address> [user name]"
    exit 0
}


if [ "x$1" = "x" ]; then
    usage
else
    IP=$1
fi

if [ "x$2" = "x" ]; then
    USER=Administrator
else
    USER="$2"
fi

rdesktop \
    -u "$USER" \
    -g workarea \
    -P \
    -a 32 \
    -D \
    -x 0x80 \
    -r disk:host=$HOME \
    -T "rdp - $IP" \
    $IP &

#    #define RDP5_DISABLE_NOTHING    0x00  
#    #define RDP5_NO_WALLPAPER   0x01  
#    #define RDP5_NO_FULLWINDOWDRAG  0x02  
#    #define RDP5_NO_MENUANIMATIONS  0x04  
#    #define RDP5_NO_THEMING     0x08  
#    #define RDP5_NO_CURSOR_SHADOW   0x20  
#    #define RDP5_NO_CURSORSETTINGS  0x40    /* disables cursor blinking */  
#    #define RDP5_ENABLE_FONT_SMOOTHING 0x80  
#
#    0x8F # equals the modem default + font smoothing
#    0x81 # equals the broadband default + font smoothing
#    0x80 # equals the LAN default + font smoothing

