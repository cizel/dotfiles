#!/usr/bin/env bash

set -euo pipefail

cat <<'EOF'
script/install.sh is deprecated.

Use one of these instead:
  1. ./script/bootstrap.sh
  2. ./script/install-shell-tools.sh

If you still want a macOS-specific installer, rebuild this script around the
current Homebrew installation flow instead of the legacy Ruby bootstrap path.
EOF
