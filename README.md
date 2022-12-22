# [<img src="https://assets.testapp.io/logo/blue.svg" alt="TestApp.io"/>](https://testapp.io/) CLI

> BETA mode. Your feedback is highly appreciated!

Official CLI (ta-CLI) for [TestApp.io](https://testapp.io) app distribution to upload your Android (APK) and iOS (IPA) directly from this command line and notify your team members to install and share feedback.

![TA-CLI Screenshot](https://user-images.githubusercontent.com/3076722/120862504-1f8e7f80-c59a-11eb-93ca-71f677855020.png)

## Installation

#### macOS & Linux

```sh
curl -Ls https://github.com/testappio/cli/releases/latest/download/install | bash
```

#### Windows

Currently, we are not supporting `ta-cli config` for Windows.

Download latest [windows release](https://github.com/testappio/cli/releases/latest/download/ta-cli_windows.zip) and unzip it

```sh
ta-cli.exe publish --api_token=[Your API Token] --app_id=[Your AppID] --release=android --apk=C:/path/to/app.apk
```

**OR using the config JSON:**

1. Create the config file in `$HOME/.ta-cli.json` and add the following:

You can use `vim` if installed `vim $HOME/.ta-cli.json`

```json
{
  "api_token": "Your API Token",
  "app_id": "Your App ID",
  "release": "both",
  "apk": "/user/path/to/android/app.apk",
  "ipa": "/user/path/to/ios/app.ipa",
  "release_notes": "",
  "git_release_notes": true,
  "git_commit_id": false,
  "archive_latest_release": false,
  "notify": true
}
```

2. From your terminal, navigate to the extracted folder

```sh
ta-cli.exe publish
```

#### Direct command

Navigate to [latest releases](https://github.com/testappio/cli/releases) and download the zip file relative to your OS to run the command `./ta-cli` or `./ta-cli.exe` directly without adding it to the OS binary folder.

## Configuration

```sh
ta-cli config
```

| Key                      | Description                                                                                                                          | Default            |
| ------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ | ------------------ |
| --config                 | path to your ta-cli.json config file [Optional]                                                                                      | $HOME/.ta-cli.json |
| --api_token              | You can get it from https://portal.testapp.io/settings/api-credentials                                                               |                    |
| --app_id                 | You can get it from your app page at [https://portal.testapp.io/apps](https://portal.testapp.io/apps?action=select-for-integrations) |                    |
| --release                | It can be either both or Android or iOS                                                                                              |                    |
| --apk_file               | Path to the Android APK file                                                                                                         |                    |
| --ipa_file               | Path to the iOS IPA file                                                                                                             |                    |
| --release_notes          | Manually add the release notes to be displayed for the testers                                                                       |                    |
| --git_release_notes      | Collect release notes from the latest git commit message to be displayed for the testers                                             | false              |
| --git_commit_id          | Include the last commit ID in the release notes (works with both release notes options)                                              | false              |
| --notify                 | Send notifications to your team members about this release                                                                           | false              |
| --archive_latest_release | Automatically archive the current latest release upon successful upload                                                              | false              |

The default configuration file will be at `$HOME/.ta-cli.json`

## Publish

```sh
ta-cli publish
```

To override any value in the config:

```sh
ta-cli publish --release=android --release_notes="my release notes" --git_release_notes=true --git_commit_id=true
```

## Config path

Default directories in order:

1. input path from `--config=`
2. .ta-cli.json
3. $HOME/.ta-cli.json

```sh
ta-cli publish --config=ta-cli.json
```

For more info about the list of options:

```sh
ta-cli publish -h
```

## Feedback & Support

Developers built [TestApp.io](https://testapp.io) to solve the pain of app distribution & feedback for mobile app development teams.

Join our [community](https://help.testapp.io/faq/join-our-community/) for feedback and support.

Check out our [Help Center](https://help.testapp.io/) for more info and other integrations.

Happy releasing 🎉
