#!/bin/bash

if [ "x$1" = "x" ]; then
    echo "$0 <csr>"
    exit 0
fi
client_csr=$1
openssl req -in $client_csr -text -noout
