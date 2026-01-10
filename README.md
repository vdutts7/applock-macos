<div align="center">

<img src="https://res.cloudinary.com/ddyc1es5v/image/upload/v1768054074/gh-repos/applock-macos/apple.png" alt="logo" width="80" height="80"/>
<img src="https://res.cloudinary.com/ddyc1es5v/image/upload/v1768054075/gh-repos/applock-macos/signal.png" alt="logo" width="80" height="80"/>
<img src="https://res.cloudinary.com/ddyc1es5v/image/upload/v1768054076/gh-repos/applock-macos/touchid.png" alt="logo" width="80" height="80"/>

<h1 align="center">applock-macos</h1>
<p align="center">
    <i><b>Protect any macOS app behind Touch ID 🔐</b></i>
</p>

[![Github][github]][github-url]

<img src="https://res.cloudinary.com/ddyc1es5v/image/upload/v1768054100/gh-repos/applock-macos/social-preview.png" />

</div>

<br/>

## Table of Contents

<ol>
    <a href="#about">📝 About</a><br/>
    <a href="#how-to-build">💻 How to build</a><br/>
    <a href="#next-steps">🚀 Next steps</a><br/>
    <a href="#tools-used">🔧 Tools used</a><br/>
    <a href="#contact">👤 Contact</a>
</ol>

<br/>

## 📝About

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

## 💻How to build

### Install via Homebrew (recommended)

```bash
brew tap vdutts7/tap
brew install applock
```

### Quick start (prebuilt binary)

```bash
git clone https://github.com/vdutts7/applock-macos.git
cd applock-macos
make install
```

> Prebuilt universal binary (Intel + Apple Silicon) included in `bin/`. No Xcode required.

### Usage

```bash
# Basic
applock /Applications/Signal.app

# With custom prompt
applock /Applications/Signal.app "Unlock Signal"

# Shell alias (add to .zshrc)
alias signal="applock /Applications/Signal.app"
```

### Build from source (optional)

```bash
# Requires Xcode
make build

# Or manually
swiftc -O -o applock Sources/applock.swift
```

<details>
<summary>Troubleshooting SDK mismatch</summary>

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

## 🚀Next steps

- [ ] Config file for protected apps list
- [ ] Menubar app for quick access  
- [ ] Auto-lock after timeout
- [ ] Homebrew formula

<br/>

## 🔧Tools Used

[![Swift][swift]][swift-url]
[![macOS][macos]][macos-url]

<br/>

## 👤Contact

[![Email][email]][email-url]
[![Twitter][twitter]][twitter-url]

<!-- MARKDOWN LINKS & IMAGES -->

[swift]: https://img.shields.io/badge/Swift-FA7343?style=for-the-badge&logo=swift&logoColor=white
[swift-url]: https://swift.org/
[macos]: https://img.shields.io/badge/macOS_LocalAuthentication-000000?style=for-the-badge&logo=apple&logoColor=white
[macos-url]: https://developer.apple.com/documentation/localauthentication
[github]: https://img.shields.io/badge/💻Github-000000?style=for-the-badge
[github-url]: https://github.com/vdutts7/applock-macos
[email]: https://img.shields.io/badge/me@vd7.io-FFCA28?style=for-the-badge&logo=Gmail&logoColor=00bbff&color=black
[email-url]: #
[twitter]: https://img.shields.io/badge/Twitter-FFCA28?style=for-the-badge&logo=Twitter&logoColor=00bbff&color=black
[twitter-url]: https://twitter.com/vdutts7/
