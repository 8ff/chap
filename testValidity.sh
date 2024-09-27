#!/bin/bash

function fail() {
    echo "Test failed: $1"
    exit 1
}

dd if=/dev/urandom of=randomData bs=1M count=1000 2>/dev/null || fail "Failed to generate random data"
CKEY=test go run chap.go e < randomData > encryptedData || fail "Failed to encrypt data"
CKEY=test go run chap.go d < encryptedData > decryptedData || fail "Failed to decrypt data"

# Test pipe to make sure no decryption errors occur
dd if=/dev/urandom bs=1M count=1000 | CKEY=test go run chap.go e | CKEY=test go run chap.go d > /dev/null


# Check if on macOS, use md5 instead of md5sum
if [ "$(uname)" == "Darwin" ]; then
    ORIGINAL_MD5=$(md5 -q randomData)
    DECRYPTED_MD5=$(md5 -q decryptedData)
else
    ORIGINAL_MD5=$(md5sum randomData | cut -d' ' -f1)
    DECRYPTED_MD5=$(md5sum decryptedData | cut -d' ' -f1)
fi

if [ "$ORIGINAL_MD5" != "$DECRYPTED_MD5" ]; then
    fail "Decrypted data does not match original data"
fi

rm randomData encryptedData decryptedData || fail "Failed to clean up"

echo "All tests passed successfully!"
