#!/bin/bash

function method_x11vnc()
{
    x11vnc -ncache 10 -display :0
    # x11vnc -ncache 10 -usepw -display :0
}

function method_vino()
{
    gsettings set org.gnome.Vino prompt-enabled false
    gsettings set org.gnome.Vino require-encryption false
    gsettings set org.gnome.Vino authentication-methods "['none']"
    # gsettings set org.gnome.Vino authentication-methods "['vnc']"
    # gsettings set org.gnome.Vino vnc-password $(echo -n 'mypasswd'|base64)

    gsettings set org.gnome.desktop.lockdown disable-user-switching true
    gsettings set org.gnome.desktop.lockdown disable-log-out true
    gsettings set org.gnome.desktop.interface enable-animations false

    # gsettings set org.gnome.Vino alternative-port 5910
    # gsettings set org.gnome.Vino use-alternative-port true

    # gsettings get org.gnome.Vino prompt-enabled
    # gsettings get org.gnome.Vino authentication-methods
    # gsettings get org.gnome.Vino require-encryption
    # gsettings get org.gnome.Vino vnc-password

    /usr/lib/vino/vino-server --display :0
}

method="$1"

if [ "x$method" = "x" ]; then
    echo "$0 <x11vnc|vino>"
else
    method_$method
fi
