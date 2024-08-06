#!/usr/bin/env bash

set -euo pipefail

# Optional: Import test library bundled with the devcontainer CLI
source dev-container-features-test-lib

check "Coder CLI exists" "command -v coder &> /dev/null"

# Report results
# If any of the checks above exited with a non-zero exit code, the test will fail.
reportResults
