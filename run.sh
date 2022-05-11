#!/bin/bash

# Define location for 'testssl' install
TESTSSL_INSTALL_LOCATION="../testssl.sh"
CIPHERSWEET_INSTALL="/Users/liam//Tools/ciphersweet/checker.py"

cd $TESTSSL_INSTALL_LOCATION

# First argument will be the URL that is passed during a for loop / xargs etc..
USER_TARGET=$1
OUTPUT_FILENAME="/tmp/cipher-suite.txt"
CIPHER_FILENAME="/tmp/cipher-suite-ciphers.txt"

echo "[*] Running against: $USER_TARGET (This might take around 20-25 seconds)"
testssl -P $USER_TARGET > $OUTPUT_FILENAME

echo "[*] Parsing out Identified Ciphers"
cat $OUTPUT_FILENAME | grep 'TLS_' | awk '{print $7}' > $CIPHER_FILENAME

# Now that we've parsed out the ciphers into their own file, let's run the python script
echo "[*] Checking Ciphers against CipherSuite API"

for cipher in $(cat $CIPHER_FILENAME);
do
	python3 $CIPHERSWEET_INSTALL $cipher
done

# Now that has done, let's cleanup the files that were created.
rm $OUTPUT_FILENAME
rm $CIPHER_FILENAME
