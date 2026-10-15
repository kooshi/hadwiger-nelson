#!/usr/bin/env bash
# FS131-IKC3: elaborate each named probe file with `lake env lean`, one at a time, each under /usr/bin/time -v;
# log per file: <name>.log (Lean's output, then time's report). Run it under scripts/slot.py. Reads only.
set -u
cd /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wnf
source scripts/dev-env.sh
logdir="$1"; shift
mkdir -p "$logdir"
for f in "$@"; do
  n="$(basename "$f" .lean)"
  /usr/bin/time -v lake env lean "$f" > "$logdir/$n.log" 2>&1
  echo "$n exit $?" >> "$logdir/exits.txt"
done
