#!/usr/bin/env bash

set -euo pipefail

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

check "Cutter folder exists" test -d "$CUTTER_HOME"
check "Cutter binary is in the PATH" which cutter

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults