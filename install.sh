#!/bin/bash
set -eu

VERSION="1.0.4"

TACLI_DOWNLOAD_Darwin_universal="https://github.com/testappio/cli/releases/download/v${VERSION}/ta-cli-Darwin-universal"
TACLI_DOWNLOAD_Linux_x86_64="https://github.com/testappio/cli/releases/download/v${VERSION}/ta-cli-Linux-x86_64"

PLATFORM=$(uname -s)
ARCH=$(uname -m)

if [[ $PLATFORM == CYGWIN* ]] || [[ $PLATFORM == MINGW* ]] || [[ $PLATFORM == MSYS* ]]; then
    PLATFORM="Windows"
fi

if [[ $PLATFORM == "Darwin" ]]; then
    ARCH="universal"
fi

if [[ $ARCH == armv8* ]] || [[ $ARCH == arm64* ]] || [[ $ARCH == aarch64* ]]; then
    ARCH="aarch64"
fi

if [[ $ARCH == armv6* ]] || [[ $ARCH == armv7* ]]; then
    ARCH="armv7"
fi

# If the install directory is not set, set it to a default
if [ -z ${INSTALL_DIR+x} ]; then
    INSTALL_DIR=/usr/local/bin
fi
if [ -z ${INSTALL_PATH+x} ]; then
    INSTALL_PATH="${INSTALL_DIR}/ta-cli"
fi

DOWNLOAD_URL_LOOKUP="TACLI_DOWNLOAD_${PLATFORM}_${ARCH}"
DOWNLOAD_URL="${!DOWNLOAD_URL_LOOKUP:-}"

echo "This script will automatically install ta-cli ${VERSION} for you."
echo "Installation path: ${INSTALL_PATH}"
if [ "x$(id -u)" == "x0" ]; then
    echo "Warning: this script is currently running as root. This is dangerous. "
    echo "         Instead run it as normal user. We will sudo as needed."
fi

# if [ -f "$INSTALL_PATH" ]; then
#     echo "error: ta-cli is already installed."
#     exit 1
# fi

if [ x$DOWNLOAD_URL == x ]; then
    echo "error: your platform and architecture (${PLATFORM}-${ARCH}) is unsupported. Please contact us to support it for you."
    exit 1
fi

if ! hash curl 2>/dev/null; then
    echo "error: you do not have 'curl' installed which is required for this script."
    exit 1
fi

TEMP_FILE=$(mktemp "${TMPDIR:-/tmp}/.tacli.XXXXXXXX")

cleanup() {
    rm -f "$TEMP_FILE"
}

trap cleanup EXIT
curl -SL --progress-bar "$DOWNLOAD_URL" >"$TEMP_FILE"
chmod 0755 "$TEMP_FILE"
if ! mv "$TEMP_FILE" "$INSTALL_PATH" 2>/dev/null; then
    sudo -k mv "$TEMP_FILE" "$INSTALL_PATH"
fi

echo
ta-cli -h

echo
echo "ta-cli successfully installed in $INSTALL_PATH"

echo
echo '🎉 You can now run ta-cli config'
echo
