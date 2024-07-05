#!/usr/bin/env bash

echo "Activating feature 'burp-suite'"

set -euo pipefail

EDITION=${VERSION:-community}
VERSION=${VERSION:-latest}

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

check_packages curl ca-certificates jq sudo

if [ $VERSION = "latest" ]; then
  echo "[burp-suite] [+] Grabbing the latest Burp version"

  RELEASE_DATA=$(curl 'https://portswigger.net/burp/releases/data?previousLastId=-1&lastId=-1&pageSize=1' --silent --show-error)
  VERSION=$(echo -n "$RELEASE_DATA" | jq -r '.ResultSet.Results[0].version')
fi

TMP=$(mktemp -d)
DESTINATION_FILE="$TMP/burp_install.sh"

echo "[burp-suite] [+] Downloading version $CURRENT_VERSION"
curl --location --silent --show-error \
  --data-urlencode "product=$EDITION" \
  --data-urlencode "version=$CURRENT_VERSION" \
  --data-urlencode "type=Linux" \
  --output "$DESTINATION_FILE" \
  "https://portswigger-cdn.net/burp/releases/download"

chmod +x "$DESTINATION_FILE"

echo "[burp-suite] [+] Installing Burp CE"
sudo -u "$_REMOTE_USER" "$DESTINATION_FILE" -q # $_REMOTE_USER_HOME

rm -rf "$TMP"