> [!WARNING]
> AppImages require FUSE to run by default, you can either run `cutter --appimage-extract-and-run` to extract the AppImage instead of using FUSE.
> Otherwise, you'll have to grant more privileges to your container, either by adding `SYS_ADMIN` to `capAdd` or by setting `privileged` to `true` in your `devcontainer.json` file.