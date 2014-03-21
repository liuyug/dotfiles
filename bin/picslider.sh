#!/bin/sh

dir=$1
output=$2
rm -f $output

types=$3
if [ "x$types" = "x" ]; then
    types="*.png"
fi

function eecho()
{
    if [ "x$output" = "x" ]; then
        echo -e "$1"
    else
        echo -e "$1" >> $output
    fi
}


eecho "<!DOCTYPE html>\n<html>\n<title>$dir ($types)</title>\n<body>"
for type in ${types}; do
    tmpfile=`mktemp`
    find $dir -name $type > $tmpfile
    sort $tmpfile -o ${tmpfile}_2
    eecho "<div>"
    eecho "<h1>$dir ($type)</h1>"
    curdir=""
    for file in `cat ${tmpfile}_2`; do
        dirname=`dirname $file`
        if [ "$curdir" != "$dirname" ]; then
            if [ "x$curdir" != "x" ]; then
                eecho "</p>"
            fi
            curdir=$dirname
            echo "$curdir"
            eecho "<h2>$curdir</h2>\n<p>"
        fi
        eecho "<img src=\"$file\" title=\"$file\" />"
    done
    eecho "</p>\n</div>"
    rm -f ${tmpfile}
    rm -f ${tmpfile}_2
done

eecho "</body></html>"
