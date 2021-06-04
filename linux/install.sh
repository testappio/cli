#!/bin/sh

if ! groups | grep "\<sudo\>" &>/dev/null; then
    echo "You will need to use sudo with this command"
    exit
fi

if ! curl -v COMMAND &>/dev/null; then
    echo "curl command required, please install it first"
    exit
fi

if ! unzip -v COMMAND &>/dev/null; then
    echo "unzip command required, please install it first"
    exit
fi

curl -LO https://github.com/testappio/cli/releases/latest/download/ta-cli_linux.zip

unzip ta-cli_linux.zip
rm -rf ta-cli_linux.zip

chmod +x ta-cli_linux/ta-cli

INSTALL_PATH=/usr/local/bin/ta-cli

mv ta-cli_linux/ta-cli $INSTALL_PATH

if ! [ $? -eq 0 ]; then
    echo "Failed to copy to $INSTALL_PATH - please use sudo with this command or contact us for more help"
    rm -rf ta-cli_linux
    exit
fi

rm -rf ta-cli_linux

echo
echo "Verifying the installation...".

if ! ta-cli -v COMMAND &>/dev/null; then
    echo "ta-cli failed to be installed, please contact us for more info"
fi

echo "ta-cli succesfully installed in $INSTALL_PATH".
