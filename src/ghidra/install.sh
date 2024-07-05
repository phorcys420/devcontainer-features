#!/usr/bin/env bash

echo "Activating feature 'ghidra'"

set -euo pipefail

REPOSITORY=${REPOSITORY:-NationalSecurityAgency/ghidra}
VERSION_TAG=${VERSION_TAG:-latest}

INSTALL_DIR=${INSTALL_DIR:-/opt/ghidra}

# From aws-cli feature (https://github.com/devcontainers/features/blob/main/src/aws-cli/install.sh#L59-L72)
export DEBIAN_FRONTEND=noninteractive
check_packages() {
  if ! dpkg -s "$@" > /dev/null 2>&1; then
      if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
          echo "Running apt-get update..."
          apt-get update -y
      fi

      apt-get install -y --no-install-recommends "$@"
  fi
}

check_packages libarchive-tools curl jq

if [ $VERSION_TAG = "latest" ]; then
    RELEASE_API_URL="https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/latest"
else
    RELEASE_API_URL="https://api.github.com/repos/NationalSecurityAgency/ghidra/releases/tags/$VERSION_TAG"
fi

ASSET_URL=$(curl "$RELEASE_API_URL" --silent --show-error | jq -r ".assets[0].browser_download_url")

TMP=$(mktemp -d)
DESTINATION_FILE="$TMP/ghidra.zip"

echo "[ghidra] [+] Downloading version with tag $VERSION_TAG"

curl --location --silent --show-error \
  --output "$DESTINATION_FILE" \
  "$ASSET_URL"

mkdir -p "$INSTALL_DIR"

echo "[ghidra] [+] Extracting to $INSTALL_DIR"

# Extract the archive by stripping the first directory so that we don't end up with a subfolder (e.g ghidra_11.1.1_PUBLIC_20240614) in $INSTALL_DIR 
bsdtar --strip-components=1 -xf "$DESTINATION_FILE" -C "$INSTALL_DIR"

rm -rf "$TMP"