#!/bin/bash

. ./ca_common.sh

if [ "x$1" = "x" ]; then
    echo "$0 <common name>"
    exit 0
fi

cn=$1
client_key=$cn.key.pem
client_csr=$cn.csr

openssl genrsa -out certs/$client_key $key_bits

openssl req -new \
    -key certs/$client_key \
    -out $client_csr \
    -subj "$subject/CN=$cn"

echo "output key: certs/$client_key"
echo "output csr: $client_csr"
echo "Please send \"$client_csr\" to CA"
