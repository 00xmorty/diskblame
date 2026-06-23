# diskblame — read-only public-ready packet

Prepared: 2026-06-23 15:07 CEST
Scope: release-style README packet for a public-facing diskblame candidate.
Status: ready for human review; no publish/deploy/repo-visibility action performed.

## One-line positioning

diskblame is a tiny read-only macOS zsh CLI that explains likely “System Data” disk usage buckets before a user deletes anything.

## Public README copy

### diskblame

macOS Storage often shows a large gray “System Data” category without explaining what is inside it. `diskblame` prints a terminal-first breakdown of common disk hog buckets so you can decide what to inspect next.

### What it does

- Shows a `df -h /` disk summary.
- Measures common user-level buckets with macOS built-ins.
- Sorts likely System Data contributors by size.
- Labels each bucket with a safety hint.
- Reports Time Machine local snapshot count when `tmutil` is available.

### What it does not do

- No sudo.
- No delete command.
- No automatic cleanup.
- No background agent.
- No file-content inspection.
- No upload, telemetry, or network call.

### Quick start

```sh
# Release target TBD: standalone repo or extracted release folder.
# From this repository today:
zsh products/diskblame/diskblame.zsh summary

# From a future standalone release:
chmod +x diskblame.zsh
./diskblame.zsh summary
```

### Commands

```sh
./diskblame.zsh summary
./diskblame.zsh scan
./diskblame.zsh help
./diskblame.zsh --version
```

### Safety labels

- `safe-to-review`: usually generated caches/logs, still inspect before removing manually.
- `caution`: can contain important app/user data; review app docs first.
- `manual-only`: use macOS-supported flows; diskblame will not modify it.

### Recommended user flow

1. Run `./diskblame.zsh summary`.
2. Review the largest bucket labels.
3. Inspect relevant app documentation and paths manually.
4. Expect scans over large folders to take a moment; the tool reports aggregate sizes only.
4. Delete nothing unless you understand the path and have backups.

## Release notes draft — v0.1.0

`diskblame` v0.1.0 is the first read-only diagnostic release.

Included:
- macOS disk summary for `/`.
- Common System Data bucket scan: Xcode data, iOS backups, user caches/logs, Homebrew/npm/pnpm/yarn caches, Docker data.
- Time Machine local snapshot count.
- Safety labels for manual review.

Safety boundary:
- read-only analysis only;
- no sudo;
- no cleanup command;
- no automatic deletion;
- no background process;
- aggregate sizes only.

## Included packet files

- `PUBLIC_READY_PACKET.md` — public README/release-style packet.
- `DEMO_TRANSCRIPT.md` — real local CLI transcript with username path sanitized to `<home>`.
- `SAMPLE_REPORT.md` — sample user-facing report based on the current command behavior.
- `SAFETY_POLICY.md` — explicit read-only/no automatic deletion policy.

## Pre-public review checklist

- [ ] Confirm no secrets or private notes are included in public package files.
- [ ] Confirm README examples do not include personal paths, internal repo paths, or tokens.
- [ ] Confirm `diskblame.zsh` still contains no deletion/sudo/background commands.
- [ ] Confirm smoke tests pass.
- [ ] Confirm any external posting remains Patron-approved and manual.

## Non-actions performed

No public repo was created, no release was published, no deployment was made, no external post was sent, no files were deleted, and no git commit/push was made.
