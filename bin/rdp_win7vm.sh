#!/bin/sh

IP=192.168.203.20
rdesktop    \
    -u Administrator    \
    -g workarea  \
    -P  \
    -a 32 \
    -D \
    -x 0x80 \
    -r disk:host=$HOME  \
    -T "Window 7 - $IP" \
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

