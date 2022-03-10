#!/bin/bash

. ./ca_common.sh

if [ "x$1" = "x" ]; then
    echo "$0 <client csr> <alter name>"
    echo "alter name: IP:x.x.x.x;DNS:*.x.x"
    exit 0
fi

client_csr=$1
client_cst=$1.cst
alter_name=$2

openssl ca \
    -in $client_csr \
    -out certs/$client_cst \
    -config openssl.cnf \
    -extfile <(echo "subjectAltName=$alter_name") \
    -days $days

echo "output cst: certs/$client_cst"
