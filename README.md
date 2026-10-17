# diskblame

diskblame helps Mac users find likely contributors to Storage settings’ “System Data” before deciding what to remove.

<p align="center">
  <img src="assets/demo.gif" alt="diskblame terminal demo" width="860">
</p>

<p align="center">
  <a href="https://github.com/00xmorty/diskblame/actions/workflows/ci.yml"><img alt="CI" src="https://img.shields.io/github/actions/workflow/status/00xmorty/diskblame/ci.yml?branch=main&label=CI&style=flat-square"></a>
  <a href="https://github.com/00xmorty/diskblame/releases/tag/v0.1.1"><img alt="Release v0.1.1" src="https://img.shields.io/badge/release-v0.1.1-brightgreen?style=flat-square"></a>
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square"></a>
  <img alt="macOS" src="https://img.shields.io/badge/platform-macOS-black?style=flat-square&logo=apple">
  <img alt="zsh" src="https://img.shields.io/badge/shell-zsh-89e051?style=flat-square">
</p>

## Why this exists

Storage settings show a broad category; cleaner apps focus on removing data. diskblame puts common directory sizes and review labels together so you can understand the likely contributors before choosing a cleanup method.

It answers how full the main disk is, which common buckets take space, and where to inspect manually. No sudo, cleanup command or background agent.

## Highlights

- 🧭 Explains likely macOS **System Data** buckets in one terminal view.
- 📦 Checks Xcode leftovers, iOS backups, caches, logs, Homebrew/npm/pnpm/yarn caches, Docker data, and Time Machine snapshots.
- 🛡️ Labels each bucket with `safe-to-review`, `caution`, or `manual-only`.
- 🔒 Read-only by design: no sudo, no delete command, no automatic cleanup.
- 🧰 Uses standard macOS command-line tools.
- 🧪 Ships with smoke tests and macOS GitHub Actions CI.
- 🪶 Single zsh file. Easy to read, copy, audit, and remove.

## Install

In an empty directory, download the single executable release asset and make it executable:

```sh
curl -fsSLO https://github.com/00xmorty/diskblame/releases/download/v0.1.1/diskblame.zsh && chmod +x diskblame.zsh
```

This downloads a file; it does not execute a remote install script or change your PATH. Review it before running. [Release and asset](https://github.com/00xmorty/diskblame/releases/tag/v0.1.1) · [Source](./diskblame.zsh).

For a source checkout:

```sh
git clone https://github.com/00xmorty/diskblame.git
cd diskblame
./diskblame.zsh summary
```

Optional user-local PATH install (add `~/bin` to your shell PATH):

```sh
mkdir -p ~/bin
cp diskblame.zsh ~/bin/diskblame
```

## Quick start

```sh
# Full diagnostic view
./diskblame.zsh summary

# Bucket list without the disk header
./diskblame.zsh scan

# Help / version
./diskblame.zsh help
./diskblame.zsh --version
```

## Command reference

### `summary`

Prints a compact disk overview, likely System Data buckets, Time Machine snapshot count, and safety label guidance.

```sh
./diskblame.zsh summary
```

Illustrative output: sizes and paths below are examples, not measurements of your Mac. Buckets can overlap, so do not add their sizes together.

```text
Likely System Data buckets (read-only):
  SIZE     SAFETY          BUCKET                   PATH
  20G      caution         Docker data              /Users/you/Library/Containers/com.docker.docker/Data
  10G      caution         User caches              /Users/you/Library/Caches
  5.0G     safe-to-review  npm cache                /Users/you/.npm
  2.6G     safe-to-review  Homebrew cache           /Users/you/Library/Caches/Homebrew

Time Machine local snapshots: 1 snapshots (manual-only)
```

### `scan`

Lists likely System Data buckets sorted by size, then prints safety guidance.

```sh
./diskblame.zsh scan
```

### `help`

Shows usage and the read-only safety promise.

```sh
./diskblame.zsh help
```

### `--version`

```sh
./diskblame.zsh --version
```

## What it checks

| Bucket | Typical path | Safety label |
| --- | --- | --- |
| Xcode DerivedData | `~/Library/Developer/Xcode/DerivedData` | `safe-to-review` |
| Xcode Archives | `~/Library/Developer/Xcode/Archives` | `safe-to-review` |
| Xcode DeviceSupport | `~/Library/Developer/Xcode/iOS DeviceSupport` | `safe-to-review` |
| iOS backups | `~/Library/Application Support/MobileSync/Backup` | `caution` |
| User caches | `~/Library/Caches` | `caution` |
| User logs | `~/Library/Logs` | `safe-to-review` |
| Homebrew cache | `~/Library/Caches/Homebrew` | `safe-to-review` |
| npm cache | `~/.npm` | `safe-to-review` |
| pnpm store | `~/Library/pnpm/store` | `safe-to-review` |
| yarn cache | `~/Library/Caches/Yarn` | `safe-to-review` |
| Docker data | `~/Library/Containers/com.docker.docker/Data` | `caution` |
| Time Machine local snapshots | reported via `tmutil` | `manual-only` |

## Safety model

Permission-restricted paths may be absent. These are common contributors, not an exact reconstruction of Storage settings. Reports can expose local paths; review them before sharing. The diagnostic makes no network requests and sends no telemetry.

`diskblame` is diagnostic-first.

| Behavior | Supported |
| --- | --- |
| Requires sudo | No |
| Deletes files | No |
| Offers cleanup commands | No |
| Runs a daemon / LaunchAgent | No |
| Inspects file contents | No |
| Reports aggregate directory sizes | Yes |
| Points to manual review paths | Yes |

Safety labels:

- `safe-to-review`: usually generated caches/logs, still inspect before removing manually.
- `caution`: can contain important app/user data; review app docs first.
- `manual-only`: use macOS-supported flows; `diskblame` will not modify it.

Review paths first, then use the relevant app or macOS cleanup flow yourself.

## FAQ

### Does it delete anything?

No. It has no delete command and performs no cleanup.

### Does it require sudo?

No. It uses standard macOS tools and runs as your user.

### Does it run in the background?

No. It is a single zsh script. Nothing remains running after the command exits.

### Why does it say “likely” System Data buckets?

macOS does not expose one clean public breakdown for the Storage UI’s “System Data” category. `diskblame` checks common contributors and shows their sizes so you can inspect them deliberately.

### Can I safely delete everything marked `safe-to-review`?

Do not delete blindly. The label means it is usually generated data, not that every file should be removed. Inspect the path and app-specific docs first.

### Why not use a cleaner app?

Cleaner apps can be useful, but this tool is for the step before cleanup: understanding what is taking space and avoiding destructive guesses.

## Requirements

- Tested on macOS 26.6.2.
- `zsh`
- Standard macOS tools: `df`, `du`, `awk`, `sort`, `head`
- Optional: `tmutil` for Time Machine local snapshot counts

## Test

```sh
bash tests/test_diskblame.sh
```

The smoke test covers syntax, help/version, summary/scan and unknown-command failure.

## Design principles

1. Explain before acting.
2. Prefer read-only diagnostics over cleanup magic.
3. Never require elevated privileges for basic disk understanding.
4. Make destructive behavior impossible because there is no destructive behavior.
5. Keep the whole tool small enough to audit in one sitting.

## Roadmap

- JSON output for scripting and dashboards.
- Better formatting for long paths.
- Optional threshold filters.
- Homebrew formula if the tool proves useful.
- More tests around missing optional tools and unusual path names.

Non-goals for now:

- Automatic cleanup.
- Background disk monitoring daemon.
- LaunchAgent installer.
- Cross-platform support.
- Replacing Time Machine / Xcode / Docker official cleanup flows.

## Contributing

Issues and small pull requests are welcome. Please keep the safety model intact: read-only, no sudo, no automatic cleanup.

Before opening a PR, run:

```sh
bash tests/test_diskblame.sh
```

## License

[MIT](LICENSE).
