# diskblame

A tiny read-only macOS CLI that explains what is probably hiding behind “System Data”.

## Why
macOS Storage often shows a huge gray “System Data” block without telling you what it contains. `diskblame` gives a terminal-first breakdown of common disk hogs so you can decide what to review next.

## Commands

```sh
./diskblame.zsh summary
./diskblame.zsh scan
./diskblame.zsh help
```

## Quick start

```sh
git clone https://github.com/00xmorty/diskblame.git
cd diskblame
chmod +x diskblame.zsh
./diskblame.zsh summary
```

No package install is required for v0.1.0. The script uses macOS built-ins such as `df`, `du`, and `tmutil` when available.

## Expected output

`summary` prints:
- a `df -h /` disk overview
- likely System Data buckets sorted by size
- safety labels for each bucket
- Time Machine local snapshot count when `tmutil` is available

## What it checks
- Xcode DerivedData, Archives, DeviceSupport and simulator data
- iOS device backups
- user caches and logs
- Homebrew cache
- npm/pnpm/yarn caches
- Docker data if visible
- Time Machine local snapshots summary

## Safety
v0.1.0 is read-only:
- no sudo
- no delete command
- no automatic cleanup
- no background agent
- aggregate sizes only; no file-content inspection

If you decide to remove anything, do it manually after checking the path and app-specific docs. `diskblame` intentionally explains; it does not clean.

Safety labels:
- safe-to-review: usually generated caches/logs, still inspect before removing manually.
- caution: can contain important app/user data; review app docs first.
- manual-only: use macOS-supported flows; diskblame will not modify it.

## Demo output

```text
Disk summary for /:
  Filesystem        Size    Used   Avail Capacity iused ifree %iused  Mounted on
  /dev/disk3s1s1   228Gi    12Gi    84Gi    13%    459k  879M    0%   /

Likely System Data buckets (read-only):
  SIZE     SAFETY          BUCKET                   PATH
  20G      caution         Docker data              /Users/morty/Library/Containers/com.docker.docker/Data
  10G      caution         User caches              /Users/morty/Library/Caches
  5.0G     safe-to-review  npm cache                /Users/morty/.npm
  2.6G     safe-to-review  Homebrew cache           /Users/morty/Library/Caches/Homebrew
  784K     safe-to-review  User logs                /Users/morty/Library/Logs

Time Machine local snapshots: 1 snapshots (manual-only)

Safety labels:
  safe-to-review: usually generated caches/logs, still inspect before removing manually.
  caution: can contain important app/user data; review app docs first.
  manual-only: use macOS-supported flows; diskblame will not modify it.
```
