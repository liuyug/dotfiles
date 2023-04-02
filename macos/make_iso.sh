#!/bin/bash

IFS=$'\t\n'

mac_app="$1"
if [ "x$mac_app" = "x" ] ; then
    echo "$0 <mac app path>"
    exit 0
fi

ventura_size=14000m
catalina_size=9000m
high_sierra_size=5500m
mojave_size=6000m

app_label=`basename $mac_app .app`
iso_file="tmp_macos"

set -x

rm -f ${iso_file}.cdr ${iso_file}.cdr.dmg

hdiutil create -o ${iso_file}.cdr -size ${ventura_size} -layout SPUD -fs HFS+J
hdiutil attach ${iso_file}.cdr.dmg -noverify -mountpoint /Volumes/macos_install
sudo "$mac_app/Contents/Resources/createinstallmedia" --volume /Volumes/macos_install

hdiutil detach "/Volumes/${app_label}"
hdiutil detach /Volumes/macos_install

hdiutil convert -format UDTO -o ${iso_file}  ${iso_file}.cdr.dmg
rm ${iso_file}.cdr.dmg
mv ${iso_file}.cdr ${app_label}.iso
