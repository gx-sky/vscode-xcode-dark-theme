#!/usr/bin/env sh
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

if command -v pwsh >/dev/null 2>&1; then
  PS_CMD="pwsh"
elif command -v powershell >/dev/null 2>&1; then
  PS_CMD="powershell"
else
  echo "Error: PowerShell not found. Install PowerShell (pwsh) first." >&2
  exit 1
fi

"$PS_CMD" -NoProfile -File "$SCRIPT_DIR/build-vsix.ps1" "$@"
echo "VSIX packaging completed."
