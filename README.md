<div align="center">

<img src="https://raw.githubusercontent.com/vdutts7/squircle/main/webp/apple-localauthentication.webp" alt="logo" width="80" height="80" />

<h1 align="center">applock</h1>
<p align="center"><i><b>protect any macOS app behind Touch ID 🔐</b></i></p>

[![Github][github]][github-url]
[![Homebrew][homebrew]][homebrew-url]


</div>

<br/>

## Table of Contents

<ol>
    <a href="#about">About</a><br/>
    <a href="#install">Install</a><br/>
    <a href="#usage">Usage</a><br/>
    <a href="#roadmap">Roadmap</a><br/>
    <a href="#tools-used">Tools used</a><br/>
    <a href="#contact">Contact</a>
</ol>

<br/>

## About

Gate any `.app` behind biometric auth - not just apps that natively support Touch ID.

```
you type: applock Signal
           ↓
Touch ID prompt appears
           ↓
✓ authenticated → app opens
✗ failed → app stays closed
```

**Use cases:**
- Signal, WhatsApp, Telegram behind biometrics
- Password managers (1Password, Bitwarden)
- Banking apps, crypto wallets
- Anything you want locked

<br/>

## Install

```bash
brew tap vdutts7/tap
brew install applock
```

### From source (optional)

```bash
git clone https://github.com/vdutts7/applock-macos.git
cd applock-macos
make install
```

> Prebuilt universal binary (Intel + Apple Silicon) included in `bin/`. No Xcode required.

<details>
<summary>Build from source</summary>

```bash
# Requires Xcode
make build

# Or manually
swiftc -O -o applock Sources/applock.swift
```

**Troubleshooting SDK mismatch:**

If you get "failed to build module 'CoreFoundation'" error:

```bash
# Option 1: Reinstall Command Line Tools
sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install

# Option 2: Point to Xcode SDK
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
```
</details>

<br/>

## Usage

```bash
# Basic
applock /Applications/Signal.app

# With custom prompt
applock /Applications/Signal.app "Unlock Signal"

# Shell alias (add to .zshrc)
alias signal="applock /Applications/Signal.app"
```

<br/>

## Roadmap

- [x] Touch ID biometric authentication
- [x] Universal binary (Intel + Apple Silicon)
- [x] Homebrew formula
- [ ] Config file for protected apps list
- [ ] Menubar app for quick access  
- [ ] Auto-lock after timeout

<br/>

## Tools Used

[![Swift][swift]][swift-url]
[![macOS][macos]][macos-url]

<br/>

## Contact

<a href="https://vd7.io"><img src="https://res.cloudinary.com/ddyc1es5v/image/upload/v1773910810/readme-badges/readme-badge-vd7.png" alt="vd7.io" height="40" /></a> &nbsp; <a href="https://x.com/vdutts7"><img src="https://res.cloudinary.com/ddyc1es5v/image/upload/v1773910817/readme-badges/readme-badge-x.png" alt="/vdutts7" height="40" /></a>




<!-- BADGES -->
[github]: https://img.shields.io/badge/💻_applock--macos-000000?style=for-the-badge
[github-url]: https://github.com/vdutts7/applock-macos
[homebrew]: https://img.shields.io/badge/Homebrew-vdutts7/tap-FBB040?style=for-the-badge&logo=homebrew&logoColor=white
[homebrew-url]: https://github.com/vdutts7/homebrew-tap
[swift]: https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white
[swift-url]: https://swift.org/
[macos]: https://img.shields.io/badge/apple_LocalAuthentication-000000?style=for-the-badge&logo=apple&logoColor=white
[macos-url]: https://developer.apple.com/documentation/localauthentication
[email]: https://img.shields.io/badge/Email-000000?style=for-the-badge&logo=Gmail&logoColor=white
[email-url]: mailto:me@vd7.io
[twitter]: https://img.shields.io/badge/Twitter-000000?style=for-the-badge&logo=Twitter&logoColor=white
[twitter-url]: https://x.com/vdutts7
