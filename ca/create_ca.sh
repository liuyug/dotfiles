#!/bin/bash

. ./ca_common.sh

mkdir -p certs newcerts private

echo "01" > serial
touch index.txt


cp /etc/ssl/openssl.cnf .
sed -i "s/\.\/demoCA/\.\//" openssl.cnf

# create CA private key
openssl genrsa -out private/$cakey $key_bits

# create CA certificate(public key + other information)
openssl req -new -x509 \
    -key private/$cakey \
    -out $cacert \
    -days $days \
    -config openssl.cnf \
    -subj $subject

echo "cakey: private/$cakey"
echo "cakey: $cacert"

