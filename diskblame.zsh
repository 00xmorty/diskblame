#!/usr/bin/env zsh
# diskblame
# Read-only macOS System Data disk usage explainer. No sudo, no delete commands.

set -u

VERSION="0.1.0"
TOP_N=20

usage() {
  cat <<'EOF'
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
EOF
}

has_cmd() { command -v "$1" >/dev/null 2>&1 }

human_size() {
  local target_path="$1"
  if [[ -e "$target_path" ]]; then
    du -sh "$target_path" 2>/dev/null | awk '{print $1}'
  else
    echo "-"
  fi
}

bytes_for_path() {
  local target_path="$1"
  if [[ -e "$target_path" ]]; then
    du -sk "$target_path" 2>/dev/null | awk '{print $1 * 1024}'
  else
    echo 0
  fi
}

bucket_label() {
  local bucket="$1"
  case "$bucket" in
    "Xcode DerivedData"|"Xcode Archives"|"Xcode DeviceSupport"|"Xcode iOS Device Logs"|"Homebrew cache"|"npm cache"|"pnpm store"|"yarn cache"|"User logs")
      echo "safe-to-review"
      ;;
    "User caches"|"Docker data"|"iOS backups")
      echo "caution"
      ;;
    "Time Machine local snapshots")
      echo "manual-only"
      ;;
    *)
      echo "review"
      ;;
  esac
}

print_disk_summary() {
  echo "Disk summary for /:"
  if has_cmd df; then
    df -h / | awk 'NR==1 || NR==2 { print "  " $0 }'
  else
    echo "  df not found."
  fi
}

time_machine_snapshot_count() {
  if has_cmd tmutil; then
    tmutil listlocalsnapshots / 2>/dev/null | wc -l | tr -d ' '
  else
    echo "unknown"
  fi
}

print_time_machine() {
  local count="$(time_machine_snapshot_count)"
  echo "Time Machine local snapshots: ${count} snapshots (manual-only)"
}

bucket_rows() {
  local home="${HOME}"
  local rows=(
    "Xcode DerivedData|${home}/Library/Developer/Xcode/DerivedData"
    "Xcode Archives|${home}/Library/Developer/Xcode/Archives"
    "Xcode DeviceSupport|${home}/Library/Developer/Xcode/iOS DeviceSupport"
    "Xcode iOS Device Logs|${home}/Library/Developer/Xcode/iOS Device Logs"
    "iOS backups|${home}/Library/Application Support/MobileSync/Backup"
    "User caches|${home}/Library/Caches"
    "User logs|${home}/Library/Logs"
    "Homebrew cache|${home}/Library/Caches/Homebrew"
    "npm cache|${home}/.npm"
    "pnpm store|${home}/Library/pnpm/store"
    "yarn cache|${home}/Library/Caches/Yarn"
    "Docker data|${home}/Library/Containers/com.docker.docker/Data"
  )

  local item name bucket_path bytes size label
  for item in "${rows[@]}"; do
    name="${item%%|*}"
    bucket_path="${item#*|}"
    bytes="$(bytes_for_path "$bucket_path")"
    size="$(human_size "$bucket_path")"
    label="$(bucket_label "$name")"
    printf "%s\t%s\t%s\t%s\t%s\n" "$bytes" "$size" "$label" "$name" "$bucket_path"
  done
}

print_scan() {
  echo "Likely System Data buckets (read-only):"
  printf "  %-8s %-15s %-24s %s\n" "SIZE" "SAFETY" "BUCKET" "PATH"
  bucket_rows | sort -nr | head -n "$TOP_N" | while IFS=$'\t' read -r bytes size label name bucket_path; do
    [[ "$bytes" == "0" ]] && continue
    printf "  %-8s %-15s %-24s %s\n" "$size" "$label" "$name" "$bucket_path"
  done
  echo
  print_time_machine
}

print_guidance() {
  cat <<'EOF'

Safety labels:
  safe-to-review: usually generated caches/logs, still inspect before removing manually.
  caution: can contain important app/user data; review app docs first.
  manual-only: use macOS-supported flows; diskblame will not modify it.
EOF
}

cmd_summary() {
  print_disk_summary
  echo
  print_scan
  print_guidance
}

main() {
  local cmd="${1:-help}"
  case "$cmd" in
    summary) cmd_summary ;;
    scan) print_scan; print_guidance ;;
    help|-h|--help) usage ;;
    version|-v|--version) echo "diskblame ${VERSION}" ;;
    *) echo "Unknown command: $cmd" >&2; usage; return 2 ;;
  esac
}

main "$@"
