# applock-macos

Protect any macOS app behind Touch ID. Simple CLI tool that gates app launches with biometric authentication.

## What it does

```
you type: applock Signal
           ↓
Touch ID prompt appears
           ↓
✓ authenticated → app opens
✗ failed → app stays closed
```

## Why

- Keep sensitive apps (Signal, password managers, etc.) behind biometrics
- Works with ANY `.app` - not just apps that support Touch ID natively
- No daemon, no background process - just runs when you call it

## Status

🚧 **Work in progress** - core functionality works, polish ongoing.

## Requirements

- macOS 10.12.2+ (Touch ID support)
- Mac with Touch ID (MacBook Pro 2016+, or Apple Silicon Mac with Magic Keyboard)
- Xcode Command Line Tools (for building)

## Quick Start

```bash
# Clone
git clone https://github.com/vdutts7/applock-macos.git
cd applock-macos

# Build
make

# Install
make install

# Use
applock /Applications/Signal.app
```

## Usage

```bash
# Basic - protect an app
applock /path/to/App.app

# With custom prompt message
applock /path/to/App.app "Unlock Signal"

# Create an alias in your shell
alias signal="applock /Applications/Signal.app"
```

## How it works

1. `applock` binary uses macOS LocalAuthentication framework
2. Prompts for Touch ID (falls back to password if configured)
3. On success, opens the specified app
4. On failure, exits with error code

## Building from source

```bash
# Compile the Swift CLI
make build

# Or manually:
swiftc -O -o applock Sources/applock.swift
```

### Troubleshooting Build Issues

If you see SDK/toolchain mismatch errors:

```bash
# Option 1: Use Xcode's toolchain (if Xcode installed)
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# Option 2: Reinstall Command Line Tools
sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install
```

## Project Structure

```
applock-macos/
├── Sources/
│   └── applock.swift      # Main CLI tool (LocalAuthentication)
├── Scripts/
│   └── install.sh         # Installation script
├── Makefile               # Build automation
└── README.md
```

## Security Notes

- Uses `LAPolicy.deviceOwnerAuthenticationWithBiometrics` by default
- Can fall back to device passcode if biometrics unavailable
- No credentials stored - just gates the app launch
- Ad-hoc signed (no Apple Developer ID required for personal use)

## Roadmap

- [ ] Config file for protected apps list
- [ ] Menubar app for quick access
- [ ] Auto-lock after timeout
- [ ] Multiple authentication policies

## License

MIT

## Author

[@vdutts7](https://github.com/vdutts7) - [vd7.io](https://vd7.io)
