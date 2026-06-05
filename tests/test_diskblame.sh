#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SCRIPT="$ROOT_DIR/diskblame.zsh"

zsh -n "$SCRIPT"

help_output="$(zsh "$SCRIPT" help)"
[[ "$help_output" == *"diskblame"* ]]
[[ "$help_output" == *"Read-only"* || "$help_output" == *"read-only"* ]]

version_output="$(zsh "$SCRIPT" --version)"
[[ "$version_output" == "diskblame 0.1.0" ]]

scan_output="$(zsh "$SCRIPT" scan)"
[[ "$scan_output" == *"Likely System Data buckets"* ]]
[[ "$scan_output" == *"Safety labels"* ]]
[[ "$scan_output" == *"Time Machine local snapshots"* ]]

summary_output="$(zsh "$SCRIPT" summary)"
[[ "$summary_output" == *"Disk summary for /"* ]]
[[ "$summary_output" == *"Likely System Data buckets"* ]]

if grep -Eq '(^|[[:space:];])(rm[[:space:]]+-rf|sudo[[:space:]]|kill[[:space:]]|launchctl[[:space:]]|osascript[[:space:]])' "$SCRIPT"; then
  echo "Unsafe command pattern found in diskblame.zsh" >&2
  exit 1
fi

echo "diskblame smoke tests passed"
