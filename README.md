<!--
  ta-cli - TestApp.io Command Line Interface
  Keywords: mobile app distribution, beta testing, APK upload, IPA upload,
  Android app distribution, iOS app distribution, CI/CD mobile,
  app testing, QA distribution, TestApp.io CLI, mobile DevOps
-->

<p align="center">
  <a href="https://testapp.io">
    <img src="https://assets.testapp.io/logo/blue.svg" alt="TestApp.io" width="200"/>
  </a>
</p>

<h1 align="center">ta-cli</h1>

<p align="center">
  <strong>The official CLI for TestApp.io app distribution</strong>
</p>

<p align="center">
  Upload your Android (APK) and iOS (IPA) apps directly from the command line.<br/>
  Notify your team instantly. Get feedback faster.
</p>

<p align="center">
  <a href="https://github.com/testappio/cli/releases/latest"><img src="https://img.shields.io/github/v/release/testappio/cli?label=version" alt="Latest Release"/></a>
  <a href="https://github.com/testappio/cli/releases"><img src="https://img.shields.io/github/downloads/testappio/cli/total" alt="Downloads"/></a>
  <a href="#supported-platforms"><img src="https://img.shields.io/badge/platform-macOS%20%7C%20Linux%20%7C%20Windows-blue" alt="Platforms"/></a>
  <a href="#license"><img src="https://img.shields.io/badge/license-Apache%202.0-green" alt="License"/></a>
</p>

---

## Quick Install

```bash
curl -Ls https://github.com/testappio/cli/releases/latest/download/install | bash
```

Works on **macOS** (Intel & Apple Silicon) and **Linux** (x86_64, ARM). For Windows, see [below](#windows).

---

## Table of Contents

- [What is ta-cli?](#what-is-ta-cli)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Commands](#commands)
- [Configuration](#configuration)
- [Environment Variables](#environment-variables)
- [CI/CD Integrations](#cicd-integrations)
- [Examples](#examples)
- [Supported Platforms](#supported-platforms)
- [Updating](#updating)
- [Troubleshooting](#troubleshooting)
- [Support](#support)

---

## What is ta-cli?

ta-cli lets you upload app builds to [TestApp.io](https://testapp.io) without leaving your terminal. Perfect for:

- **Local development** - Quick uploads while coding
- **CI/CD pipelines** - Automated releases on every build
- **Team collaboration** - Notify testers instantly with each release

**Features:**
- Upload Android APK and iOS IPA files
- Automatic app info extraction (version, bundle ID, etc.)
- Git integration for release notes
- Team notifications
- Chunked uploads with automatic retry
- Cross-platform support

---

## Installation

### macOS & Linux

```bash
curl -Ls https://github.com/testappio/cli/releases/latest/download/install | bash
```

This installs to `/usr/local/bin/ta-cli`.

### Windows

Download from [Releases](https://github.com/testappio/cli/releases/latest):

| File | Architecture |
|------|--------------|
| `ta-cli-Windows-x86_64.exe` | 64-bit (recommended) |
| `ta-cli-Windows-i686.exe` | 32-bit |

Rename to `ta-cli.exe` and add to your PATH, or run directly.

### Verify Installation

```bash
ta-cli version
```

---

## Quick Start

### 1. Get your credentials

| Credential | Where to find it |
|------------|------------------|
| **API Token** | [portal.testapp.io/profile/tokens](https://portal.testapp.io/profile/tokens) |
| **App ID** | Your app page → Integrations tab at [portal.testapp.io/apps](https://portal.testapp.io/apps) |

### 2. Configure (interactive)

```bash
ta-cli config
```

Follow the prompts to enter your credentials.

### 3. Publish your app

```bash
ta-cli publish
```

That's it! Your app is uploaded and your team is notified.

---

## Commands

### `ta-cli publish`

Upload your app to TestApp.io.

```bash
ta-cli publish [flags]
```

| Flag | Description | Default |
|------|-------------|---------|
| `--api_token` | Your API token | From config |
| `--app_id` | Your App ID | From config |
| `--release` | `android`, `ios`, or `both` | `both` |
| `--apk` | Path to Android APK file | From config |
| `--ipa` | Path to iOS IPA file | From config |
| `--release_notes` | Custom release notes | None |
| `--git_release_notes` | Use latest git commit as notes | `false` |
| `--git_commit_id` | Include commit ID in notes | `false` |
| `--notify` | Notify team members | `false` |
| `--archive_latest_release` | Archive previous release | `false` |
| `--config` | Custom config file path | `~/.ta-cli.json` |

### `ta-cli config`

Interactive configuration wizard.

```bash
ta-cli config
```

### `ta-cli version`

Display version information.

```bash
ta-cli version
```

### `ta-cli completion`

Generate shell autocompletion scripts.

```bash
# Bash
ta-cli completion bash > /etc/bash_completion.d/ta-cli

# Zsh
ta-cli completion zsh > "${fpath[1]}/_ta-cli"

# Fish
ta-cli completion fish > ~/.config/fish/completions/ta-cli.fish
```

---

## Configuration

### Config File

Location: `~/.ta-cli.json`

```json
{
  "api_token": "your_api_token",
  "app_id": "your_app_id",
  "release": "both",
  "apk": "/path/to/app.apk",
  "ipa": "/path/to/app.ipa",
  "release_notes": "",
  "git_release_notes": true,
  "git_commit_id": false,
  "notify": true,
  "archive_latest_release": false
}
```

### Custom Config Path

```bash
ta-cli publish --config=/path/to/custom-config.json
```

### Config Priority

1. Command-line flags (highest priority)
2. Config file specified by `--config`
3. `.ta-cli.json` in current directory
4. `~/.ta-cli.json` (default)

---

## Environment Variables

Use environment variables instead of config files (ideal for CI/CD):

| Variable | Description |
|----------|-------------|
| `TESTAPPIO_API_TOKEN` | Your API token |
| `TESTAPPIO_APP_ID` | Your App ID |
| `TESTAPPIO_RELEASE` | Release type: `android`, `ios`, or `both` |
| `TESTAPPIO_ANDROID_PATH` | Path to APK file |
| `TESTAPPIO_IOS_PATH` | Path to IPA file |
| `TESTAPPIO_NOTIFY` | Send notifications: `true` or `false` |
| `TESTAPPIO_RELEASE_NOTES` | Custom release notes |
| `TESTAPPIO_GIT_RELEASE_NOTES` | Use git commit as notes: `true` or `false` |
| `TESTAPPIO_GIT_COMMIT_ID` | Include commit ID: `true` or `false` |

Example:

```bash
export TESTAPPIO_API_TOKEN="your_token"
export TESTAPPIO_APP_ID="your_app_id"
ta-cli publish --apk=./app.apk --release=android
```

---

## CI/CD Integrations

ta-cli works with **any CI/CD platform** that supports bash. Just install and run!

### Quick Setup (Any CI/CD)

```bash
# 1. Install ta-cli
curl -Ls https://github.com/testappio/cli/releases/latest/download/install | bash

# 2. Upload your app
ta-cli publish \
  --api_token=$TESTAPPIO_API_TOKEN \
  --app_id=$TESTAPPIO_APP_ID \
  --apk=./app-release.apk \
  --release=android \
  --notify=true
```

### Dedicated Integrations (Recommended)

For the best experience, use our dedicated integrations with built-in auto-updates:

| Integration | Description | Link |
|-------------|-------------|------|
| **GitHub Action** | Native GitHub Actions integration | [testappio/github-action](https://github.com/testappio/github-action) |
| **Fastlane Plugin** | Native Fastlane plugin | [testappio/fastlane-plugin-testappio](https://github.com/testappio/fastlane-plugin-testappio) |

### Platform-Specific Guides

We have detailed guides for each CI/CD platform:

| Platform | Documentation |
|----------|---------------|
| GitHub Actions | [View Guide](https://help.testapp.io/github-action/) |
| Fastlane | [View Guide](https://help.testapp.io/fastlane-plugin/) |
| GitLab CI/CD | [View Guide](https://help.testapp.io/gitlab-ci-cd/) |
| Jenkins | [View Guide](https://help.testapp.io/jenkins/) |
| Bitrise | [View Guide](https://help.testapp.io/bitrise/) |
| CircleCI | [View Guide](https://help.testapp.io/circle-ci/) |
| Travis CI | [View Guide](https://help.testapp.io/travis-ci/) |
| Azure Pipelines | [View Guide](https://help.testapp.io/azure-pipeline/) |
| Codemagic | [View Guide](https://help.testapp.io/codemagic-ci-cd/) |
| Xcode Cloud | [View Guide](https://help.testapp.io/xcode-cloud/) |

**[View All Integrations →](https://help.testapp.io/topic/integrations/)**

---

## Examples

### Android Only

```bash
ta-cli publish \
  --release=android \
  --apk=./app-release.apk \
  --notify=true
```

### iOS Only

```bash
ta-cli publish \
  --release=ios \
  --ipa=./App.ipa \
  --notify=true
```

### Both Platforms

```bash
ta-cli publish \
  --release=both \
  --apk=./app-release.apk \
  --ipa=./App.ipa \
  --release_notes="Bug fixes and improvements" \
  --notify=true
```

### With Git Integration

```bash
ta-cli publish \
  --git_release_notes=true \
  --git_commit_id=true \
  --notify=true
```

### Archive Previous Release

```bash
ta-cli publish \
  --apk=./app-release.apk \
  --archive_latest_release=true \
  --notify=true
```

---

## Supported Platforms

### Operating Systems

| OS | Architectures | Binary |
|----|---------------|--------|
| **macOS** | Intel (x86_64), Apple Silicon (arm64), Universal | `ta-cli-Darwin-*` |
| **Linux** | x86_64, ARM64 (aarch64), ARMv7, i686 | `ta-cli-Linux-*` |
| **Windows** | x86_64 (64-bit), i686 (32-bit) | `ta-cli-Windows-*.exe` |

### Supported File Types

| Platform | File Type | Notes |
|----------|-----------|-------|
| Android | `.apk` | Debug or release signed APK |
| iOS | `.ipa` | Requires valid provisioning profile |

---

## Updating

Re-run the install script to update to the latest version:

```bash
curl -Ls https://github.com/testappio/cli/releases/latest/download/install | bash
```

Check your current version:

```bash
ta-cli version
```

---

## Uninstalling

```bash
sudo rm /usr/local/bin/ta-cli
rm ~/.ta-cli.json  # Optional: remove config
```

---

## Troubleshooting

### "command not found: ta-cli"

The binary isn't in your PATH:

```bash
# Option 1: Restart your terminal
# Option 2: Add to PATH manually
export PATH=$PATH:/usr/local/bin
# Option 3: Use full path
/usr/local/bin/ta-cli version
```

### Upload Fails or Hangs

1. **Check internet connection**
2. **Verify credentials** - Ensure API token and App ID are correct
3. **Validate your file** - Make sure the APK/IPA exists and isn't corrupted
4. **Retry** - The CLI has automatic retry with exponential backoff

### Invalid APK/IPA Error

- **APK**: Ensure it's a valid Android package with `AndroidManifest.xml`
- **IPA**: Ensure it contains `Info.plist` and a valid provisioning profile

### Config Issues

Reset your configuration:

```bash
rm ~/.ta-cli.json
ta-cli config
```

### Windows-Specific Issues

- Run Command Prompt or PowerShell as Administrator if needed
- Use forward slashes or escaped backslashes in paths: `C:/path/to/app.apk`

---

## API Reference

For advanced integrations, see the [TestApp.io API Documentation](https://help.testapp.io/api/).

---

## Support

| Resource | Link |
|----------|------|
| **Help Center** | [help.testapp.io](https://help.testapp.io/) |
| **CLI Documentation** | [help.testapp.io/ta-cli](https://help.testapp.io/ta-cli/) |
| **Email** | support@testapp.io |
| **Issues** | [GitHub Issues](https://github.com/testappio/cli/issues) |

---

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

---

## License

[Apache 2.0](LICENSE) - See [LICENSE](LICENSE) file for details.

---

<p align="center">
  <strong>Built with love by <a href="https://testapp.io">TestApp.io</a></strong><br/>
  <sub>Trusted by thousands of developers worldwide</sub><br/><br/>
  Happy releasing! 🎉
</p>
