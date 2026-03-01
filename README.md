<div align="center">

<img src="https://raw.githubusercontent.com/vdutts7/webp/main/macos.webp" alt="logo" width="80" height="80" />
<img src="https://raw.githubusercontent.com/vdutts7/webp/main/touchid.webp" alt="logo" width="80" height="80" />
<img src="https://res.cloudinary.com/ddyc1es5v/image/upload/v1768054075/gh-repos/applock-macos/signal.png" alt="logo" width="80" height="80"/>


<h1 align="center">applock-macos</h1>
<p align="center"><i><b>Protect any macOS app behind Touch ID 🔐</b></i></p>

[![Github][github]][github-url]
[![Homebrew][homebrew]][homebrew-url]

<img src="https://res.cloudinary.com/ddyc1es5v/image/upload/v1768054100/gh-repos/applock-macos/social-preview.png" />

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


<a href="https://vd7.io"><img src="https://img.shields.io/badge/website-000000?style=for-the-badge&logo=data:image/webp;base64,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&logoColor=white" alt="website" /></a>
<a href="https://x.com/vdutts7"><img src="https://img.shields.io/badge/vdutts7-000000?style=for-the-badge&logo=X&logoColor=white" alt="Twitter" /></a>


<!-- BADGES -->
[github]: https://img.shields.io/badge/💻_applock--macos-000000?style=for-the-badge
[github-url]: https://github.com/vdutts7/applock-macos
[homebrew]: https://img.shields.io/badge/Homebrew-vdutts7/tap-FBB040?style=for-the-badge&logo=homebrew&logoColor=white
[homebrew-url]: https://github.com/vdutts7/homebrew-tap
[swift]: https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white
[swift-url]: https://swift.org/
[macos]: https://img.shields.io/badge/macOS_LocalAuthentication-000000?style=for-the-badge&logo=apple&logoColor=white
[macos-url]: https://developer.apple.com/documentation/localauthentication
[email]: https://img.shields.io/badge/Email-000000?style=for-the-badge&logo=Gmail&logoColor=white
[email-url]: mailto:me@vd7.io
[twitter]: https://img.shields.io/badge/Twitter-000000?style=for-the-badge&logo=Twitter&logoColor=white
[twitter-url]: https://x.com/vdutts7
