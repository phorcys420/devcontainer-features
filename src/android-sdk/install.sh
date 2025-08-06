#!/usr/bin/env bash

set -euo pipefail

FEATURE_NAME="android-sdk"
echo "Activating feature '$FEATURE_NAME'"

# Source lib-common feature (DEVCONTAINER_LIBRARIES_HOME is defined by lib-common)
source "$DEVCONTAINER_LIBRARIES_HOME/common/1/main.sh"

# Load options
VERSION=${VERSION:-11076708}

INSTALL_MAVEN_REPOS=${INSTALLMAVENREPOS:-"true"}
INSTALL_PLAY_SERVICES=${INSTALLPLAYSERVICES:-"true"}
INSTALL_EMULATOR=${INSTALLEMULATOR:-"false"}

# ANDROID_HOME and ANDROID_CMDLINE_TOOLS_HOME are defined in the containerEnv value of the feature's manifest
ANDROID_HOME=${ANDROID_HOME:-/usr/local/android-sdk}
ANDROID_CMDLINE_TOOLS_HOME=${ANDROID_CMDLINE_TOOLS_HOME:-${ANDROID_HOME}/cmdline-tools}

# Check for dependencies
checkPackages curl ca-certificates unzip

TMP=$(mktemp -d)
DESTINATION_FILE="$TMP/android-sdk.zip"

echo "[$FEATURE_NAME] [+] Downloading version $VERSION of Android command line tools"

curl --get --location --silent --show-error --fail \
    --output "$DESTINATION_FILE" \
    "https://dl.google.com/android/repository/commandlinetools-linux-${VERSION}_latest.zip"

mkdir -p "$ANDROID_CMDLINE_TOOLS_HOME"

echo "[$FEATURE_NAME] [+] Extracting Android command line tools"
unzip "$TMP/android-sdk.zip" -d "$ANDROID_CMDLINE_TOOLS_HOME"
mv "$ANDROID_CMDLINE_TOOLS_HOME/cmdline-tools" "$ANDROID_CMDLINE_TOOLS_HOME/latest"

echo "[$FEATURE_NAME] [+] Accepting sdkmanager's licenses"
(yes || true) | sdkmanager --licenses


TOOLS=("tools" "platform-tools" "build-tools;34.0.0")

if [ "$INSTALL_MAVEN_REPOS" = "true" ]; then
    echo "[$FEATURE_NAME] [+] Adding Android and Google's Maven repositories to the list of tools"
    TOOLS+=("extras;android;m2repository" "extras;google;m2repository")
fi

if [ "$INSTALL_PLAY_SERVICES" = "true" ]; then
    echo "[$FEATURE_NAME] [+] Adding play services to the list of tools"
    TOOLS+=("extras;google;google_play_services")
fi

if [ "$INSTALL_EMULATOR" = "true" ]; then
    echo "[$FEATURE_NAME] [+] Adding the emulator to the list of tools"
    TOOLS+=("emulator")
fi

echo "[$FEATURE_NAME] [+] Installing SDK tools"
sdkmanager --install "${TOOLS[@]}"

rm -rf "$TMP"
