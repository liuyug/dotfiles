#!/bin/bash

function cmd_vnc()
{
    x11vnc -auth ~/.Xauthority -display :99
}

function cmd_vfb()
{
    xvfb-run -f ~/.Xauthority $1
}

if [ "x$1" = "x" ]; then
    echo "$0 vfb <cmd>"
    echo "$0 vnc"
    exit 0
fi


if [ "x$2" = "x" ]; then
    cmd_vnc
else
    cmd_vfb "$2"
fi

