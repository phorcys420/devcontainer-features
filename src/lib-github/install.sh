#!/usr/bin/env bash

set -euo pipefail

LIBRARY_NAME="github"
FEATURE_NAME="lib-$LIBRARY_NAME"
echo "Activating feature '$FEATURE_NAME'"

# Define the base directory where the feature libraries are stored
BASE_DIR=${BASEDIR:-"/usr/share/phorcys-devcontainer-libraries"}

# Source lib-common feature
source "$BASE_DIR/common/1/main.sh"

# Grab current feature version and split it in parts
VERSION=$(getFeatureVersion)
VERSION_PARTS=($(getVersionParts "$VERSION"))

# Define the installation directory for the current feature and the current feature version
LIBRARY_DIR="$BASE_DIR/$LIBRARY_NAME"
INSTALL_DIR="$LIBRARY_DIR/$VERSION"

# Create directory for current feature version
echo "[$FEATURE_NAME] [+] Installing library to $INSTALL_DIR"
mkdir --parents "$INSTALL_DIR"
cp --recursive src/. "$INSTALL_DIR"

# Make links to each subversion (e.g if version is 1.0.0, then link to 1.0 and 1) and "current"
SUBFOLDERS=(
    "${VERSION_PARTS[0]}.${VERSION_PARTS[1]}" # 1.0
    "${VERSION_PARTS[0]}" # 1
    "current"
)

for SUBFOLDER in "${SUBFOLDERS[@]}"
do
    ln --symbolic --force "$INSTALL_DIR" "$LIBRARY_DIR/$SUBFOLDER"
done