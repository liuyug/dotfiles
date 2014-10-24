#!/bin/sh

LANG=C /usr/bin/7za x -y "$1" | sed -n 's/^Extracting //p' | sed '1!G;h;$!d' | xargs convmv -f gbk -t utf8 --notest >/dev/null 2>/dev/null
