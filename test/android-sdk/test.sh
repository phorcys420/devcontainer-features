#!/usr/bin/env bash

set -euo pipefail

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

check "Android SDK folder exists" test -d "$ANDROID_HOME"

BINARY_LIST=("sdkmanager" "adb")

for binary in "${BINARY_LIST[@]}"; do
    check "Android SDK binary '$binary' is in the PATH" which "$binary"
done

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults