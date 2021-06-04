# [<img src="https://assets.testapp.io/logo/blue.svg" alt="TestApp.io"/>](https://testapp.io/) CLI

> This is in BETA mode. Your feedback is highly appreciated.

This is the official CLI (ta-cli) for [TestApp.io](https://testapp.io) app distribution to upload your Android (APK) and iOS (IPA) directly from this command line and notifying your team members about the new releases if you enable it.

🎉 Join our [Slack](https://join.slack.com/t/testappio/shared_invite/zt-pvpoj3l2-epGYwGTaV3~3~0f7udNWoA) channel for feedback and support!

## Installation

##### macOS

```bash
curl -Ls https://raw.githubusercontent.com/testappio/cli/main/macos/install.sh | sh
```

##### Linux

```bash
curl -Ls https://raw.githubusercontent.com/testappio/cli/main/linux/install.sh | sh
```

##### Direct command

Navigate to [latest releases](https://github.com/testappio/cli/releases) and download the zip file relative to your OS to run the command `./ta-cli` or `./ta-cli.exe` directly without adding it to the OS binary folder.

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

Join our [Slack](https://join.slack.com/t/testappio/shared_invite/zt-pvpoj3l2-epGYwGTaV3~3~0f7udNWoA) channel for feedback and support or you can contact us at support@testapp.io and we'll gladly help you out!

---

Happy releasing 🎉
