#!/bin/bash

# LANG=C /usr/bin/7za x -y "$1" | sed -n 's/^Extracting //p' | sed '1!G;h;$!d' | xargs convmv -f gbk -t utf8 --notest >/dev/null 2>/dev/null


if [ "x$1" = "x" ]; then
    echo "unzip.sh <zip file>"
    exit 0
fi

LANG=C /usr/bin/7za x -y "$1"

echo "Please run \"convmv -f gbk -t utf8 --notest -r .\""
