
# Android SDK (via Google CDN) (android-sdk)

A feature that installs the Android command line tools and SDK

## Example Usage

```json
"features": {
    "ghcr.io/phorcys420/devcontainer-features/android-sdk:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Select the Android command line tools version ('latest' is not supported) | string | 11076708 |
| installMavenRepos | Whether or not to install the Android and Google Maven repos | boolean | true |
| installPlayServices | Whether or not to install Play Services | boolean | true |
| installEmulator | Whether or not to install the Android Emulator (NOTE: you still have to install the images yourself using sdkmanager) | boolean | false |

> [!NOTE]
>  It's fine if we let `version` run out of date since it's rarely updated.
> (version from "Command line tools only" section @ https://developer.android.com/studio?hl=en)

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/phorcys420/devcontainer-features/blob/main/src/android-sdk/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
