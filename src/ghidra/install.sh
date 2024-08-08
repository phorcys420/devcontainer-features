#!/usr/bin/env bash

set -euo pipefail

FEATURE_NAME="ghidra"
echo "Activating feature '$FEATURE_NAME'"

LIBRARY_FOLDER="/usr/share/phorcys-devcontainer-libraries"

# Source lib-common and lib-github features
source "$LIBRARY_FOLDER/common/1/main.sh"
source "$LIBRARY_FOLDER/github/1/main.sh"

# Load options
REPOSITORY=${REPOSITORY:-NationalSecurityAgency/ghidra}
VERSION=${VERSION:-latest}

# GHIDRA_HOME is defined in the containerEnv value of the feature's manifest
GHIDRA_HOME=${GHIDRA_HOME:-/opt/ghidra}

# Check for dependencies
checkPackages curl ca-certificates jq libarchive-tools

ASSET_URL=$(getRelease "$REPOSITORY" "$VERSION" | jq -r ".assets[0].browser_download_url")

TMP=$(mktemp -d)
DESTINATION_FILE="$TMP/ghidra.zip"

echo "[$FEATURE_NAME] [+] Downloading version with tag $VERSION"

curl --get --location --silent --show-error --fail \
    --output "$DESTINATION_FILE" \
    "$ASSET_URL"

mkdir -p "$GHIDRA_HOME"

echo "[$FEATURE_NAME] [+] Extracting to $GHIDRA_HOME"

# Extract the archive by stripping the first directory so that we don't end up with a subfolder (e.g ghidra_11.1.1_PUBLIC_20240614) in $GHIDRA_HOME 
bsdtar --strip-components=1 -xf "$DESTINATION_FILE" -C "$GHIDRA_HOME"

rm -rf "$TMP"