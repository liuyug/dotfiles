#!/bin/sh

cat <<EOF >11-trackpoint.conf
Section "InputClass"
Identifier    "Trackpoint Wheel Emulation"
MatchProduct    "TPPS/2 IBM TrackPoint|DualPoint Stick|Synaptics Inc. Composite TouchPad / TrackPoint|ThinkPad USB Keyboard with TrackPoint|USB Trackpoint pointing device|Composite TouchPad / TrackPoint"
MatchDevicePath    "/dev/input/event*"
Option    "EmulateWheel"    "true"
Option    "EmulateWheelButton"    "2"
Option    "Emulate3Buttons"    "false"
Option    "XAxisMapping"    "6 7"
Option    "YAxisMapping"    "4 5"
EndSection

EOF
sudo mv 11-trackpoint.conf /usr/share/X11/xorg.conf.d

