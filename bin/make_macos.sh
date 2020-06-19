#!/bin/bash

Catalina_size=9000m
Mojave_size=6000m
High_Sierra_size=5500m

function app_to_dmg()
{
    app_label=`basename $mac_app .app`
    os_name=`echo $app_label | cut -d" " -f 3`
    size_0=${os_name}_size
    size=${!size_0}
    dmg_name="temp_dmg"

    sudo hdiutil create -o ${dmg_name}.dmg \
        -size $size -layout SPUD -fs HFS+J
    mkdir $dmg_name
    sudo hdiutil attach ${dmg_name}.dmg \
        -noverify -mountpoint $dmg_name
    sudo "$mac_app/Contents/Resources/createinstallmedia" \
        --volume $dmg_name

    sudo hdiutil detach "/Volumes/${app_label}"
    rmdir $dmg_name
    sudo mv ${dmg_name}.dmg $output/${app_label}.dmg
    echo "You can convert dmg to iso by use 'dmg2img <dmg> <iso>' or 'sudo hdiutil convert -format UDTO -o <iso>  <dmg>'"
}

function app_to_iso()
{

    app_label=`basename $mac_app .app`
    os_name=`echo $app_label | cut -d" " -f 3`
    size_0=${os_name}_size
    size=${!size_0}
    iso_name="temp_iso"

    sudo hdiutil create -o ${iso_name}.cdr \
        -size $size -layout SPUD -fs HFS+J
    mkdir $iso_name
    sudo hdiutil attach ${iso_name}.cdr.dmg \
        -noverify -mountpoint $iso_name
    sudo "$mac_app/Contents/Resources/createinstallmedia" \
        --volume $iso_name

    sudo hdiutil detach "/Volumes/${app_label}"
    rmdir $iso_name
    sudo hdiutil convert -format UDTO -o $output/${iso_name}  ${iso_name}.cdr.dmg
    sudo rm ${iso_name}.cdr.dmg
    sudo mv $output/${iso_name}.cdr $output/${app_label}.iso
}

function app_to_usb()
{
    sudo "$mac_app/Contents/Resources/createinstallmedia" \
        --volume $output
}

cmd="$1"
mac_app="$2"
output="$3"

IFS=$'\t\n'

if [ "x$cmd" = "x" ] ; then
    echo "制作之前，请先运行原盘的'Install MacOS app'，确保正确"
    echo "制作之后，运行启动盘里的'Install MacOS app'，确保正确"
    echo "$0 <usb|iso|dmg> <mac app path> <output path>"
    exit 0
fi

app_to_$cmd


# vim: tabstop=4 shiftwidth=4 expandtab
