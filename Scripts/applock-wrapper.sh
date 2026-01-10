#!/bin/bash
# applock-wrapper: Example wrapper script for protecting specific apps
# This shows how to create convenient aliases for protected apps

set -euo pipefail

APPLOCK_BIN="${APPLOCK_BIN:-/usr/local/bin/applock}"

# Check if applock is installed
if [[ ! -x "$APPLOCK_BIN" ]]; then
    echo "Error: applock not found at $APPLOCK_BIN" >&2
    echo "Run 'make install' first" >&2
    exit 1
fi

# Get the app name from the script name (for symlink usage)
SCRIPT_NAME=$(basename "$0")

# Map script names to app paths
case "$SCRIPT_NAME" in
    signal-secure|signal)
        APP_PATH="/Applications/Signal.app"
        REASON="Authenticate to open Signal"
        ;;
    slack-secure|slack)
        APP_PATH="/Applications/Slack.app"
        REASON="Authenticate to open Slack"
        ;;
    1password-secure|1password)
        APP_PATH="/Applications/1Password.app"
        REASON="Authenticate to open 1Password"
        ;;
    *)
        # Generic usage - pass app path as argument
        if [[ $# -lt 1 ]]; then
            echo "Usage: $0 <app_path> [reason]" >&2
            exit 1
        fi
        APP_PATH="$1"
        REASON="${2:-Authenticate to open app}"
        ;;
esac

# Verify app exists
if [[ ! -d "$APP_PATH" ]]; then
    echo "Error: App not found at $APP_PATH" >&2
    exit 1
fi

# Run applock
exec "$APPLOCK_BIN" "$APP_PATH" "$REASON"
