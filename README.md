diskblame helps Mac users find likely contributors to the Storage settings’ “System Data” before deciding what to remove.

# diskblame

![Terminal demo — example output](assets/demo.gif)

## Install

In an empty directory, download the single executable release asset and make it executable:

```sh
curl -fsSLO https://github.com/00xmorty/diskblame/releases/download/v0.1.1/diskblame.zsh && chmod +x diskblame.zsh
```

This downloads a file; it does not execute a remote install script or change your PATH. Review it before running. [Release and asset](https://github.com/00xmorty/diskblame/releases/tag/v0.1.1) · [Source](./diskblame.zsh).

## Usage

```sh
./diskblame.zsh summary
./diskblame.zsh scan
./diskblame.zsh --help
```

## Example output

Illustrative fixture data; paths, process IDs, timings and sizes are examples, not claims about your Mac.

```text
Likely System Data buckets (read-only):
  SIZE     SAFETY          BUCKET                   PATH
  8.0K     caution         User caches              /Users/example/Library/Caches

Safety labels:
  safe-to-review: inspect generated caches and logs before removing anything.
```

## Requirements

- macOS 26.6.2 verified; older releases have not been verified in this preparation pass.
- zsh and the macOS df, du, awk, sort and head tools. tmutil is optional.
- No sudo or package manager is required to run the diagnostic.

## Safety and limits

Read-only diagnostics: no deletion, settings changes, background agent, process termination or automatic repair. It does not read file contents. No telemetry or network calls are made by the diagnostic. Downloading with curl is a separate install step.

This reports directory sizes, not the exact internal classification used by Storage settings. Permission-restricted paths may be absent. A safe-to-review label is an invitation to inspect, not permission to delete.

Review reports before sharing: local paths and process names may be sensitive. The GIF shows an example; the live snapshot can differ from the example.

## Development

```sh
bash tests/test_diskblame.sh
```

## License

[MIT](LICENSE).
