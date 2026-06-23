# diskblame — sample report

This is a sample report format for a user who ran `./diskblame.zsh summary`.
It is diagnostic only. It is not a cleanup instruction.

## Summary

`diskblame` found several likely contributors to macOS “System Data” usage. The largest visible bucket is Docker data, followed by user caches and developer package caches.

## Example findings

| Size | Safety | Bucket | Path |
| ---: | --- | --- | --- |
| 21G | caution | Docker data | `<home>/Library/Containers/com.docker.docker/Data` |
| 11G | caution | User caches | `<home>/Library/Caches` |
| 5.8G | safe-to-review | npm cache | `<home>/.npm` |
| 2.6G | safe-to-review | Homebrew cache | `<home>/Library/Caches/Homebrew` |
| 1.0M | safe-to-review | User logs | `<home>/Library/Logs` |

Time Machine local snapshots: 4 snapshots (`manual-only`).

## Interpretation

- Docker data can be large and may include containers, images, volumes, and build cache. Use Docker Desktop or Docker CLI review commands before removing anything.
- User caches can contain disposable cache data, but they can also affect app state or performance. Inspect before manual deletion.
- npm and Homebrew caches are usually generated package-manager cache data, but still review the exact path and tool documentation first.
- Time Machine snapshots should be handled with macOS-supported flows. `diskblame` will not modify them.

## Safe next steps

1. Treat this as a measurement report, not an instruction to delete.
2. Start with the largest `caution` buckets and review official app/tool docs.
3. Prefer app-native cleanup tools where available.
4. Keep backups before manual cleanup.
5. Re-run `./diskblame.zsh summary` after any manual change to compare aggregate size changes.

## Safety boundary

`diskblame` does not delete files, does not run with sudo, does not install a background service, does not inspect file contents, and does not send data anywhere.
