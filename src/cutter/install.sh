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

EXTRACT_APPIMAGE=${EXTRACTAPPIMAGE:-"true"}

INSTALL_DIR=${INSTALL_DIR:-/opt/cutter}

# Check for dependencies
checkPackages curl ca-certificates jq libarchive-tools

ASSET_URL=$(getRelease "$REPOSITORY" "$VERSION" | jq -r '.assets[] | select(.name | endswith("Linux-x86_64.AppImage")) | .browser_download_url')

TMP=$(mktemp -d)
DESTINATION_FILE="$TMP/cutter"

echo "[$FEATURE_NAME] [+] Downloading version with tag $VERSION"

curl --get --location --silent --show-error --fail \
    --output "$DESTINATION_FILE" \
    "$ASSET_URL"

chmod +x "$DESTINATION_FILE"

mkdir -p "$INSTALL_DIR"

if[ "$EXTRACT_APPIMAGE" = "true"]; then
    pushd "$TMP"

    echo "[$FEATURE_NAME] [+] Extracting AppImage"
    "$DESTINATION_FILE" --appimage-extract

    shopt -s dotglob nullglob

    # When extracting the AppImage, it creates a squashfs-root subdirectory
    mv squashfs-root/* "$INSTALL_DIR/"

    # Rename the "AppRun" binary to "cutter"
    mv "$INSTALL_DIR/AppRun" "$INSTALL_DIR/cutter"

    popd
else
    mv "$DESTINATION_FILE" "$INSTALL_DIR/"
fi