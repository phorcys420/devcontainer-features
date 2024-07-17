> [!NOTE]
> Cutter only provides AppImages for Linux, and AppImages require FUSE to run.
> By default, this feature extracts the contents of the AppImage.
> If for some reason, you don't want this behavior, you can set `extractAppImage` to `false`.
> To run cutter, run `cutter --appimage-extract-and-run` to extract the AppImage instead of using FUSE.
> Otherwise, you'll have to grant more privileges to your container, either by adding `SYS_ADMIN` to `capAdd` or by setting `privileged` to `true` in your `devcontainer.json` file.