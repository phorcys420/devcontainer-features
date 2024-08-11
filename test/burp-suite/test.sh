#!/usr/bin/env bash

set -euo pipefail

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

check "Burp folder exists" test -d "$BURP_HOME"
check "Burp binary is in the PATH" which BurpSuiteCommunity

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults