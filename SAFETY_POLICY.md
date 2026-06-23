# diskblame — safety policy

## Policy

`diskblame` is a read-only diagnostic tool. Its job is to explain likely macOS “System Data” disk usage buckets, not to clean them.

## Hard boundaries

The tool must not:

- delete files or directories;
- move files;
- modify permissions;
- run `sudo`;
- kill processes;
- unload services or agents;
- install a LaunchAgent, daemon, login item, or background process;
- upload data or call external network services;
- inspect private file contents;
- hide destructive behavior behind flags such as `--clean`, `--fix`, `--force`, or `--auto`.

## Allowed behavior

The tool may:

- run read-only macOS commands such as `df`, `du`, and `tmutil listlocalsnapshots /`;
- check whether known user-level paths exist;
- report aggregate sizes;
- print paths for manual user review;
- label buckets with conservative safety guidance.

## User guidance

Users should treat all output as a starting point for manual investigation. A `safe-to-review` label does not mean “safe to delete automatically.” It means the bucket is usually generated data and worth inspecting.

`caution` buckets may contain important app data, user data, backups, Docker volumes, or project state. Use app-native cleanup flows where possible.

`manual-only` buckets require macOS-supported or app-supported procedures. `diskblame` must never modify them.

## Release gate

Before any release or public packet update, verify:

```sh
zsh -n products/diskblame/diskblame.zsh
bash tests/test_diskblame.sh
grep -En '(^|[[:space:];])(rm[[:space:]]+-rf|sudo[[:space:]]|kill[[:space:]]|launchctl[[:space:]]|osascript[[:space:]]|curl[[:space:]]|wget[[:space:]]|nc[[:space:]]|ssh[[:space:]]|scp[[:space:]]|rsync[[:space:]])' products/diskblame/diskblame.zsh || true
```

Expected result: syntax check passes, smoke tests pass, and the unsafe-command grep returns no matches.
