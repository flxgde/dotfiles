#!/bin/bash
export PATH=/usr/local/bin:/usr/bin:/bin
export HOME="${HOME:-$(getent passwd $(id -u) | cut -d: -f6)}"

LOCK_FILE="/tmp/waybar-updates-lock"
CACHE_FILE="/tmp/waybar-updates-count"

# Acquire lock so only one process runs at a time
(
  flock -n 9 || exit 1
  repo_updates=$(/usr/bin/checkupdates 2>/dev/null | wc -l)
  aur_updates=$(/usr/bin/yay -Qua 2>/dev/null | wc -l)
  echo $((repo_updates + aur_updates)) > "$CACHE_FILE"
) 9>"$LOCK_FILE"

cat "$CACHE_FILE"

