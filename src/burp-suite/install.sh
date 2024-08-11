#!/usr/bin/env bash
#test
set -euo pipefail

FEATURE_NAME="burp-suite"
echo "Activating feature '$FEATURE_NAME'"

# Source lib-common feature
source "/usr/share/phorcys-devcontainer-libraries/common/1/main.sh"

# Check for dependencies (libfreetype6 is only really needed to run in CI, otherwise you would always have this library if you have the desktop-lite feature)
checkPackages curl ca-certificates jq sudo libfreetype6

# Load options
EDITION=${EDITION:-community}
VERSION=${VERSION:-latest}

# CUTTER_HOME is defined in the containerEnv value of the feature's manifest
BURP_HOME=${BURP_HOME:-/opt/burp-suite}

if [ $VERSION = "latest" ]; then
  echo "[$FEATURE_NAME] [+] Grabbing the latest Burp Suite version"

  RELEASE_DATA=$(curl 'https://portswigger.net/burp/releases/data?previousLastId=-1&lastId=-1&pageSize=5' --silent --show-error --fail)

  # Get the first release with channel "Stable"
  VERSION=$(echo -n "$RELEASE_DATA" | jq -r '.ResultSet.Results | map(select(.releaseChannels[] | contains ("Stable"))) | .[0].version')
fi

TMP=$(mktemp -d)
DESTINATION_FILE="$TMP/burp_install.sh"

echo "[$FEATURE_NAME] [+] Downloading version $EDITION $VERSION"

curl --get --location --silent --show-error --fail \
  --data-urlencode "product=$EDITION" \
  --data-urlencode "version=$VERSION" \
  --data-urlencode "type=Linux" \
  --output "$DESTINATION_FILE" \
  "https://portswigger-cdn.net/burp/releases/download"

# Make temporary directory accessible to all users
chmod +rx "$TMP" -R

echo "[$FEATURE_NAME] [+] Installing Burp Suite $EDITION edition"
"$DESTINATION_FILE" -q -dir "$BURP_HOME" -overwrite

rm -rf "$TMP"