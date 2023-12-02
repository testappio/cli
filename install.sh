#!/usr/bin/env bash
set -eu

# allow overriding the version
VERSION="1.10.2"

PLATFORM=$(uname -s)
ARCH=$(uname -m)

if [[ $PLATFORM == CYGWIN* ]] || [[ $PLATFORM == MINGW* ]] || [[ $PLATFORM == MSYS* ]]; then
    PLATFORM="Windows"
fi

if [[ $PLATFORM == "Darwin" ]]; then
    if [[ $ARCH == aarch64* ]]; then
        ARCH="arm64"
    elif [[ $ARCH == x86_64* ]] || [[ $ARCH == amd64* ]]; then
        ARCH="x86_64"
    else
        ARCH="universal"
    fi
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

DOWNLOAD_URL="https://github.com/testappio/cli/releases/download/v${VERSION}/ta-cli-${PLATFORM}-${ARCH}"

echo "This script will automatically install ta-cli (${VERSION}) for you."
echo "Installation path: ${INSTALL_PATH}"
if [ "x$(id -u)" == "x0" ]; then
    echo "Warning: this script is currently running as root. This is dangerous. "
    echo "         Instead run it as normal user. We will sudo as needed."
fi

# if [ -f "$INSTALL_PATH" ]; then
#   echo "error: ta-cli is already installed."
#   echo "  run \"ta-cli update\" to update to latest version"
#   exit 1
# fi

if ! hash curl 2>/dev/null; then
    echo "error: you do not have 'curl' installed which is required for this script."
    exit 1
fi

TEMP_FILE=$(mktemp "${TMPDIR:-/tmp}/.tacli.XXXXXXXX")
TEMP_HEADER_FILE=$(mktemp "${TMPDIR:-/tmp}/.tacli-headers.XXXXXXXX")

cleanup() {
    rm -f "$TEMP_FILE"
    rm -f "$TEMP_HEADER_FILE"
}

trap cleanup EXIT
HTTP_CODE=$(curl -SL --progress-bar "$DOWNLOAD_URL" -D "$TEMP_HEADER_FILE" --output "$TEMP_FILE" --write-out "%{http_code}")
if [[ ${HTTP_CODE} -lt 200 || ${HTTP_CODE} -gt 299 ]]; then
    echo "error: your platform and architecture (${PLATFORM}-${ARCH}) is unsupported. Please contact us to support it for you."
    exit 1
fi

chmod 0755 "$TEMP_FILE"
if ! mv "$TEMP_FILE" "$INSTALL_PATH" 2>/dev/null; then
    sudo -k mv "$TEMP_FILE" "$INSTALL_PATH"
fi

echo
echo "ta-cli successfully installed in $INSTALL_PATH $("$INSTALL_PATH" version)"
echo

echo
echo "You can now run ta-cli config"
echo
