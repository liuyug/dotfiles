#!/bin/sh

cat <<EOF >50-monitor.conf
Section "Monitor"
    Identifier "Monitor0"
    HorizSync   30 - 80
    VertRefresh 40 - 90
EndSection

Section "Device"
    Identifier "Card0"
    Driver     "vesa"
Endsection

Section "Screen"
    Identifier "Screen0"
    Device     "Card0"
    Monitor    "Monitor0"
    SubSection "Display"
        Viewport 0 0
        Modes "1280x800"
    EndSubSection
EndSection
EOF

sudo mv 50-monitor.conf /usr/share/X11/xorg.conf.d/

