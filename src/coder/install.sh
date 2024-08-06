#!/usr/bin/env bash

set -euo pipefail

FEATURE_NAME="coder"
echo "Activating feature '$FEATURE_NAME'"

# Source lib-common feature
source "/usr/share/phorcys-devcontainer-libraries/common/1/main.sh"

# Check for dependencies
checkPackages curl ca-certificates sudo

# Load options
VERSION=${VERSION:-latest}

TMP=$(mktemp -d)
DESTINATION_FILE="$TMP/install.sh"

echo "[$FEATURE_NAME] [+] Downloading version $VERSION"

curl --get --location --silent --show-error --fail \
  --output "$DESTINATION_FILE" \
  "https://coder.com/install.sh"

# Make temporary directory accessible to all users
chmod +rx "$TMP" -R

echo "[$FEATURE_NAME] [+] Installing Coder"

if [ $VERSION = "latest" ]; then
  sudo -u "$_REMOTE_USER" "$DESTINATION_FILE"
else
  sudo -u "$_REMOTE_USER" "$DESTINATION_FILE" --version "$VERSION"
fi

rm -rf "$TMP"
