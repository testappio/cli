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
    exit 1
fi

rm -rf ta-cli_macos.zip

# If the install directory is not set, set it to a default
if [ -z ${INSTALL_DIR+x} ]; then
    INSTALL_DIR=/usr/local/bin
fi
if [ -z ${INSTALL_PATH+x} ]; then
    INSTALL_PATH="${INSTALL_DIR}/ta-cli"
fi

mv ta-cli_macos/ta-cli $INSTALL_PATH
if ! [ $? -eq 0 ]; then
    echo "Failed to copy to $INSTALL_PATH - please use sudo with this command or contact us for more help"
    rm -rf ta-cli_macos
    exit 1
fi

rm -rf ta-cli_macos

echo
ta-cli -h

echo
echo "ta-cli successfully installed in $INSTALL_PATH"

echo
echo '🎉 You can now run ta-cli config'
echo
