# [<img src="https://assets.testapp.io/logo/blue.svg" alt="TestApp.io"/>](https://testapp.io/) CLI

> This is in BETA mode. Your feedback is highly appreciated.

This is the official CLI for the [TestApp.io](https://testapp.io) app distribution,
allowing you to distribute for both Android & iOS and notify your team members.

## Installation

`ta-cli` is available for download via multiple mechanisms.

### macOS

Install the latest `amd64` version without automatic updates:

```bash
curl -Ls https://raw.githubusercontent.com/testappio/cli/main/macos/install.sh | sh
```

### Configuration

```bash
ta-cli help
```

Create a `config.json` somewhere:

```json
{
  "apiToken": "Your API Token",
  "appID": "Your App ID",
  "release": "both",
  "apk": "/path/to/file.apk",
  "ipa": "/path/to/file.ipa",
  "notify": "yes"
}
```

And then

```bash
ta-cli publish --config=/path/to/config.json
```

> apiToken: You can get it from https://portal.testapp.io/settings/api-credentials

> appID: You can get it from the App page

> release: It can be either "both" or "android" or "ios"

> notify: Send notificaitons to the app members about this release: "yes" or "no"

You can also override any value:

```bash
ta-cli publish --config=/path/to/config.json --release=android
```

For more info:

```bash
ta-cli publish -h
```

### Feedback & Support

Reach out to us via chat or send us email at support@testapp.io and we'll gladly help you out!

---

Happy Releasing 🎉
