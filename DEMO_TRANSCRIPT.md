# diskblame — CLI demo transcript

Captured: 2026-06-23 on macOS.
Source command: `zsh products/diskblame/diskblame.zsh summary`.
Sanitization: local username path replaced with `<home>`.
Safety: command is read-only; it reports aggregate sizes and paths only.

```text
$ zsh products/diskblame/diskblame.zsh --version
diskblame 0.1.0

$ zsh products/diskblame/diskblame.zsh help
diskblame

Usage:
  ./diskblame.zsh summary
  ./diskblame.zsh scan
  ./diskblame.zsh help
  ./diskblame.zsh --version

Safety:
  - Read-only v0.1.0.
  - No sudo, no delete command, no background agent.
  - Reports aggregate sizes only; it does not inspect file contents.

$ zsh products/diskblame/diskblame.zsh summary
Disk summary for /:
  Filesystem        Size    Used   Avail Capacity iused ifree %iused  Mounted on
  /dev/disk3s1s1   228Gi    12Gi    58Gi    18%    459k  609M    0%   /

Likely System Data buckets (read-only):
  SIZE     SAFETY          BUCKET                   PATH
  21G      caution         Docker data              <home>/Library/Containers/com.docker.docker/Data
  11G      caution         User caches              <home>/Library/Caches
  5.8G     safe-to-review  npm cache                <home>/.npm
  2.6G     safe-to-review  Homebrew cache           <home>/Library/Caches/Homebrew
  1.0M     safe-to-review  User logs                <home>/Library/Logs

Time Machine local snapshots: 4 snapshots (manual-only)

Safety labels:
  safe-to-review: usually generated caches/logs, still inspect before removing manually.
  caution: can contain important app/user data; review app docs first.
  manual-only: use macOS-supported flows; diskblame will not modify it.
```

Note: sizes are machine-specific and will differ for every user.
