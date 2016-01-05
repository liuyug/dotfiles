#!/bin/bash

# parameter
OUTPUT_FORMAT="-f bestvideo[ext=mp4]+bestaudio[ext=m4a]"

OUTPUT_FILENAME=
# OUTPUT_FILENAME="-o %%(playlist)s_by_%%(uploader)s/%%(playlist_index)s.%%(title)s.%%(format)s.%%(ext)s"

PROXY=
# PROXY="--proxy 127.0.0.1:XXX"

SUBTITLE="--write-sub"

IGNORE_ERROR="-i"

VERBOSE=
# VERBOSE="-v"


down_url()
{
    URL="$@"
    youtube-dl              \
        $VERBOSE            \
        $IGNORE_ERROR       \
        $SUBTITLE           \
        $PROXY              \
        $OUTPUT_FORMAT      \
        $OUTPUT_FILENAME    \
        $URL
}

usage()
{
    echo "Usage:"
    echo ""
    echo "    `basename $0` <url> [url]..."
}

if [ "x$1" == x ]; then
    usage
    exit 1
fi

down_url $@
