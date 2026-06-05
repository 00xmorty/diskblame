# diskblame v0.1.0

First public release of `diskblame`, a tiny read-only macOS CLI that explains likely “System Data” disk usage buckets before you delete anything.

## Highlights

- Explains common macOS System Data contributors in one terminal view.
- Checks Xcode leftovers, iOS backups, user caches/logs, Homebrew/npm/pnpm/yarn caches, Docker data, and Time Machine local snapshots.
- Uses safety labels: `safe-to-review`, `caution`, `manual-only`.
- Read-only by design: no sudo, no delete command, no cleanup automation, no background agent.
- Single zsh file with smoke tests and macOS GitHub Actions CI.

## Run

```sh
git clone https://github.com/00xmorty/diskblame.git
cd diskblame
chmod +x diskblame.zsh
./diskblame.zsh summary
```

## Verification

- `zsh -n diskblame.zsh`
- `bash tests/test_diskblame.sh`
- GitHub Actions CI on `macos-latest`

## Safety model

| Behavior | v0.1.0 |
| --- | --- |
| Requires sudo | No |
| Deletes files | No |
| Offers cleanup commands | No |
| Runs a daemon / LaunchAgent | No |
| Reports aggregate directory sizes | Yes |

If you want a tool that automatically frees disk space, this is not that tool. If you want an auditable first-pass explainer before manual review, this is that tool.
