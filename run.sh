#!/bin/bash

cd ~/Tools/testssl.sh/

echo "-=[ CipherSuite Testing Tool ]=-"
#read -p '[!] URL: ' targetURL

targetURL=$1
fullURL="$targetURL:443"

echo "[!] Running TestSSL against: $targetURL"
testssl -P $fullURL > /tmp/cipher-suite.txt

echo "[*] Parsing out Identified Ciphers"
cat /tmp/cipher-suite.txt | grep 'TLS_' | awk '{print $7}' | grep 'TLS_' > /tmp/cipher-suite-ciphers.txt

echo "[*] Checking Ciphers against CipherSuite API"
cd ~/Tools/ciphersweet/
for x in $(cat /tmp/cipher-suite-ciphers.txt); do python3 cipher_check.py $x; done

echo "Cleaning up generated files."
rm /tmp/cipher-suite.txt /tmp/cipher-suite-ciphers.txt
echo "Thank for using"

