
# Library - Common (lib-common)

A feature that contains the commonly used functions in devcontainer features to avoid rewriting code

## Example Usage

```json
"features": {
    "ghcr.io/phorcys420/devcontainer-features/lib-common:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| baseDir | Select the base directory where the library should be installed | string | /usr/share/phorcys-devcontainer-libraries |

> [!NOTE]
> This feature is meant to be used by other features as a library, not directly in a devcontainer template.

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/phorcys420/devcontainer-features/blob/main/src/lib-common/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
