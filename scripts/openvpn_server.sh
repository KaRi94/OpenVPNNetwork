#!/bin/bash

OPENVPN_SERVER_NAME='openvpn-server'

sudo apt-get install openvpn vim easy-rsa -y

mkdir /etc/openvpn/easy-rsa && cd /etc/openvpn/easy-rsa

cp -r /usr/share/easy-rsa/* .

source vars
# Appears almost empty keys catalog
./clean-all
# ca.crt & ca.key appears in keys catalog
./build-ca
# myserver.crt myserver.cst myserver.key appears in keys; other files changing
./build-key-server $OPENVPN_SERVER_NAME
# dh1024.pem appears in keys
./build-dh

# At the end, for working server, we need following files:
# * ca.crt 
# * ca.key (actually, work without it)
# * myserver.crt
# * myserver.cst
# * myserver.key
# * dh1024.pem

# Only .key files need to be kept secret, .crt and .csr files can be sent over
# insecure channels such as plaintext email. But ca.key and ca.crt are required
# for creating new certificates.