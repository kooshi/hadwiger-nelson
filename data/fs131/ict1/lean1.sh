#!/usr/bin/env bash
# FS131-ICT1 iteration only (never evidence): elaborate one file with the lakefile's options, under a slot.
# Usage: lean1.sh <file.lean> [<out.olean>]   — log to data/fs131/ict1/logs/<basename>.out
set -uo pipefail
cd /home/kooshi/source/lean-dir/.claude/worktrees/kel1
f="$1"; b=$(basename "$f" .lean)
log="data/fs131/ict1/logs/$b.out"
extra=()
if [ $# -ge 2 ]; then extra=(-o "$2"); fi
SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem 6 --cpus 2 -- \
  lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false "${extra[@]}" "$f" > "$log" 2>&1
rc=$?
echo "exit $rc" >> "$log"
grep -v "^slot:" "$log" | head -c 20000
