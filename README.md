# [<img src="https://assets.testapp.io/logo/blue.svg" alt="TestApp.io"/>](https://testapp.io/) CLI

> This is in BETA mode. Your feedback is highly appreciated.

This is the official CLI (ta-cli) for [TestApp.io](https://testapp.io) app distribution to upload your Android (APK) and iOS (IPA) directly from this command line and notifying your team members about the new releases if you enable it.

🎉 Join our [Slack](https://join.slack.com/t/testappio/shared_invite/zt-pvpoj3l2-epGYwGTaV3~3~0f7udNWoA) channel for feedback and support!

![Screen Shot 2021-06-05 at 12 50 14 AM](https://user-images.githubusercontent.com/3076722/120862504-1f8e7f80-c59a-11eb-93ca-71f677855020.png)

## Installation

#### MacOS & Linux

```bash
curl -Ls https://github.com/testappio/cli/releases/latest/download/install | bash
```

#### Widnows

Currently, we are not supporting `ta-cli config` for Windows.

Download latest [windows release](https://github.com/testappio/cli/releases/latest/download/ta-cli_windows.zip) and unzip it

```
ta-cli.exe publish --api_token=[Your API Token] --app_id=[Your AppID] --release=android --apk=C:/path/to/app.apk
```

**OR using the config json:**

1. Create the config file in `$HOME/.ta-cli.json` and add the following:

You can use `vim` if installed `vim $HOME/.ta-cli.json`

```bash
{
  "api_token": "Your API Token",
  "app_id": "Your App ID",
  "release": "android",
  "apk": "/path/to/android/app.apk",
  "ipa": "",
  "notify": "yes"
}
```

2. From your terminal navitage to the extracted folder

```
ta-cli.exe publish
```

#### Direct command

Navigate to [latest releases](https://github.com/testappio/cli/releases) and download the zip file relative to your OS to run the command `./ta-cli` or `./ta-cli.exe` directly without adding it to the OS binary folder.

## Configuration

```bash
ta-cli config
```

> `api_token`: You can get it from https://portal.testapp.io/settings/api-credentials

> `app_id`: You can get it from your app page in https://portal.testapp.io/apps

> `release`: It can be either `both` or `android` or `ios`

> `apk`: /full/path/to/app.apk (if you select release `both` or `android`)

> `ipa`: /full/path/to/app.ipa (if you select release `both` or `ios`)

> `notify`: Send notificaitons to the app members about this release: `yes` or `no`

The default configuration file will be at `$HOME/.ta-cli.json`

## Publish

```bash
ta-cli publish
```

To override any value in the config:

```bash
ta-cli publish --release=android
```

For more info about list of options:

```bash
ta-cli publish -h
```

## Feedback & Support

Join our [Slack](https://join.slack.com/t/testappio/shared_invite/zt-pvpoj3l2-epGYwGTaV3~3~0f7udNWoA) channel for feedback and support or you can contact us at support@testapp.io and we'll gladly help you out!

---

Happy releasing 🎉
