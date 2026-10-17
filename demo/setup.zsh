#!/usr/bin/env zsh
# Source in a clean zsh -f shell before recording. No personal shell config.
export DEMO_ROOT="$(mktemp -d /tmp/cli-demo.XXXXXX)"
export PROMPT='user@mac ~/demo $ '
unset RPROMPT
export HOME="$DEMO_ROOT/home"
mkdir -p "$HOME/Library/Caches/Homebrew" "$HOME/Library/Logs" "$HOME/.npm" "$DEMO_ROOT/bin"
dd if=/dev/zero of="$HOME/Library/Caches/Homebrew/example.bin" bs=1048576 count=4 2>/dev/null
dd if=/dev/zero of="$HOME/.npm/example.bin" bs=1048576 count=2 2>/dev/null
printf 'illustrative log\n' > "$HOME/Library/Logs/example.log"
cat > "$DEMO_ROOT/bin/tmutil" <<'EOF'
#!/bin/sh
printf 'com.apple.TimeMachine.example\n'
EOF
cat > "$DEMO_ROOT/bin/df" <<'EOF'
#!/bin/sh
printf 'Filesystem Size Used Avail Capacity Mounted on\n/dev/demo 100Gi 40Gi 60Gi 40%% /\n'
EOF
chmod +x "$DEMO_ROOT/bin/tmutil" "$DEMO_ROOT/bin/df"
export PATH="$DEMO_ROOT/bin:$PATH"
setopt INTERACTIVE_COMMENTS
