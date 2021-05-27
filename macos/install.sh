#!/bin/sh

curl -LO https://github.com/testappio/cli/releases/latest/download/macos.zip
unzip macos.zip
rm -rf macos.zip
mv macos/ta-cli /usr/local/bin/ta-cli

echo
echo 'You can now run `ta-cli -h`'.
