#!/bin/bash

getRelease() {
    REPOSITORY=$1
    TAG=${2:-latest}

    if [ $TAG = "latest" ]; then
        RELEASE_API_URL="https://api.github.com/repos/$REPOSITORY/releases/latest"
    else
        RELEASE_API_URL="https://api.github.com/repos/$REPOSITORY/releases/tags/$TAG"
    fi

    curl "$RELEASE_API_URL" --silent --show-error
}

# Check for necessary packages
checkPackages curl jq