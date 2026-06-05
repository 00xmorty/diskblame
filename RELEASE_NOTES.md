# diskblame v0.1.0

First public release of `diskblame`, a tiny read-only macOS CLI that explains likely “System Data” disk usage buckets.

## Highlights
- Read-only disk usage summary for common macOS System Data buckets.
- Checks Xcode, iOS backups, user caches/logs, Homebrew/npm/pnpm/yarn caches, Docker data, and Time Machine local snapshots.
- Safety labels: `safe-to-review`, `caution`, `manual-only`.
- No sudo, no delete command, no cleanup automation, no background agent.

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
