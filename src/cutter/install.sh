#!/usr/bin/env bash

set -euo pipefail

FEATURE_NAME="cutter"
echo "Activating feature '$FEATURE_NAME'"

# Source lib-common and lib-github features (DEVCONTAINER_LIBRARIES_HOME is defined by lib-common)
source "$DEVCONTAINER_LIBRARIES_HOME/common/1/main.sh"
source "$DEVCONTAINER_LIBRARIES_HOME/github/1/main.sh"

# Load options
REPOSITORY=${REPOSITORY:-rizinorg/cutter}
VERSION=${VERSION:-latest}

EXTRACT_APPIMAGE=${EXTRACTAPPIMAGE:-"true"}

# CUTTER_HOME is defined in the containerEnv value of the feature's manifest
CUTTER_HOME=${CUTTER_HOME:-/opt/cutter}

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

mkdir -p "$CUTTER_HOME"

if [ "$EXTRACT_APPIMAGE" = "true" ]; then
    pushd "$TMP"

    echo "[$FEATURE_NAME] [+] Extracting AppImage"
    "$DESTINATION_FILE" --appimage-extract

    shopt -s dotglob nullglob

    # When extracting the AppImage, it creates a squashfs-root subdirectory
    mv squashfs-root/* "$CUTTER_HOME/"

    # Rename the "AppRun" binary to "cutter"
    mv "$CUTTER_HOME/AppRun" "$CUTTER_HOME/cutter"

    popd
else
    mv "$DESTINATION_FILE" "$CUTTER_HOME/"
fi