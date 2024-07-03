#!/usr/bin/env bash

set -e

echo "Activating feature 'burp-suite'"

EDITION=${VERSION:-community}
VERSION=${VERSION:-latest}

if [ $VERSION -eq "latest" ]; then
  echo "[burp-suite] [+] Grabbing the latest Burp version"

  RELEASE_DATA=$(curl 'https://portswigger.net/burp/releases/data?previousLastId=-1&lastId=-1&pageSize=1' -sS)
  VERSION=$(echo -n "$RELEASE_DATA" | jq -r '.ResultSet.Results[0].version') # TODO: check for jq
done

TMP=$(mktemp -d)
DESTINATION_FILE="$TMP/burp_install"

echo "[burp-suite] [+] Downloading version $CURRENT_VERSION"
curl --get \
  -o "$DESTINATION_FILE" \
  --data-urlencode "product=$EDITION" \
  --data-urlencode "version=$CURRENT_VERSION" \
  --data-urlencode "type=Linux" \
   "https://portswigger-cdn.net/burp/releases/download"

chmod +x "$DESTINATION_FILE"

echo "[burp-suite] [+] Installing Burp CE"
sudo -u "$_REMOTE_USER" "$DESTINATION_FILE" -q # $_REMOTE_USER_HOME

rm -rf "$TMP"