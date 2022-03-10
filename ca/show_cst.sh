#!/bin/bash

if [ "x$1" = "x" ]; then
    echo "$0 <cst>"
    exit 0
fi
client_cst=$1

openssl x509 -in $client_cst -text -noout
