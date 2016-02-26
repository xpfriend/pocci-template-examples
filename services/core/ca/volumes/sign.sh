#!/bin/bash
set -eu

cd /ssl
rm demoCA/index.txt
touch demoCA/index.txt
openssl ca -policy policy_anything -days 9999 -batch -in $1 -cert ./public/cacerts/pocci-root-ca.crt -out $2
