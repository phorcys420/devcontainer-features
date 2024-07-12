#!/usr/bin/env bash

set -euo pipefail

FEATURE_NAME="cutter"
echo "Activating feature '$FEATURE_NAME'"

LIBRARY_FOLDER="/usr/share/phorcys-devcontainer-libraries"

# Source lib-common and lib-github features
source "$LIBRARY_FOLDER/common/1/main.sh"
source "$LIBRARY_FOLDER/github/1/main.sh"

# Load options
REPOSITORY=${REPOSITORY:-rizinorg/cutter}
VERSION=${VERSION:-latest}

INSTALL_DIR=${INSTALL_DIR:-/opt/cutter}
BINARY_PATH="$INSTALL_DIR/cutter"

# Check for dependencies
checkPackages curl ca-certificates jq libarchive-tools

ASSET_URL=$(getRelease "$REPOSITORY" "$VERSION" | jq -r '.assets[] | select(.name | endswith("Linux-x86_64.AppImage")) | .browser_download_url')

echo "[$FEATURE_NAME] [+] Downloading version with tag $VERSION"

mkdir -p "$INSTALL_DIR"

curl --get --location --silent --show-error --fail \
    --output "$BINARY_PATH" \
    "$ASSET_URL"

chmod +x "$BINARY_PATH"