#!/usr/bin/env bash

set -euo pipefail

FEATURE_NAME="burp-suite"
echo "Activating feature '$FEATURE_NAME'"

# Source lib-common feature
source "/usr/share/phorcys-devcontainer-libraries/common/1/main.sh"

# Check for dependencies
checkPackages curl ca-certificates jq sudo

# Load options
EDITION=${VERSION:-community}
VERSION=${VERSION:-latest}

if [ $VERSION = "latest" ]; then
  echo "[$FEATURE_NAME] [+] Grabbing the latest Burp version"

  RELEASE_DATA=$(curl 'https://portswigger.net/burp/releases/data?previousLastId=-1&lastId=-1&pageSize=1' --silent --show-error)
  VERSION=$(echo -n "$RELEASE_DATA" | jq -r '.ResultSet.Results[0].version')
fi

TMP=$(mktemp -d)
DESTINATION_FILE="$TMP/burp_install.sh"

echo "[$FEATURE_NAME] [+] Downloading version $CURRENT_VERSION"
curl --location --silent --show-error \
  --data-urlencode "product=$EDITION" \
  --data-urlencode "version=$CURRENT_VERSION" \
  --data-urlencode "type=Linux" \
  --output "$DESTINATION_FILE" \
  "https://portswigger-cdn.net/burp/releases/download"

chmod +x "$DESTINATION_FILE"

echo "[$FEATURE_NAME] [+] Installing Burp CE"
sudo -u "$_REMOTE_USER" "$DESTINATION_FILE" -q # $_REMOTE_USER_HOME

rm -rf "$TMP"