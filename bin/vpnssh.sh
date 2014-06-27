#!/bin/sh

usage()
{
    local prog=`basename $0`
    echo "$prog <user name> <host name>"
    exit 0
}

if [[ "x$1" = "x" || "x$2" = "x" ]]; then
    usage
else
    user=$1
    host=$2
fi

# -f background
# -p remote port

ssh -qTnN -D 7070 $user@$host -p 22

