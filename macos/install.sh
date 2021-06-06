#!/bin/sh

if ! curl -sL --fail https://google.com -o /dev/null; then
    echo 'Error: curl command is not installed' >&2
    exit 1
fi

if ! [ -x "$(command -v unzip)" ]; then
    echo 'Error: unzip command is not installed' >&2
    exit 1
fi

curl -LO https://github.com/testappio/cli/releases/latest/download/ta-cli_macos.zip

unzip ta-cli_macos.zip
if ! [ $? -eq 0 ]; then
    echo
    echo "Failed to download the ta-cli. Please check our documentation at https://github.com/testappio/cli"
    echo
    rm -rf ta-cli_macos.zip
    exit
fi

rm -rf ta-cli_macos.zip

INSTALL_PATH=/usr/local/bin/ta-cli

mv ta-cli_macos/ta-cli $INSTALL_PATH
if ! [ $? -eq 0 ]; then
    echo "Failed to copy to $INSTALL_PATH - please use sudo with this command or contact us for more help"
    rm -rf ta-cli_macos
    exit
fi

rm -rf ta-cli_macos

echo
echo 'You can now run `ta-cli config`'.
