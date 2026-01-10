#!/bin/bash
# install.sh - Install applock to your system
# Usage: ./Scripts/install.sh [--prefix /path]

set -euo pipefail

PREFIX="${PREFIX:-/usr/local}"
BIN_DIR="$PREFIX/bin"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

info() { echo -e "${GREEN}→${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
error() { echo -e "${RED}✗${NC} $1" >&2; }

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --prefix)
            PREFIX="$2"
            BIN_DIR="$PREFIX/bin"
            shift 2
            ;;
        --help|-h)
            echo "Usage: $0 [--prefix /path]"
            echo ""
            echo "Options:"
            echo "  --prefix PATH    Installation prefix (default: /usr/local)"
            echo ""
            echo "Installs applock binary to PREFIX/bin"
            exit 0
            ;;
        *)
            error "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Check if binary exists
if [[ ! -f "applock" ]]; then
    error "Binary not found. Run 'make build' first."
    exit 1
fi

# Create bin directory if needed
if [[ ! -d "$BIN_DIR" ]]; then
    info "Creating $BIN_DIR..."
    sudo mkdir -p "$BIN_DIR"
fi

# Install binary
info "Installing applock to $BIN_DIR..."
sudo cp applock "$BIN_DIR/applock"
sudo chmod +x "$BIN_DIR/applock"

# Verify installation
if command -v applock &>/dev/null; then
    info "Installation successful!"
    echo ""
    echo "Usage:"
    echo "  applock /Applications/Signal.app"
    echo "  applock /Applications/Signal.app \"Unlock Signal\""
    echo ""
    echo "Add aliases to your shell config:"
    echo "  alias signal=\"applock /Applications/Signal.app\""
else
    warn "Binary installed but not in PATH"
    echo "Add $BIN_DIR to your PATH:"
    echo "  export PATH=\"$BIN_DIR:\$PATH\""
fi
