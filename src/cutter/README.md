
# Cutter (cutter)

A feature that installs Cutter

## Example Usage

```json
"features": {
    "ghcr.io/phorcys420/devcontainer-features/cutter:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Select the Cutter version (either 'latest' or a GitHub release tag) | string | latest |
| repository | Define the repository to grab releases from | string | rizinorg/cutter |

> [!WARNING]
> AppImages require FUSE to run by default, you can either run `cutter --appimage-extract-and-run` to extract the AppImage instead of using FUSE.
> Otherwise, you'll have to grant more privileges to your container, either by adding `SYS_ADMIN` to `capAdd` or by setting `privileged` to `true` in your `devcontainer.json` file.

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/phorcys420/devcontainer-features/blob/main/src/cutter/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
