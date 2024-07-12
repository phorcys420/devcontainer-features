#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
checkPackages() {
    if ! dpkg -s "$@" > /dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            echo "Running apt-get update..."
            apt-get update -y
        fi

        apt-get install -y --no-install-recommends "$@"
    fi
}

getFeatureVersion() {
    jq -r ".version" devcontainer-feature.json
}

getVersionParts() {
    VERSION=${1:-$(getFeatureVersion)}

    IFS='.' read -ra VERSION_PARTS <<< "$VERSION"
    
    echo "${VERSION_PARTS[@]}"
}

# Check for necessary packages
checkPackages jq