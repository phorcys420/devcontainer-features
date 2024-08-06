
# Ghidra (via GitHub Releases) (ghidra)

A feature that installs Ghidra

## Example Usage

```json
"features": {
    "ghcr.io/phorcys420/devcontainer-features/ghidra:1": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| version | Select the Ghidra version (either 'latest' or a GitHub release tag) | string | latest |
| repository | Define the repository to grab releases from | string | NationalSecurityAgency/ghidra |

> [!NOTE]
> This feature installs it's own JDK following the [official requirements](https://ghidra-sre.org/InstallationGuide.html#Requirements) using the [`java` feature](https://github.com/devcontainers/features/tree/main/src/java)

---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/phorcys420/devcontainer-features/blob/main/src/ghidra/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
